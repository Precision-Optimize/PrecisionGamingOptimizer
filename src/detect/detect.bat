@echo off
setlocal EnableExtensions

set "ROOT=%~dp0.."
set "LOGDIR=%ROOT%\logs"
if not exist "%LOGDIR%" mkdir "%LOGDIR%"

set "OUT=%LOGDIR%\detect.json"
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0detect.ps1" > "%OUT%"

if not exist "%OUT%" (
  echo [ERROR] Detection failed.
  exit /b 1
)

echo [OK] Hardware detection written to: %OUT%
exit /b 0
