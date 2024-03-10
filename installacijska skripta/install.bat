@echo off

:: Request admin privileges
NET FILE >NUL 2>&1
if '%errorlevel%' == '0' ( goto gotAdmin ) else ( goto getAdmin )

:getAdmin
echo Running script as administrator...
echo.
echo Please authorize the script to run with administrator privileges.
echo Press any key to continue...
pause >NUL
powershell Start-Process -FilePath "%0" -ArgumentList "%*" -Verb RunAs
exit /B

:gotAdmin
echo Running script with administrator privileges.
echo.

:: Download Git for Windows
echo "Installing Git"
winget install --id Git.Git -e --source winget

echo "Installing Docker"
winget install "Docker Desktop"

echo "Installing Vagrant"
winget install Vagrant

echo "Install VirtualBox"
winget install --id Oracle.VirtualBox

echo "Enabling WSL"
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart

echo "Install Ubuntu for WSL"
wsl --install -d Ubuntu

echo "Git,Docker,Vagrant and VirtualBox installed successfully and WSL is enabled."

pause