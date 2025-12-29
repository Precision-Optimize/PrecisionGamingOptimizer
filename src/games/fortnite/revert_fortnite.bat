@echo off
setlocal EnableExtensions

call "%~dp0..\..\installer\common.bat" >nul
echo [FORTNITE] Reverting Fortnite tweaks...

set "FN_EXE=%ProgramFiles%\Epic Games\Fortnite\FortniteGame\Binaries\Win64\FortniteClient-Win64-Shipping.exe"
reg delete "HKCU\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" ^
  /v "%FN_EXE%" /f >nul 2>&1

reg delete "HKCU\Software\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\FortniteClient-Win64-Shipping.exe" /f >nul 2>&1

echo [FORTNITE] Reverted.
endlocal & exit /b 0
