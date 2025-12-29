@echo off
setlocal EnableExtensions

call "%~dp0..\..\installer\common.bat" >nul
echo [CPU] Applying balanced CPU tweaks...

if /i not "%IS_ELEVATED%"=="True" (
  echo [CPU] WARN: Not elevated. Skipping HKLM power settings.
) else (
  :: Make CPU parking setting adjustable (balanced-friendly)
  reg add "HKLM\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583" ^
    /v ValueMax /t REG_DWORD /d 0 /f >nul 2>&1
)

:: Multimedia scheduling (keep modest values)
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" ^
  /v SystemResponsiveness /t REG_DWORD /d 10 /f >nul 2>&1

echo [CPU] Done.
endlocal & exit /b 0
