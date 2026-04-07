#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
MLP_DIR="$ROOT_DIR/mlip-2"
LAMMPS_BIN="$ROOT_DIR/lmp_mpi"
MLP_BIN="$MLP_DIR/bin/mlp"
MLP_LIB="$MLP_DIR/lib/lib_mlip_interface.a"

echo "Preparing MLIP/LAMMPS runtime in $ROOT_DIR"

if [[ ! -x "$MLP_BIN" ]]; then
  echo "Building mlip executable..."
  make -C "$MLP_DIR" mlp
fi

if [[ ! -f "$MLP_LIB" ]]; then
  echo "Building MLIP interface library..."
  make -C "$MLP_DIR" libinterface
fi

if [[ -f "$LAMMPS_BIN" ]]; then
  chmod +x "$LAMMPS_BIN"
  if "$LAMMPS_BIN" -help | rg -q '^mlip[[:space:]]'; then
    echo "LAMMPS MLIP pair style is available."
  else
    echo "LAMMPS binary exists but pair_style mlip was not found in -help output." >&2
    exit 1
  fi
else
  echo "Expected LAMMPS binary at $LAMMPS_BIN was not found." >&2
  exit 1
fi

echo
echo "Runtime looks ready:"
echo "  mlp:      $MLP_BIN"
echo "  interface $MLP_LIB"
echo "  lammps:   $LAMMPS_BIN"
