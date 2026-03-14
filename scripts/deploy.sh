#!/bin/bash

docker pull $DOCKER_USERNAME/node-devops-app-p1:latest

docker stop node-devops-app-p1 || true
docker rm node-devops-app-p1 || true

docker run -d \
-p 80:3000 \
--name node-devops-app \
$DOCKER_USERNAME/node-devops-app-p1:latest

docker image prune -af
