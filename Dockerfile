FROM ubuntu:latest

WORKDIR /app

COPY helloworld.cobol . 

RUN apt update && apt upgrade -y
RUN apt install gnucobol -y