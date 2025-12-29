@echo off
setlocal EnableExtensions EnableDelayedExpansion

set "ROOT=%~dp0.."
set "JSON=%ROOT%\logs\detect.json"
if not exist "%JSON%" (
  echo [ERROR] Missing %JSON%. Run detect.bat first.
  exit /b 1
)

for /f "usebackq delims=" %%A in (`powershell -NoProfile -Command ^
  "$j=Get-Content -Raw '%JSON%'|ConvertFrom-Json; ^
   '{0}|{1}|{2}|{3}|{4}|{5}|{6}' -f $j.GPU.Vendor,$j.Tier,$j.RAM.TotalGB,$j.CPU.Threads,$j.Admin,$j.Laptop,$j.OS.Build"`) do (
  set "LINE=%%A"
)

for /f "tokens=1-7 delims=|" %%a in ("%LINE%") do (
  set "GPU_VENDOR=%%a"
  set "TIER=%%b"
  set "RAM_GB=%%c"
  set "CPU_THREADS=%%d"
  set "IS_ADMIN=%%e"
  set "IS_LAPTOP=%%f"
  set "OS_BUILD=%%g"
)

echo GPU_VENDOR=%GPU_VENDOR%
echo TIER=%TIER%
echo RAM_GB=%RAM_GB%
echo CPU_THREADS=%CPU_THREADS%
echo IS_ADMIN=%IS_ADMIN%
echo IS_LAPTOP=%IS_LAPTOP%
echo OS_BUILD=%OS_BUILD%

endlocal & (
  set "GPU_VENDOR=%GPU_VENDOR%"
  set "TIER=%TIER%"
  set "RAM_GB=%RAM_GB%"
  set "CPU_THREADS=%CPU_THREADS%"
  set "IS_ADMIN=%IS_ADMIN%"
  set "IS_LAPTOP=%IS_LAPTOP%"
  set "OS_BUILD=%OS_BUILD%"
)
exit /b 0
