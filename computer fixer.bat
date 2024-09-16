@echo off
:: Title for the script window
title Windows File Fixer

:: Inform the user about the script's safety
echo =========================================================
echo This script is completely safe to use.
echo It checks for internet connectivity, administrative privileges,
echo and helps fix system files using trusted Windows tools.
echo If you have any doubts, you can upload it to VirusTotal.com for verification.
echo =========================================================
pause
cls

title Checking admin rights...

:: Check for administrative privileges
echo Checking for administrative privileges...
openfiles >nul 2>&1
if %errorlevel% neq 0 (
    color 4
    echo Administrative privileges are required to run this script.
    echo Please click 'Yes' when prompted to allow the script to continue.
    pause
    color 0
    echo Requesting administrative privileges...
    powershell -command "Start-Process '%~0' -Verb runAs"
    exit /b
)

cls

:check_internet
:: Check for internet connection using curl
Title checking internet connection...
echo Checking for an internet connection...

curl -s --head http://www.google.com/ | find "200 OK" >nul
if %errorlevel% neq 0 (
    color 4
    echo No internet connection detected. Please check your connection and try again. Tested for internet using google.com
    pause
    color 0
    exit /b
)
echo success you are connected to the internet
pause
cls


:: Continue with the rest of the code if running with admin rights
Title running with admin privileges
echo Running with administrative privileges...
timeout /t 1 /nobreak
cls
echo Welcome to the Windows File Fixer program.
echo This tool will check and repair your system files.
echo Press any key to start.
pause >nul

cls

cls
title Starting...
echo starting required servies
timeout /t 3 /nobreak

cls

title Attempting to fix...

:: Run system checks and repairs
echo Running system file checker (SFC)...
sfc /scannow

echo Checking the health of the system image...
DISM /Online /Cleanup-Image /CheckHealth

echo Scanning the system image for issues...
DISM /Online /Cleanup-Image /ScanHealth

echo Attempting to restore the system image...
DISM /Online /Cleanup-Image /RestoreHealth

echo Task completed successfully!

:: Ask the user if they want to open the GitHub page
echo =========================================================
echo Would you like to visit the GitHub repository for this script?
echo You can report issues or suggest improvements here:
echo https://github.com/zirui2012/computer-fixer
echo Press Y to open the link or any other key to exit.
echo =========================================================
set /p userInput=Do you want to open the link? (Y/N): 
if /I "%userInput%"=="Y" (
    start https://github.com/zirui2012/computer-fixer
)

echo Thank you for using this script!
pause >nul
exit
