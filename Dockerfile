FROM openjdk

RUN yum update -y \
 && yum install -y jq 

WORKDIR /home/

COPY gdrive-linux-x64 ./gdrive
RUN chmod +x gdrive
RUN ln ./gdrive /usr/local/bin/gdrive

COPY server.jar ./

RUN mkdir server
