#!/usr/bin/env bash

if test $# -lt 1
then
    exit 1
fi

containers=("app" "pgadmin" "grafana" "postgres")
options=("Local Instance" "Cloud Instance")
localoption=("Install" "Start" "Repair" "Uninstall" "Upload Images to Docker Hub")
repairoptions=("Postgres" "App" "PgAdmin" "Grafana" "All")
# echo -e "What do you want to do?\n"
opt=${options[$1]}
lopt=${localoption[$2]}
ropt=${repairoptions[$3]}

case $opt in
    "Local Instance")
        case $lopt in
            "Install")
                if test -f ./docker/docker-compose.yml
                then
                        echo "Creating Containers"
                        cd docker
                        sudo docker compose up -d 
                        sleep 3
                        # clear
                        sudo docker ps
                        sleep 5
                        # clear
                        echo "First Config - Postgres"
                        sudo docker exec -it postgres sh /tmp/psrun.sh
                        sleep 2
                        # clear
                        echo "First Config - Grafana"
                        sudo docker exec -it grafana sh /tmp/grafanarun.sh
                        sleep 2
                        # clear
                        echo "First Config - PgAdmin"
                        sudo docker exec -it pgadmin sh /tmp/pgrun.sh
                else
                    echo "Error: Files doesn't exists, dowloading" 
                    if [ -d "$dir/.git" ]
                    then
                        git pull origin main
                    else
                        git clone https://github.com/hectorrf16/FinalProjectDO ../FinalProjectDO
                    fi
                fi
                ;;
            "Start")
                echo "Starting the installed instance"
                cd docker
                sudo docker compose up -d
                ;;
            "Repair")
                cd docker
                case $ropt in
                    "Postgres")
                        # clear
                        echo "Restoring Postgres instance"
                        sudo docker stop postgres && sudo docker remove postgres && sudo docker volume rm docker_postgres-db && sudo docker compose up -d db
                        sleep 5
                        # clear
                        echo "First Config - Postgres"
                        sudo docker exec -ti postgres sh /tmp/psrun.sh
                        ;;
                    "App")
                        # clear
                        echo "Restoring App instance"
                        sudo docker stop python-app && sudo docker remove python-app && sudo docker compose up -d app
                        ;;
                    "PgAdmin")
                        # clear
                        echo "Restoring PgAdmin instance"
                        sudo docker stop pgadmin && sudo docker remove pgadmin && sudo docker volume rm docker_pgadmin-data && sudo docker compose up -d pgadmin
                        sleep 2
                        # clear
                        echo "First Config - PgAdmin"
                        sudo docker exec -ti pgadmin sh /tmp/pgrun.sh
                        ;;
                    "Grafana")
                        # clear
                        echo "Restoring Grafana instance"
                        sudo docker stop grafana && sudo docker remove grafana && sudo docker volume rm docker_grafana-data && sudo docker compose up -d grafana
                        sleep 2
                        # clear
                        echo "First Config - Grafana"
                        sudo docker exec -it grafana sh /tmp/grafanarun.sh
                        ;;
                    "All")
                        # clear
                        echo "Restoring all instances"
                        sudo docker compose down && sudo docker componse up -d
                        ;;
                    *) echo "Invalid option \"$REPLY\"";;
                esac
                ;;
            "Uninstall")
                cd docker
                echo "Uninstalling local instance"
                sudo docker compose down && sudo docker volume rm docker_postgres-db docker_grafana-data docker_pgadmin-data
                sudo docker ps
                ;;
            "Upload Images to Docker Hub")
                echo "Login into Docker Hub"
                sudo docker login
                echo "Uploading images to docker hub"
                for i in "${containers[@]}"
                do
                    sudo docker ps | grep $i | awk '{print $2}' | xargs -i docker tag {} hectorrf16/finalprojectdo:$i && docker image push hectorrf16/finalprojectdo:$i
                done
                ;;
            *)
                echo "Invalid option \"$REPLY\"";;
        esac
        ;;
    "Cloud Instance")
        echo "Working on it"
        ;;
    *) echo "Invalid option \"$REPLY\"";;
esac

exit 0;