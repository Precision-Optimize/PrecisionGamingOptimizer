@echo off
setlocal EnableExtensions

call "%~dp0..\..\installer\common.bat" >nul

echo [WINDOWS] Reverting system tweaks...

reg delete "HKCU\Software\Microsoft\GameBar" /v AllowAutoGameMode /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\GameBar" /v ShowStartupPanel /f >nul 2>&1

reg delete "HKCU\System\GameConfigStore" /v GameDVR_Enabled /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /f >nul 2>&1

if /i "%WIN_VERSION%"=="WIN10" (
  reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v GlobalUserDisabled /f >nul 2>&1
)

reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /f >nul 2>&1

:: Return to Balanced plan
powercfg -setactive SCHEME_BALANCED >nul 2>&1

echo [WINDOWS] Reverted.
endlocal & exit /b 0
