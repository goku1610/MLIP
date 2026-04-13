#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
WORK_DIR="${WORK_DIR:-$ROOT_DIR/cu4tise4_workflow/out}"

MLP_BIN="$ROOT_DIR/mlip-2/bin/mlp"
MLP_TEMPLATE="$ROOT_DIR/mlip-2/untrained_mtps/22.mtp"
TRAIN_CFG="${TRAIN_CFG:-$ROOT_DIR/train_set.cfg}"
TEST_CFG="${TEST_CFG:-$ROOT_DIR/test_set.cfg}"

INIT_MTP="$WORK_DIR/cu4tise4_level22_init.mtp"
TRAINED_MTP="$WORK_DIR/cu4tise4_trained.mtp"
CURRENT_MTP="$WORK_DIR/cu4tise4_current.mtp"
TRAIN_LOG="$WORK_DIR/train.log"
TEST_LOG="$WORK_DIR/test_errors.log"
MLIP_INI="$WORK_DIR/mlip.ini"

MAX_ITER="${MAX_ITER:-1000}"
ENERGY_WEIGHT="${ENERGY_WEIGHT:-1}"
FORCE_WEIGHT="${FORCE_WEIGHT:-0.01}"
STRESS_WEIGHT="${STRESS_WEIGHT:-0.001}"
MPI_NP="${MPI_NP:-1}"
RESUME_FROM="${RESUME_FROM:-}"
APPEND_LOG="${APPEND_LOG:-false}"

classify_train_stage() {
  local log_file="$1"

  if [[ ! -f "$log_file" ]]; then
    echo "starting"
    return
  fi

  # If we resumed, only look at log content after the last resume separator
  # so that old log lines don't pollute the stage detection
  local resume_line
  resume_line=$(grep -n "^--- RESUMED at" "$log_file" | tail -1 | cut -d: -f1)

  local recent
  if [[ -n "$resume_line" ]]; then
    recent=$(tail -n +"$resume_line" "$log_file")
  else
    recent=$(cat "$log_file")
  fi

  if echo "$recent" | grep -q "BFGS" || echo "$recent" | grep -q "Pre-training ended"; then
    echo "stage 3/4 main fit"
  elif echo "$recent" | grep -q "Pre-training started"; then
    echo "stage 2/4 pre-training"
  elif echo "$recent" | grep -q "Rescaling..."; then
    echo "stage 1/4 pre-init rescale"
  elif echo "$recent" | grep -q "Random initialization of radial coefficients"; then
    echo "stage 1/4 random initialization"
  else
    echo "stage 1/4 setup"
  fi
}


run_with_heartbeat() {
  local mode="$1"
  local log_file="$2"
  shift 2

  local start_ts now elapsed
  start_ts="$(date +%s)"

  if [[ "$APPEND_LOG" == "true" ]]; then
    "$@" > >(tee -a "$log_file") 2>&1 &
  else
    "$@" > >(tee "$log_file") 2>&1 &
  fi
  local cmd_pid=$!
  local stage_msg current_age

  while kill -0 "$cmd_pid" 2>/dev/null; do
    sleep 30
    if kill -0 "$cmd_pid" 2>/dev/null; then
      now="$(date +%s)"
      elapsed=$((now - start_ts))

      if [[ "$mode" == "train" ]]; then
        stage_msg="$(classify_train_stage "$log_file")"
        if [[ -f "$CURRENT_MTP" ]]; then
          current_age=$((now - $(stat -c %Y "$CURRENT_MTP")))
          echo "[train_and_eval] ${stage_msg}; elapsed=${elapsed}s; current checkpoint updated ${current_age}s ago"
        else
          echo "[train_and_eval] ${stage_msg}; elapsed=${elapsed}s; no live checkpoint yet"
        fi
      else
        echo "[train_and_eval] stage 4/4 held-out error evaluation; elapsed=${elapsed}s"
      fi
    fi
  done

  wait "$cmd_pid"
}

run_mlp() {
  if [[ "$MPI_NP" -gt 1 ]]; then
    mpirun -np "$MPI_NP" "$@"
  else
    "$@"
  fi
}

mkdir -p "$WORK_DIR"

if [[ ! -x "$MLP_BIN" ]]; then
  echo "Building mlip-2/bin/mlp..."
  make -C "$ROOT_DIR/mlip-2" mlp
fi

if [[ ! -f "$TRAIN_CFG" || ! -f "$TEST_CFG" ]]; then
  echo "Missing train_set.cfg or test_set.cfg in $ROOT_DIR" >&2
  exit 1
fi

echo "Generating Cu4TiSe4 level-22 initializer at $INIT_MTP"
awk '
  /^species_count = / { print "species_count = 3"; next }
  /min_dist = / { print "\tmin_dist = 2.06"; next }
  /max_dist = / { print "\tmax_dist = 8.5"; next }
  { print }
' "$MLP_TEMPLATE" > "$INIT_MTP"

cat > "$MLIP_INI" <<EOF
mtp-filename    $TRAINED_MTP
select          FALSE
EOF

# Determine starting MTP: checkpoint or fresh init
if [[ -n "$RESUME_FROM" ]]; then
  if [[ ! -f "$RESUME_FROM" ]]; then
    echo "ERROR: RESUME_FROM file not found: $RESUME_FROM" >&2
    exit 1
  fi
  START_MTP="$RESUME_FROM"
  APPEND_LOG="true"
  echo ""
  echo "========================================="
  echo "  RESUMING FROM CHECKPOINT"
  echo "  Checkpoint : $START_MTP"
  echo "  Log will be APPENDED to: $TRAIN_LOG"
  echo "========================================="
  echo ""
  {
    echo ""
    echo "--- RESUMED at $(date) from checkpoint: $START_MTP ---"
    echo ""
  } >> "$TRAIN_LOG"
else
  START_MTP="$INIT_MTP"
  APPEND_LOG="false"
  echo "Starting fresh training from: $START_MTP"
fi

echo "Training Cu4TiSe4 MTP..."
echo "[train_and_eval] stage 1/4 setup and initialization"
if [[ "$MPI_NP" -gt 1 ]]; then
  echo "[train_and_eval] using MPI with ${MPI_NP} ranks"
fi
run_with_heartbeat "train" "$TRAIN_LOG" \
  run_mlp stdbuf -oL -eL "$MLP_BIN" train "$START_MTP" "$TRAIN_CFG" \
  --valid-cfgs="$TEST_CFG" \
  --energy-weight="$ENERGY_WEIGHT" \
  --force-weight="$FORCE_WEIGHT" \
  --stress-weight="$STRESS_WEIGHT" \
  --max-iter="$MAX_ITER" \
  --curr-pot-name="$CURRENT_MTP" \
  --trained-pot-name="$TRAINED_MTP"

echo "Calculating held-out errors..."
echo "[train_and_eval] stage 4/4 held-out error evaluation"
run_with_heartbeat "test" "$TEST_LOG" \
  run_mlp stdbuf -oL -eL "$MLP_BIN" calc-errors "$TRAINED_MTP" "$TEST_CFG"

echo
echo "Done."
echo "Trained potential: $TRAINED_MTP"
echo "Training log:     $TRAIN_LOG"
echo "Current fit:      $CURRENT_MTP"
echo "Test error log:   $TEST_LOG"
echo "LAMMPS mlip.ini:  $MLIP_INI"
