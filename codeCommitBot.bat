@echo off
setlocal enabledelayedexpansion

:: Capture commit info with current date/time
set info=Commit: %DATE% %TIME%

:: Detect OS (basic check)
echo OS detected: %OS%

:: Append "Testing" to test.txt
echo Testing >> test.txt

:: Change directory to script location
cd /d "%~dp0"

:: If OS is not Windows, warn (since batch runs only on Windows)
if /i not "%OS%"=="Windows_NT" (
    echo OS unsupported (submit an issue on GitHub!)
)

:: Append commit info to output.txt
echo %info% >> output.txt
echo %info%
echo.

:: Detect current branch
for /f "tokens=*" %%b in ('git rev-parse --abbrev-ref HEAD') do set branch=%%b

:: Ship it
git add output.txt
git commit -m "%info%"
git push origin %branch%

:: Return to previous directory
cd -
endlocal