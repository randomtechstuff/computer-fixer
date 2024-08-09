@echo off

:: Check for internet connection using curl
echo Checking for internet connection...

curl -s --head http://www.google.com/ | find "200 OK" >nul
if %errorlevel% neq 0 (
    echo No internet connection detected. Please check your connection and try again. Tested for internet using google.com of you have strict restrictions, delete line 2 to 11
    pause
    exit /b
)
echo success you are connected to the internet

:: Check for administrative privileges
openfiles >nul 2>&1
if %errorlevel% neq 0 (
    echo Uh oh, administrative privileges are not granted. Click to grant.
    pause
    echo Requesting administrative privileges...
    powershell -command "Start-Process '%~0' -Verb runAs"
    exit /b
)

:: Continue with the rest of the code if running with admin rights
echo Running with administrative privileges...
cls
echo Welcome to the Windows File Fixer program. To start, press any key to continue.
pause

sfc /scannow
DISM /Online /Cleanup-Image /CheckHealth
DISM /Online /Cleanup-Image /ScanHealth
DISM /Online /Cleanup-Image /RestoreHealth

echo Task completed. Press any key to exit.
pause
