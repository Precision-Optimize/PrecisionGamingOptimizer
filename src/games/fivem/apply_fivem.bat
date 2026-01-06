@echo off
setlocal EnableExtensions

call "%~dp0..\..\installer\common.bat" >nul
echo [FIVEM] Applying FiveM balanced tweaks...

set "FIVEM_EXE=%LocalAppData%\FiveM\FiveM.exe"
if not exist "%FIVEM_EXE%" (
  echo [FIVEM] FiveM not found – skipping profile.
  exit /b 0
)

:: Disable Fullscreen Optimizations (per-app)
reg add "HKCU\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" ^
  /v "%FIVEM_EXE%" /t REG_SZ /d "~ DISABLEDXMAXIMIZEDWINDOWEDMODE" /f >nul 2>&1

:: High priority hint (IFEO PerfOptions) - reversible
reg add "HKCU\Software\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\FiveM.exe\PerfOptions" ^
  /v CpuPriorityClass /t REG_DWORD /d 3 /f >nul 2>&1

echo [FIVEM] Done.
endlocal & exit /b 0
