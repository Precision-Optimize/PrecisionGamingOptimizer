@echo off
setlocal EnableExtensions

call "%~dp0..\..\installer\common.bat" >nul

set "FIVEM_EXE=%LocalAppData%\FiveM\FiveM.exe"
set "FN_EXE=%ProgramFiles%\Epic Games\Fortnite\FortniteGame\Binaries\Win64\FortniteClient-Win64-Shipping.exe"
set "DXKEY=HKCU\Software\Microsoft\DirectX\UserGpuPreferences"

:: Prefer High Performance GPU for these apps (Windows Graphics Settings)
:: Format: "<path>"="GpuPreference=2;"
if exist "%FIVEM_EXE%" (
  reg add "%DXKEY%" /v "%FIVEM_EXE%" /t REG_SZ /d "GpuPreference=2;" /f >nul 2>&1
)
if exist "%FN_EXE%" (
  reg add "%DXKEY%" /v "%FN_EXE%" /t REG_SZ /d "GpuPreference=2;" /f >nul 2>&1
)

echo [GPU] Set Windows per-app High Performance preference where apps were found.
endlocal & exit /b 0
