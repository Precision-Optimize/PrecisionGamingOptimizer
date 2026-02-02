@echo off
setlocal EnableExtensions

echo [RAM] Reverting memory settings...

powershell -NoProfile -Command "try { $mc=(Get-MMAgent).MemoryCompression; if (-not $mc) { Enable-MMAgent -MemoryCompression; Write-Host 'Memory Compression enabled.' } else { Write-Host 'Memory Compression already enabled or unavailable.' } } catch { Write-Host 'Memory Compression not supported on this system.' }"

endlocal
exit /b 0
