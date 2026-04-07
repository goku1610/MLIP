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
TRAIN_LOG="$WORK_DIR/train.log"
TEST_LOG="$WORK_DIR/test_errors.log"
MLIP_INI="$WORK_DIR/mlip.ini"

MAX_ITER="${MAX_ITER:-1000}"
ENERGY_WEIGHT="${ENERGY_WEIGHT:-1}"
FORCE_WEIGHT="${FORCE_WEIGHT:-0.01}"
STRESS_WEIGHT="${STRESS_WEIGHT:-0.001}"

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

echo "Training Cu4TiSe4 MTP..."
stdbuf -oL -eL "$MLP_BIN" train "$INIT_MTP" "$TRAIN_CFG" \
  --valid-cfgs="$TEST_CFG" \
  --energy-weight="$ENERGY_WEIGHT" \
  --force-weight="$FORCE_WEIGHT" \
  --stress-weight="$STRESS_WEIGHT" \
  --max-iter="$MAX_ITER" \
  --trained-pot-name="$TRAINED_MTP" 2>&1 | tee "$TRAIN_LOG"

echo "Calculating held-out errors..."
stdbuf -oL -eL "$MLP_BIN" calc-errors "$TRAINED_MTP" "$TEST_CFG" 2>&1 | tee "$TEST_LOG"

echo
echo "Done."
echo "Trained potential: $TRAINED_MTP"
echo "Training log:     $TRAIN_LOG"
echo "Test error log:   $TEST_LOG"
echo "LAMMPS mlip.ini:  $MLIP_INI"
