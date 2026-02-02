@echo off
reg add "HKCU\Software\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\FiveM.exe\PerfOptions" /v CpuPriorityClass /t REG_DWORD /d 3 /f
