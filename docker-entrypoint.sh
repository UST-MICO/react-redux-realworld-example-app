#!/bin/sh
set -e

echo "Backend Rest Api Url is: ${BACKEND_REST_API}"

if [ "$NAMESERVER" == "" ]
then
    export NAMESERVER=$(awk '/^nameserver/{print $2}' /etc/resolv.conf)
fi

echo "Nameserver is:" $NAMESERVER

envsubst '$NAMESERVER ${BACKEND_REST_API}' < /etc/nginx/nginx.conf > /etc/nginx/nginx.conf
echo "done replacing"

cat /etc/nginx/nginx.conf

exec "$@"
