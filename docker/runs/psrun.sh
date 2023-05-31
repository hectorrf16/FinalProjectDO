#!/bin/sh

adduser --disabled-password --gecos "" hectorrf16 > /dev/null 2>&1

cd /tmp > /dev/null 2>&1
psql finalproject hector -f query.sql > /dev/null 2>&1
sleep 2 > /dev/null 2>&1
apk add --no-cache ca-certificates bash tzdata && apk add --no-cache musl-utils > /dev/null 2>&1
apk add --no-cache openssl --repository=http://dl-cdn.alpinelinux.org/alpine/edge/main > /dev/null 2>&1
sleep 2 > /dev/null 2>&1
openssl genrsa -out server.key 2048 > /dev/null 2>&1
openssl req -new -key server.key -out server.csr -subj "/C=ES/ST=CAT/L=BCN/O=HECTOR/OU=HRF/CN=localhost" > /dev/null 2>&1
openssl req -new -key server.key -out server.csr -nodes -subj "/C=ES/ST=CAT/L=BCN/O=HECTOR/OU=HRF/CN=localhost" > /dev/null 2>&1
openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt > /dev/null 2>&1
cp server.crt /var/lib/postgresql/data/server.crt > /dev/null 2>&1
cp server.key /var/lib/postgresql/data/server.key > /dev/null 2>&1
# chown 1000:1000 server.*
cp /tmp/postgresql.conf /var/lib/postgresql/data > /dev/null 2>&1
chown postgres:postgres /var/lib/postgresql/data/postgresql.conf > /dev/null 2>&1
sleep 3 > /dev/null 2>&1
psql postgres hector -c "select pg_reload_conf();" > /dev/null 2>&1