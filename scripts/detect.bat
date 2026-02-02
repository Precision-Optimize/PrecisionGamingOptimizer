@echo off
for /f "tokens=2 delims==" %%A in ('wmic os get BuildNumber /value') do set BUILD=%%A
if %BUILD% GEQ 22000 (set WIN=WIN11) else (set WIN=WIN10)
echo Detected %WIN% (Build %BUILD%)
