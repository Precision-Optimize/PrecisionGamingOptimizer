@echo off
setlocal EnableExtensions

call "%~dp0..\..\installer\common.bat" >nul
echo [FIVEM] Reverting FiveM tweaks...

set "FIVEM_EXE=%LocalAppData%\FiveM\FiveM.exe"
reg delete "HKCU\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" ^
  /v "%FIVEM_EXE%" /f >nul 2>&1

reg delete "HKCU\Software\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\FiveM.exe" /f >nul 2>&1

echo [FIVEM] Reverted.
endlocal & exit /b 0
