@echo off
setlocal EnableExtensions

call "%~dp0..\..\installer\common.bat" >nul
echo [NETWORK] Applying balanced network tweaks...

if /i not "%IS_ELEVATED%"=="True" (
  echo [NETWORK] WARN: Not elevated. Skipping interface registry tweaks.
  goto :qos
)

:: Apply TcpAckFrequency/TCPNoDelay on all interfaces (safe approach)
powershell -NoProfile -Command ^
"$base='HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces';" ^
"Get-ChildItem $base | ForEach-Object {" ^
"  New-ItemProperty -Path $_.PsPath -Name 'TcpAckFrequency' -PropertyType DWord -Value 1 -Force | Out-Null;" ^
"  New-ItemProperty -Path $_.PsPath -Name 'TCPNoDelay' -PropertyType DWord -Value 1 -Force | Out-Null;" ^
"}" >nul 2>&1

:qos
:: QoS throttling OFF (policy)
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Psched" ^
  /v NonBestEffortLimit /t REG_DWORD /d 0 /f >nul 2>&1

echo [NETWORK] Done.
endlocal & exit /b 0
