#! /bin/sh

docker rm mosca nginx
docker run -d --name mosca matteocollina/mosca
docker build -t nginx .
docker run -d --name nginx -e 1883 -p 1883:1883 --link mosca:mosca1 nginx
