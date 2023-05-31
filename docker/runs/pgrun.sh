# !/bin/bash

sleep 5 > /dev/null 2>&1
cd /var/lib/pgadmin/storage > /dev/null 2>&1
mkdir ./hectoor.16_icloud.com > /dev/null 2>&1
chmod 700 ./hectoor.16_icloud.com > /dev/null 2>&1
cp /tmp/pgpass ./hectoor.16_icloud.com/pgpass > /dev/null 2>&1
chmod 600 ./hectoor.16_icloud.com/pgpass > /dev/null 2>&1