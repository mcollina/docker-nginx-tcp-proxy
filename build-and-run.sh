#! /bin/sh

docker stop mosca nginx
docker rm mosca nginx
docker run -d --name mosca matteocollina/mosca
docker build -t nginx .
docker run -d --name nginx -e 8883 -e 1883 -p 1883:1883 -p 8883:8883 --link mosca:mosca1 nginx
