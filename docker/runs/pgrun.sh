# !/bin/bash

sleep 5
cd /var/lib/pgadmin/storage
mkdir ./hectoor.16_icloud.com
chmod 700 ./hectoor.16_icloud.com
cp /tmp/pgpass ./hectoor.16_icloud.com/pgpass
chmod 600 ./hectoor.16_icloud.com/pgpass
echo "Finished"