@echo off
echo Detected GPU Vendor: %GPU_VENDOR%
echo Detected System Tier: %TIER%
echo Windows Version: %WIN_VERSION%
echo.

setlocal EnableExtensions EnableDelayedExpansion

set "ROOT=%~dp0.."
call "%ROOT%\installer\common.bat" || exit /b 1

echo.
echo === PrecisionGamingOptimizer (BALANCED) ===
echo.

if /i not "%IS_ELEVATED%"=="True" (
  echo [WARN] Not running as Administrator. Some system tweaks may be skipped.
  echo        (Right-click ^> Run as Administrator recommended.)
  echo.
)

:: Detect hardware
call "%ROOT%\detect\detect.bat" || exit /b 1
call "%ROOT%\detect\parse_detect.bat" || exit /b 1

:: Apply base balanced profile
call "%ROOT%\profiles\balanced\apply_windows.bat"
call "%ROOT%\profiles\balanced\apply_cpu.bat"
call "%ROOT%\profiles\balanced\apply_ram.bat"
call "%ROOT%\profiles\balanced\apply_network.bat"

:: GPU branch (safe: Windows per-app GPU preference)
if /i "%GPU_VENDOR%"=="NVIDIA" (
  call "%ROOT%\profiles\balanced\apply_gpu_nvidia.bat"
) else if /i "%GPU_VENDOR%"=="AMD" (
  call "%ROOT%\profiles\balanced\apply_gpu_amd.bat"
) else (
  call "%ROOT%\profiles\balanced\apply_gpu_intel.bat"
)

:: Games
call "%ROOT%\games\fivem\apply_fivem.bat"
call "%ROOT%\games\fortnite\apply_fortnite.bat"

echo.
echo [OK] Balanced optimization applied.
echo Logs: %ROOT%\logs\
echo Reboot recommended for best results.
pause
exit /b 0
