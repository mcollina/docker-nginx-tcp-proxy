#! /bin/sh

if [ ! -z $MOSCA1_PORT_1883_TCP_ADDR ]; then
  sed -i "s/MOSCA1/$MOSCA1_PORT_1883_TCP_ADDR/" /opt/nginx/config_tcp
fi

if [ ! -z $MOSCA2_PORT_1883_TCP_ADDR ]; then
  sed -i "s/MOSCA2/$MOSCA2_PORT_1883_TCP_ADDR/" /opt/nginx/config_tcp
fi

if [ ! -z $MOSCA3_PORT_1883_TCP_ADDR ]; then
  sed -i "s/MOSCA3/$MOSCA3_PORT_1883_TCP_ADDR/" /opt/nginx/config_tcp
fi

sed -i "s/^.*MOSCA.*$//" /opt/nginx/config_tcp

/opt/nginx/objs/nginx -c /opt/nginx/config_tcp
