@echo off
setlocal EnableExtensions

call "%~dp0..\..\installer\common.bat" >nul

set "FIVEM_EXE=%LocalAppData%\FiveM\FiveM.exe"
set "FN_EXE=%ProgramFiles%\Epic Games\Fortnite\FortniteGame\Binaries\Win64\FortniteClient-Win64-Shipping.exe"
set "DXKEY=HKCU\Software\Microsoft\DirectX\UserGpuPreferences"

if exist "%FIVEM_EXE%" (
  reg delete "%DXKEY%" /v "%FIVEM_EXE%" /f >nul 2>&1
)
if exist "%FN_EXE%" (
  reg delete "%DXKEY%" /v "%FN_EXE%" /f >nul 2>&1
)

echo [GPU] Reverted Windows per-app GPU preferences (where present).
endlocal & exit /b 0
