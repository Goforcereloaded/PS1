@echo off
set "current_dir=%~dp0"
powershell.exe -WindowStyle Hidden -ExecutionPolicy Bypass -File "%current_dir%Microsoft Rewards.ps1"
exit

