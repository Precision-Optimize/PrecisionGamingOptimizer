@echo off
powercfg -setactive SCHEME_BALANCED
reg delete "HKCU\System\GameConfigStore" /v GameDVR_Enabled /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /f
