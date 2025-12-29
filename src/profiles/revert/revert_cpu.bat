@echo off
setlocal EnableExtensions

call "%~dp0..\..\installer\common.bat" >nul
echo [CPU] Reverting CPU tweaks...

reg delete "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" ^
  /v SystemResponsiveness /f >nul 2>&1

echo [CPU] Reverted.
endlocal & exit /b 0
