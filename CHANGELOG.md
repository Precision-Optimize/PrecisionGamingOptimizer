# Changelog

## [1.0.1] – Minor Stability Update
### Improved
- More reliable GPU auto-detection on systems with both iGPU and dGPU
- Safer handling when FiveM or Fortnite is not installed
- Cleaner console output with clearer detection summary
- Minor script refactoring for readability and maintenance

### Changed
- No changes to optimization behavior
- No new or aggressive tweaks introduced

### Fixed
- Prevented false warnings when game executables are missing

## [1.0.0] – 2025-12-29
### Added
- Smart auto-detect (PowerShell → JSON) with tier classification (LOW/MID/HIGH)
- Balanced base tweaks: Windows, CPU, RAM, Network (revert included)
- Game profiles: FiveM and Fortnite (revert included)
- GPU vendor modules (NVIDIA/AMD/Intel) using Windows per-app High Performance preference
- One-click installer and uninstaller
- Benchmark guide and safety notes
