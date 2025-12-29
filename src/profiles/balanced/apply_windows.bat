@echo off
setlocal EnableExtensions

call "%~dp0..\..\installer\common.bat" >nul

echo [WINDOWS] Applying balanced system tweaks...

:: Game Bar / Game DVR (safe)
reg add "HKCU\Software\Microsoft\GameBar" /v AllowAutoGameMode /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\GameBar" /v ShowStartupPanel /t REG_DWORD /d 0 /f >nul 2>&1

reg add "HKCU\System\GameConfigStore" /v GameDVR_Enabled /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d 0 /f >nul 2>&1

:: Background apps toggle (Win10 only; Win11 UI differs)
if /i "%WIN_VERSION%"=="WIN10" (
  reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v GlobalUserDisabled /t REG_DWORD /d 1 /f >nul 2>&1
)

:: Visual effects: let Windows decide / balanced (2)
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 2 /f >nul 2>&1

:: Power plan: High Performance (fallback to Balanced if unavailable)
powercfg -setactive SCHEME_MIN >nul 2>&1

echo [WINDOWS] Done.
endlocal & exit /b 0
