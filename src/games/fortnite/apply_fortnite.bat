@echo off
setlocal EnableExtensions

call "%~dp0..\..\installer\common.bat" >nul
echo [FORTNITE] Applying Fortnite balanced tweaks...

set "FN_EXE=%ProgramFiles%\Epic Games\Fortnite\FortniteGame\Binaries\Win64\FortniteClient-Win64-Shipping.exe"
if not exist "%FN_EXE%" (
  echo [FORTNITE] Fortnite not found – skipping profile.
  exit /b 0
)


:: Disable Fullscreen Optimizations (per-app)
reg add "HKCU\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" ^
  /v "%FN_EXE%" /t REG_SZ /d "~ DISABLEDXMAXIMIZEDWINDOWEDMODE" /f >nul 2>&1

:: High priority hint (IFEO PerfOptions) - reversible
reg add "HKCU\Software\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\FortniteClient-Win64-Shipping.exe\PerfOptions" ^
  /v CpuPriorityClass /t REG_DWORD /d 3 /f >nul 2>&1

echo [FORTNITE] Done.
endlocal & exit /b 0
