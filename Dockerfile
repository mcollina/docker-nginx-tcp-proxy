# docker-nginx
#
# VERSION 0.0.1

FROM ubuntu
MAINTAINER Matteo Collina <hello@matteocollina.com>

RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update

# install tools for building binary addons
RUN apt-get -y install build-essential libssl-dev curl python
RUN apt-get -y install libpcre3 libpcre3-dev

ADD ./nginx-1.5.10 /opt/nginx

ADD ./nginx_tcp_proxy_module-v0.4.4 /opt/nginx_tcp_proxy_module

RUN cd /opt/nginx; patch -p1 < /opt/nginx_tcp_proxy_module/tcp.patch

RUN cd /opt/nginx; ./configure --add-module=/opt/nginx_tcp_proxy_module; make

RUN mkdir -p /usr/local/nginx/logs

RUN openssl genrsa -out /opt/nginx/key.pem 1024

RUN openssl req -new -subj "/C=US/ST=Denial/L=Springfield/O=Dis/CN=www.example.com" -key /opt/nginx/key.pem -out /opt/nginx/csr.pem

RUN openssl x509 -req -in /opt/nginx/csr.pem -signkey /opt/nginx/key.pem -out /opt/nginx/cert.pem

ADD ./config /opt/nginx/config_tcp

ADD ./start.sh /opt/nginx/start.sh

ENTRYPOINT /bin/sh /opt/nginx/start.sh
