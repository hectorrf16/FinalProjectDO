#!/bin/bash
# set -e
adduser --disabled-password --gecos "" hectorrf16

cp /home/tmp/server.crt /tmp/
cp /home/tmp/server.csr /tmp/
# chown grafana /tmp/server.*
echo "Finished"