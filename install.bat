@echo off
setlocal EnableExtensions EnableDelayedExpansion

set "ROOT=%~dp0"

echo === PrecisionGamingOptimizer — ULTIMATE FPS MODE ===
echo.

call "%ROOT%scripts\detect.bat" || goto :error

call "%ROOT%scripts\windows_ultimate.bat" || goto :error
call "%ROOT%scripts\cpu_ultimate.bat"     || goto :error
call "%ROOT%scripts\ram_ultimate.bat"     || goto :error
call "%ROOT%scripts\network_ultimate.bat" || goto :error

call "%ROOT%games\fivem_ultimate.bat"     || goto :error
call "%ROOT%games\fortnite_ultimate.bat"  || goto :error

echo.
echo SUCCESS: Optimization completed.
echo Reboot recommended.
echo.
echo Press any key to exit...
pause >nul
exit /b 0

:error
echo.
color 0C
echo ======================================
echo   ERROR: INSTALLATION STOPPED
echo ======================================
echo.
echo Scroll up to see the error message above.
echo.
echo Press any key to exit...
pause >nul
exit /b 1
