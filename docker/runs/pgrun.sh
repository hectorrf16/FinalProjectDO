# !/bin/bash

sleep 5
cd /var/lib/pgadmin/storage
mkdir ./hectoor.16_icloud.com
chmod 700 ./hectoor.16_icloud.com
cp /tmp/pgpassfile ./hectoor.16_icloud.com/pgpassfile
chmod 600 ./hectoor.16_icloud.com/pgpassfile
echo "Finished"