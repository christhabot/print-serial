@echo off
SETLOCAL EnableDelayedExpansion

set "GITHUB_USER=christhabot"
set "GITHUB_REPO=print-serial"
set "BRANCH=main"
set "DEST_FOLDER=C:\PrintSerial"

if not exist "%DEST_FOLDER%" mkdir "%DEST_FOLDER%"

powershell -NoProfile -Command "Invoke-RestMethod -Uri 'https://api.github.com/repos/%GITHUB_USER%/%GITHUB_REPO%/git/trees/%BRANCH%?recursive=1' -Headers @{ 'User-Agent'='Windows' } | Select-Object -ExpandProperty tree | Where-Object { $_.type -eq 'blob' } | ForEach-Object { $_.path }" > filelist.txt

if not exist filelist.txt (
    echo Failed to fetch file list.
    pause
    exit /b
)

for /f "usebackq delims=" %%f in ("filelist.txt") do (
    set "FILE_PATH=%%f"
    set "DEST_PATH=%DEST_FOLDER%\!FILE_PATH!"
    if not exist "!DEST_PATH!\.." mkdir "!DEST_PATH!\.."
    echo Downloading !FILE_PATH! ...
    powershell -NoProfile -Command "Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/%GITHUB_USER%/%GITHUB_REPO%/%BRANCH%/!FILE_PATH!' -OutFile '!DEST_PATH!'"
)

del filelist.txt

powershell -NoProfile -Command "[Environment]::SetEnvironmentVariable('Path', $env:Path + ';%DEST_FOLDER%', 'User')"

echo Done!
pause