@echo off
setlocal EnableDelayedExpansion

set "imageName=my-gnucobol-image"
set "workDir=c:\cobolLearning\docker\justFollowingWithBook" 
set "cobolFile=helloworld.cobol"
set "deletBeforeRunning=Customers.dax"

echo Deleting the Before running file...
if exist "!deletBeforeRunning!" del /Q "!deletBeforeRunning!"

echo Stopping current images running older version
for /f "tokens=*" %%i in ('docker ps -a -f "ancestor=!imageName!" -q') do docker stop %%i

echo Removing existing image...
#docker image rm -f !imageName! 2>nul 
for /f "tokens=*" %%i in ('docker ps -a -f "ancestor=!imageName!" -q') do docker container rm %%i -f

echo removing any dangling images
for /f "tokens=*" %%i in ('docker images -f "dangling=true" -q') do docker rmi -f %%i

echo Building Docker image...
docker build -t !imageName! .

echo Waiting for 2 seconds...
timeout /T 2 /NOBREAK >nul

echo Running container with volume mount...
docker run -it -v "!workDir!:/app" !imageName! /bin/bash -c "cobc -x /app/!cobolFile! && ./!cobolFile:~0,-6!" 

echo Deleting compiled file from host...
if exist "!cobolFile:~0,-6!" del /Q "!cobolFile:~0,-6!"


endlocal