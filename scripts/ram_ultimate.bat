@echo off
setlocal EnableExtensions

echo [RAM] Ultimate latency mode...

powershell -NoProfile -Command "try { $mc=(Get-MMAgent).MemoryCompression; if ($mc) { Disable-MMAgent -MemoryCompression; Write-Host 'Memory Compression disabled.' } else { Write-Host 'Memory Compression already disabled or unavailable.' } } catch { Write-Host 'Memory Compression not supported on this system.' }"

endlocal
exit /b 0
