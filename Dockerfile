FROM openjdk

RUN yum update -y \
 && yum install -y jq 

WORKDIR /home/

COPY entrypoint.sh  ./
RUN chmod +x entrypoint.sh

COPY gdrive-linux-x64 ./gdrive
RUN chmod +x gdrive
RUN ln ./gdrive /usr/local/bin/gdrive

COPY server.jar ./

RUN mkdir server

ENTRYPOINT ["./entrypoint.sh"]
