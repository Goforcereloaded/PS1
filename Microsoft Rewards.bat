@echo off
set "current_dir=%~dp0"
powershell.exe -ExecutionPolicy Bypass -File "%current_dir%Microsoft Rewards.ps1"
pause
