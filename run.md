# Run Guide for Windows

This project is easiest to run on Windows through WSL2, not native
PowerShell or `cmd`.

Why:

- the workflow scripts are Bash scripts
- the current MLIP and LAMMPS binaries in this repo are Linux binaries
- `mpirun`, `make`, and the build flow are already Linux-oriented

This guide assumes all project files are already present in your Windows
machine and available inside WSL at a path like:

```text
/home/<your-user>/coding/mlip
```

## Recommended setup

Use:

- Windows 11 or Windows 10 with WSL2
- Ubuntu inside WSL
- a terminal inside WSL

## 1. Open WSL and go to the repo

```bash
cd /home/<your-user>/coding/mlip
```

Example:

```bash
cd /home/saksham/coding/mlip
```

## 2. Install required tools in WSL

If they are not already installed:

```bash
sudo apt update
sudo apt install -y build-essential cmake gfortran openmpi-bin libopenmpi-dev ripgrep
```

## 3. Confirm the important files exist

```bash
ls -lah
```

You should see at least:

- `mlip-2/`
- `cu4tise4_workflow/`
- `train_set.cfg`
- `test_set.cfg`
- `lmp_mpi`

## 4. Prepare the runtime

This checks MLIP and LAMMPS and builds MLIP pieces if needed.

```bash
./cu4tise4_workflow/prepare_runtime.sh
```

Expected output includes something like:

```text
LAMMPS MLIP pair style is available.
Runtime looks ready:
```

## 5. Start training

Single-rank run:

```bash
./cu4tise4_workflow/train_and_eval.sh
```

Multi-core MPI run:

```bash
MPI_NP=8 ./cu4tise4_workflow/train_and_eval.sh
```

You can try larger values too:

```bash
MPI_NP=12 ./cu4tise4_workflow/train_and_eval.sh
MPI_NP=16 ./cu4tise4_workflow/train_and_eval.sh
```

Do not jump straight to the maximum core count unless you have already tested
that it helps.

## 6. Monitor progress

In another WSL terminal:

```bash
tail -f /home/<your-user>/coding/mlip/cu4tise4_workflow/out/train.log
```

You can also check whether the process is still running:

```bash
ps -ef | grep 'mlp train' | grep -v grep
```

If using MPI:

```bash
ps -ef | grep -E 'mpirun|mlp train' | grep -v grep
```

## 7. Output files

Training output goes to:

```text
cu4tise4_workflow/out/
```

Important files:

- `cu4tise4_level22_init.mtp`
- `cu4tise4_current.mtp`
- `cu4tise4_trained.mtp`
- `train.log`
- `test_errors.log`
- `mlip.ini`

## 8. Restart cleanly if needed

If a previous training run is still active:

```bash
pkill -f '/home/<your-user>/coding/mlip/mlip-2/bin/mlp train' || true
```

Example:

```bash
pkill -f '/home/saksham/coding/mlip/mlip-2/bin/mlp train' || true
```

Then restart:

```bash
MPI_NP=8 ./cu4tise4_workflow/train_and_eval.sh
```

## 9. Common note about Windows

Do not try to run these exact commands directly in:

- PowerShell
- Command Prompt

Use WSL Bash instead.

The current `lmp_mpi` and `mlip-2/bin/mlp` are Linux executables, so native
Windows shells will not run them directly.

## 10. Optional alternate output folder

If you want a separate run directory:

```bash
WORK_DIR=/home/<your-user>/coding/mlip/cu4tise4_workflow/out_run2 MPI_NP=8 ./cu4tise4_workflow/train_and_eval.sh
```

## 11. Minimal command sequence

If everything is already installed:

```bash
cd /home/<your-user>/coding/mlip
./cu4tise4_workflow/prepare_runtime.sh
MPI_NP=8 ./cu4tise4_workflow/train_and_eval.sh
```

Example:

```bash
cd /home/saksham/coding/mlip
./cu4tise4_workflow/prepare_runtime.sh
MPI_NP=8 ./cu4tise4_workflow/train_and_eval.sh
```

## 12. Current scope

This workflow currently covers:

- MLIP runtime preparation
- Cu4TiSe4 MTP training
- held-out error evaluation

It does not yet fully reproduce:

- the paper's full active-learning generation loop
- the exact modified Green-Kubo heat-current implementation
- the paper's final thermal-conductivity reproduction end to end
