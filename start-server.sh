#!/bin/bash
export IMAGE=$1
docker run -it -p 25565:25565 -v $(pwd)/server:/home/server/  ${IMAGE}
