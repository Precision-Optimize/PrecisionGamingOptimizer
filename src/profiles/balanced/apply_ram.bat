@echo off
setlocal EnableExtensions

call "%~dp0..\..\installer\common.bat" >nul
echo [RAM] Applying balanced memory tweaks...

if /i "%IS_ELEVATED%"=="True" (
  powershell -NoProfile -Command "Disable-MMAgent -MemoryCompression" >nul 2>&1
) else (
  echo [RAM] WARN: Not elevated. Skipping MemoryCompression toggle.
)

:: LargeSystemCache OFF (gaming-friendly)
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" ^
  /v LargeSystemCache /t REG_DWORD /d 0 /f >nul 2>&1

echo [RAM] Done.
endlocal & exit /b 0
