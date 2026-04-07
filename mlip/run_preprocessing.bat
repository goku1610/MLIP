@echo off
setlocal enabledelayedexpansion

:: ---------------------------------------------------------
:: Automated Data Pipeline: Raw DFT -> MLIP Training Format
:: ---------------------------------------------------------

:: Create output directories if they don't exist
if not exist "data_samples\csv_data" mkdir data_samples\csv_data
if not exist "data_samples\cfg_data" mkdir data_samples\cfg_data

:: Step 1: Parse Quantum Espresso Logs (.out -> .csv)
:: Uncomment the loop below if you have raw .out files to process
:: for %%f in (data_samples\*.out) do (
::     echo [Processing] Parsing %%f...
::     python scripts\out2csv.py -i "%%f" -o "data_samples\csv_data\%%~nf.csv"
:: )

:: Step 2: Calculate Data Distribution
set TOTAL_ROWS=50000
set /a FILE_COUNT=0

for %%f in (data_samples\csv_data\*.csv) do (
    set /a FILE_COUNT+=1
)

if !FILE_COUNT! EQU 0 (
    echo [Error] No CSV files found in directory.
    pause
    exit /b
)

set /a ROWS_PER_FILE=!TOTAL_ROWS! / !FILE_COUNT!
echo [Info] Found !FILE_COUNT! files. Extracting !ROWS_PER_FILE! configurations per file.

:: Step 3: Format for MLIP (.csv -> .cfg)
for %%f in (data_samples\csv_data\*.csv) do (
    echo [Formatting] %%f -> combined_data.cfg
    python scripts\csv2cfg.py -i "%%f" -o "data_samples\cfg_data\combined_data.cfg" -m "a" --start 0 --end !ROWS_PER_FILE!
)

echo [Success] Pipeline completed. Training data ready in data_samples\cfg_data\
pause