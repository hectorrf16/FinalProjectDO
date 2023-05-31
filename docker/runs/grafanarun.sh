#!/bin/bash
adduser --disabled-password --gecos "" hectorrf16 > /dev/null 2>&1

cp /home/tmp/server.crt /tmp/ > /dev/null 2>&1
cp /home/tmp/server.csr /tmp/ > /dev/null 2>&1
# chown grafana /tmp/server.*