@echo off
setlocal EnableExtensions

call "%~dp0..\..\installer\common.bat" >nul
echo [NETWORK] Reverting network tweaks...

if /i "%IS_ELEVATED%"=="True" (
  powershell -NoProfile -Command ^
  "$base='HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces';" ^
  "Get-ChildItem $base | ForEach-Object {" ^
  "  Remove-ItemProperty -Path $_.PsPath -Name 'TcpAckFrequency' -ErrorAction SilentlyContinue;" ^
  "  Remove-ItemProperty -Path $_.PsPath -Name 'TCPNoDelay' -ErrorAction SilentlyContinue;" ^
  "}" >nul 2>&1
)

reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\Psched" ^
  /v NonBestEffortLimit /f >nul 2>&1

echo [NETWORK] Reverted.
endlocal & exit /b 0
