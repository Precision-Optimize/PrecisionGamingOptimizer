@echo off
setlocal EnableExtensions

set "ROOT=%~dp0"

echo === PrecisionGamingOptimizer — REVERT ===
echo.

call "%ROOT%scripts\revert_windows.bat"
call "%ROOT%scripts\revert_cpu.bat"
call "%ROOT%scripts\revert_ram.bat"
call "%ROOT%scripts\revert_network.bat"
call "%ROOT%games\revert_fivem.bat"
call "%ROOT%games\revert_fortnite.bat"

echo.
echo Revert completed.
echo.
echo Press any key to exit...
pause >nul
exit /b
