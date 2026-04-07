# Machine Learning Interatomic Potentials (MTP) Pipeline

[![Python](https://img.shields.io/badge/Python-3.8+-blue.svg)]()
[![MLIP](https://img.shields.io/badge/MLIP-Active%20Learning-green.svg)]()

## Project Overview
This repository contains a complete workflow for developing **Moment Tensor Potentials (MTP)**—a class of machine learning interatomic potentials—for **Tungsten (W)** and **Gallium Arsenide (GaAs)**.

The goal of this project is to bridge the gap between the high accuracy of *ab initio* Density Functional Theory (DFT) and the computational scalability of classical Molecular Dynamics (MD). By training MTP models on quantum mechanical data, we enable large-scale atomistic simulations with near-quantum accuracy at a fraction of the cost.

### Key Features
* **Data Processing Pipeline:** Custom Python scripts to parse raw Quantum Espresso logs into ML-ready datasets
* **BOMD Data Generation:** Workflow for generating training data using Born-Oppenheimer Molecular Dynamics
* **Model Training:** MTP training using the mlip-3 package 
* **Validation:** Integration with LAMMPS to calculate elastic properties

##  Repository Structure

```bash
mlip/
│
├── run_preprocessing.bat            # Batch script to automate the full data processing pipeline
├── requirements.txt                 # Python dependencies
├── README.md                        # Project documentation
│
├── scripts/                         # data processing scripts
│   ├── out2csv.py                   # Parses .out files to structured CSV
│   └── csv2cfg.py                   # Converts CSV to MLIP .cfg training format
│
├── training_config/                 # MTP hyperparameters
│   └── mtp_init.almtp               # Initialization settings for potential training
│
├── validation/                      # Testing scripts
│   └── lammps_elastic.in            # LAMMPS input for calculating elastic constants
│
└── data_samples/                    # Sample data for testing the pipeline
    ├── qe_md.in                     # Sample Quantum Espresso Input (W Supercell)
    ├── qe_md.out                    # Sample Raw Output (Truncated)
    ├── extracted.csv                # Intermediate parsed data
    └── sample_training_set.cfg      # Final formatted training data
```

## Data Collection & Results

### Data Generation (BOMD)

Training data was generated using **Quantum Espresso**.

  * **System:** Tungsten ($3\times3\times3$ Supercell) and GaAs ($3\times3\times3$ Supercell)
  * **Simulation Type:** `vc-md` (Variable Cell Molecular Dynamics)
  * **Conditions:** Temperatures of 500K, 1500K, and 2500K; Strains of $\pm5\%$ and $\pm10\%$ (Tensile/Compressive).

### Validation Results

The potentials were validated by simulating elastic constants in LAMMPS and comparing them to experimental benchmarks.

| Material | Property | Simulation (MTP) | Actual (Ref) |
|----------|----------|------------------|--------------|
| **Tungsten** | Bulk Modulus | 363.84 GPa | 310 GPa |
| **Tungsten** | Poisson's Ratio| 0.20 | 0.28 |
| **GaAs** | Bulk Modulus | 84.17 GPa | 75.5 GPa |
| **GaAs** | Poisson's Ratio| 0.32 | 0.31 |



## 🚀 Usage Instructions

### 1\. Prerequisites

Ensure you have Python installed. It is recommended to use a virtual environment.

```bash
# Create and activate virtual environment
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt
```

*Note: This project also requires the [MLIP Package](https://mlip.skoltech.ru/) and [LAMMPS](https://www.lammps.org/) with the MLIP interface installed.*

### 2\. Data Preprocessing (Python)

We provide scripts to convert raw DFT logs into the `.cfg` format required by MTP.

**A. Run Individual Scripts**
To process a single file manually:

```bash
# Step 1: Parse QE output to CSV (Extracts Forces, Stress, Energy)
python scripts/out2csv.py --input data_samples/qe_md.out --output data_samples/extracted.csv

# Step 2: Format CSV to MTP Configuration (.cfg)
python scripts/csv2cfg.py --input data_samples/extracted.csv --output data_samples/training_set.cfg --mode w
```

**B. Automated Batch Processing**
Use the included batch file to process *multiple* `.out` files automatically. This script iterates through a folder of raw logs, parses them, and merges them into a single training set.

```bash
./run_preprocessing.bat
```

### 3\. Model Training

Train the Moment Tensor Potential using the processed configuration file and the initialization parameters.

```bash
# Train for 100 iterations (example)
mlp train training_config/mtp_init.almtp data_samples/sample_training_set.cfg --save_to=trained_potential.mtp
```

### 4\. Validation (LAMMPS)

Deploy the trained potential to calculate material properties.

```bash
# Run elastic constant calculation
lammps -in validation/lammps_elastic.in
```

