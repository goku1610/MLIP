# Cu4TiSe4 Workflow

This folder contains a paper-specific workflow for the Cu4TiSe4
moment tensor potential described in [research_paper.md](/home/saksham/coding/mlip/research_paper.md).

What this workflow does now:

- builds the MLIP `mlp` executable if it is missing
- generates a 3-species level-22 initializer from the bundled MLIP template
- trains on `/home/saksham/coding/mlip/train_set.cfg`
- evaluates on `/home/saksham/coding/mlip/test_set.cfg`
- writes a simple `mlip.ini` for later LAMMPS use

Start by preparing the local runtime from the repo root:

```bash
./cu4tise4_workflow/prepare_runtime.sh
```

Then launch the paper-style MTP fit:

```bash
./cu4tise4_workflow/train_and_eval.sh
```

Useful environment overrides:

```bash
MAX_ITER=1000 ./cu4tise4_workflow/train_and_eval.sh
WORK_DIR=/tmp/cu4tise4_run ./cu4tise4_workflow/train_and_eval.sh
TRAIN_CFG=/path/to/train.cfg TEST_CFG=/path/to/test.cfg ./cu4tise4_workflow/train_and_eval.sh
```

Outputs are written to `cu4tise4_workflow/out/` by default.

Paper parameters currently encoded in the workflow:

- level-22 MTP basis
- 3 atomic species
- `min_dist = 2.06`
- `max_dist = 8.5`
- `We = 1`, `Wf = 0.01`, `Ws = 0.001`

What this does not yet reproduce:

- the active-learning data generation loop used to grow the dataset from 400 to
  939 configurations
- the paper's exact Green-Kubo thermal-conductivity workflow
- the modified MLIP heat-current implementation based on Fan's many-body virial
  stress formalism

Important limitation:

This reproduces the training and basic validation stage of the paper workflow.
The paper's exact Green-Kubo thermal-conductivity calculations relied on a
modified MLIP heat-current implementation, so matching the published `k_L`
values exactly may still require that modified code path.
