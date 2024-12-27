@echo off
echo Removing existing image...
docker image rm -f my-gnucobol-image 2>nul 

echo removing any dangling images
docker images -f "dangling=true" -q | xargs docker rmi -f

echo Building Docker image...
docker build -t my-gnucobol-image .

echo Waiting for 2 seconds...
timeout /T 2 /NOBREAK >nul

echo Running container and compiling/executing COBOL program...
docker run -it my-gnucobol-image /bin/bash -c "cobc -x helloworld.cobol && ./helloworld"

echo Done from bat!