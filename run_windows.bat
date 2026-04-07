@echo off
setlocal

REM Windows launcher for the Cu4TiSe4 workflow via WSL.
REM Usage:
REM   run_windows.bat
REM   run_windows.bat 8

set "MPI_NP=%~1"
if "%MPI_NP%"=="" set "MPI_NP=8"

REM Update this if your repo lives at a different path inside WSL.
set "WSL_REPO=/home/saksham/coding/mlip"

echo Running Cu4TiSe4 workflow in WSL
echo Repo: %WSL_REPO%
echo MPI ranks: %MPI_NP%
echo.

wsl bash -lc "cd '%WSL_REPO%' && ./cu4tise4_workflow/prepare_runtime.sh && MPI_NP=%MPI_NP% ./cu4tise4_workflow/train_and_eval.sh"

if errorlevel 1 (
  echo.
  echo Workflow failed. Check the messages above.
  exit /b 1
)

echo.
echo Workflow finished.
exit /b 0
