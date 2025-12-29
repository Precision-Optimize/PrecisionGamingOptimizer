@echo off
setlocal EnableExtensions

call "%~dp0..\..\installer\common.bat" >nul
echo [RAM] Reverting memory tweaks...

if /i "%IS_ELEVATED%"=="True" (
  powershell -NoProfile -Command "Enable-MMAgent -MemoryCompression" >nul 2>&1
)

reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" ^
  /v LargeSystemCache /f >nul 2>&1

echo [RAM] Reverted.
endlocal & exit /b 0
