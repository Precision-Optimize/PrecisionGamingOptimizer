# Safety / Expectations

This project aims for **balanced, safe, and reversible** optimizations:
- No "magic FPS" claims
- No risky kernel hacks
- No permanent driver modifications
- Every module has a corresponding **revert** script

## Run as Administrator
Some tweaks require admin rights. If not elevated, scripts will warn and skip those parts.

## Backups
- Detection output is saved to `src/logs/detect.json`
- Network registry changes are reversible with `revert_network.bat`

## If something feels wrong
1. Run `src/installer/uninstall.bat`
2. Reboot
3. Re-apply only the game profile you need
