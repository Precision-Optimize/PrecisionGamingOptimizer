@echo off
setlocal EnableExtensions

set "ROOT=%~dp0.."
call "%ROOT%\installer\common.bat" || exit /b 1

echo.
echo === PrecisionGamingOptimizer (REVERT ALL) ===
echo.

call "%ROOT%\games\fivem\revert_fivem.bat"
call "%ROOT%\games\fortnite\revert_fortnite.bat"

call "%ROOT%\profiles\revert\revert_gpu.bat"
call "%ROOT%\profiles\revert\revert_network.bat"
call "%ROOT%\profiles\revert\revert_ram.bat"
call "%ROOT%\profiles\revert\revert_cpu.bat"
call "%ROOT%\profiles\revert\revert_windows.bat"

echo.
echo [OK] Revert completed.
echo Reboot recommended.
pause
exit /b 0
