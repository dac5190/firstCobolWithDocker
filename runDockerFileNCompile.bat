@echo off
echo Stopping current images running older version
for /f "tokens=*" %%i in ('docker ps -a -f "ancestor=my-gnucobol-image" -q') do docker stop %%i

echo Removing existing image...
#docker image rm -f my-gnucobol-image 2>nul 
for /f "tokens=*" %%i in ('docker ps -a -f "ancestor=my-gnucobol-image" -q') do docker container rm %%i -f

echo removing any dangling images
for /f "tokens=*" %%i in ('docker images -f "dangling=true" -q') do docker rmi -f %%i

echo Building Docker image...
docker build -t my-gnucobol-image .

echo Waiting for 2 seconds...
timeout /T 2 /NOBREAK >nul

echo Running container and compiling/executing COBOL program...
docker run -it my-gnucobol-image /bin/bash -c "cobc -x helloworld.cobol && ./helloworld"

echo Done from bat!