@echo off
setlocal EnableExtensions EnableDelayedExpansion

:: Ensure logs dir exists
set "ROOT=%~dp0.."
if not exist "%ROOT%\logs" mkdir "%ROOT%\logs"

:: Detect Windows build
for /f "tokens=2 delims==" %%A in ('wmic os get BuildNumber /value') do set BUILD=%%A

set WIN_VERSION=UNKNOWN
if not "%BUILD%"=="" (
  if %BUILD% GEQ 22000 (
    set WIN_VERSION=WIN11
  ) else (
    set WIN_VERSION=WIN10
  )
)

:: Admin?
net session >nul 2>&1
if %errorlevel%==0 (
  set IS_ELEVATED=True
) else (
  set IS_ELEVATED=False
)

echo Detected %WIN_VERSION% (Build %BUILD%) - Elevated: %IS_ELEVATED%

endlocal & (
  set "BUILD=%BUILD%"
  set "WIN_VERSION=%WIN_VERSION%"
  set "IS_ELEVATED=%IS_ELEVATED%"
)
exit /b 0
