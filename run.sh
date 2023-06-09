#!/usr/bin/env bash

if test $# -lt 1
then
    echo -e "execute 'bash $0 [0-4] [0-8]' to run the app" 
    echo -e "example: 'bash $0 0' to install Containers or 'bash $0 2 0' to repair Postgres" 
    exit 1 
elif test $1 = "--help"
then
    echo -e "execute 'bash $0 [0-4] [0-8]' to run the app \n" 
    echo -e "example: 'bash $0 0' to install Containers or 'bash $0 2 0' to repair Postgres\n" 
    echo 'First param: ("0) Install" "1) Start" "2) Repair" "3) Uninstall" "4) Upload Images to Docker Hub") '
    echo 'Second param: ("0) Postgres" "1) App" "2) PgAdmin" "3) Grafana" "4) Prometheus" "5) Elastic" "6) Kibana" "7) Filebeat" "8) All") '
    exit 0
else
    case $# in
        0)
            echo 'First param: ("0) Install" "1) Start" "2) Repair" "3) Uninstall" "4) Upload Images to Docker Hub") '
            echo 'Second param: ("0) Postgres" "1) App" "2) PgAdmin" "3) Grafana" "4) Prometheus" "5) Elastic" "6) Kibana" "7) Filebeat" "8) All") '
            exit 1
            ;;
        1)
            if test $1 -gt 4
            then
                echo "Error in First param, it should be like:"
                echo 'First param: ("0) Install" "1) Start" "2) Repair" "3) Uninstall" "4) Upload Images to Docker Hub") '
                exit 1
            fi
            ;;
        2)
            if test $1 -gt 4
            then
                echo "Error in First param, it should be like:"
                echo 'First param: ("0) Install" "1) Start" "2) Repair" "3) Uninstall" "4) Upload Images to Docker Hub") '
                exit 1
            fi

            if test $2 -gt 8
            then
                echo "Error in Second param, it should be like:"
                echo 'Second param: ("0) Postgres" "1) App" "2) PgAdmin" "3) Grafana" "4) Prometheus" "5) Elastic" "6) Kibana" "7) Filebeat" "8) All") '
                exit 1
            fi

            ;;
        *)
            echo 'First param: ("0) Install" "1) Start" "2) Repair" "3) Uninstall" "4) Upload Images to Docker Hub") '
            echo 'Second param: ("0) Postgres" "1) App" "2) PgAdmin" "3) Grafana" "4) Prometheus" "5) Elastic" "6) Kibana" "7) Filebeat" "8) All") '
            exit 1
            ;;
    esac
fi

containers=("app" "pgadmin" "grafana" "postgres" "prometheus" "elastic" "kibana" "filebeat")
option=("Install" "Start" "Repair" "Uninstall" "Upload Images to Docker Hub")
repairoptions=("Postgres" "App" "PgAdmin" "Grafana" "Prometheus" "Elastic" "Kibana" "Filebeat" "All")
# echo -e "What do you want to do?\n"
opt=${option[$1]}
ropt=${repairoptions[$2]}

case $opt in
    "Install")
        if test -f ./docker/docker-compose.yml
        then
                echo "Creating Containers"
                cd docker
                sudo docker compose up -d 
                sleep 3
                # clear
                sudo docker ps
                sleep 10
                # clear
                echo "First Config - Postgres"
                sudo docker exec -it postgres bash /tmp/psrun.sh
                # clear
                echo "First Config - Grafana"
                sudo docker exec -it grafana sh /tmp/grafanarun.sh
                sleep 10
                # clear
                echo "First Config - PgAdmin"
                sudo docker exec -it pgadmin sh /tmp/pgrun.sh
                sleep 10
                echo "First Config - Kibana"
                curl -X POST "localhost:5601/api/data_views/data_view" -H 'kbn-xsrf: true' -H 'Content-Type: application/json' -d'{"data_view": {"title": "filebeat-*","name": "Logs"}}'

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
            "Prometheus")
                # clear
                echo "Restoring Prometheus instance"
                sudo docker stop prometheus && sudo docker remove prometheus && sudo docker volume rm docker_prometheus-data && sudo docker compose up -d prometheus
                # sleep 2
                # clear
                # echo "First Config - Prometheus"
                # sudo docker exec -it grafana sh /tmp/grafanarun.sh
                ;;
            "Elastic")
                echo "Restoring Elastic instance"
                sudo docker stop elastic && sudo docker remove elastic && sudo docker volume rm docker_elastic-data && sudo docker compose up -d elastic
                ;;
            "Kibana")
                echo "Restoring Kibana instance"
                sudo docker stop kibana && sudo docker remove kibana && sudo docker compose up -d kibana
                sleep 2
                echo "First Config - Kibana"
                sleep 15
                curl -X POST "localhost:5601/api/data_views/data_view" -H 'kbn-xsrf: true' -H 'Content-Type: application/json' -d'{"data_view": {"title": "filebeat-*","name": "Logs"}}'
                ;;
            "Filebeat")
                echo "Restoring Filebeat instance"
                sudo docker stop filebeat && sudo docker remove filebeat && sudo docker volume rm docker_filebeat-data && sudo docker compose up -d filebeat
                ;;
            "All")
                # clear
                echo "Restoring all instances"
                sudo docker compose down && sudo docker compose up -d
                ;;
            *) echo "Invalid option \"$REPLY\"";;
        esac
        ;;
    "Uninstall")
        cd docker
        echo "Uninstalling local instance"
        sudo docker compose down && sudo docker volume rm docker_postgres-db docker_grafana-data docker_pgadmin-data docker_prometheus-data docker_elastic-data docker_filebeat-data
        sudo docker ps
        ;;
    "Upload Images to Docker Hub")
        echo "Login into Docker Hub"
        sudo docker login
        echo "Uploading images to docker hub"
        cd docker
        sudo docker compose up -d
        cd ../
        sleep 20
        for i in "${containers[@]}"
        do
            sudo docker ps | grep $i | awk '{print $1}' | xargs -i docker commit {} hectorrf16/finalprojectdo:$i && docker image push hectorrf16/finalprojectdo:$i
        done
        ;;
    *)
        echo "Invalid option \"$1\"";;
esac
exit 0;