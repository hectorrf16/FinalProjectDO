#!/usr/bin/env bash

set -o errexit

main() {
    local task=$1

    case $task in
        *) menu;;
    esac
}

menu() {
    clear

    COLUMNS=12
    PS3="Please, enter your choice: "
    containers=("app" "pgadmin" "grafana" "postgres")
    options=("Local Instance" "Cloud Instance")
    localoption=("Install" "Start" "Repair" "Uninstall" "Upload Images to Docker Hub")
    repairoptions=("Postgres" "App" "PgAdmin" "Grafana" "Jenkins" "All")
    echo -e "What do you want to do?\n"
    select opt in "${options[@]}" Quit
    do
        case $opt in
            "Local Instance")
                clear
                echo -e "For Local Instances, what do you want to do?\n"
                select lopt in "${localoption[@]}" Quit
                do
                    case $lopt in
                        "Install")
                            clear
                            username=$(whoami)
                            dir=$(pwd)
                            
                            if [ -d "$dir/docker" ]
                            then
                                    echo "Creating Containers"
                                    cd docker
                                    sudo docker compose up -d 
                                    sleep 3
                                    clear
                                    sudo docker ps
                                    sleep 5
                                    clear
                                    echo "First Config - Postgres"
                                    sudo docker exec -it postgres sh /tmp/psrun.sh
                                    sleep 2
                                    clear
                                    echo "First Config - Grafana"
                                    sudo docker exec -it grafana sh /tmp/grafanarun.sh
                                    sleep 2
                                    clear
                                    echo "First Config - PgAdmin"
                                    sudo docker exec -it pgadmin sh /tmp/pgrun.sh
                                    sleep 2
                                    clear
                                    echo "First Config - Jenkins"
                                    sudo docker exec -it jenkins sh /tmp/jkrun.sh
                            else
                                echo "Error: Files doesn't exists, dowloading" 
                                if [ -d "$dir/.git" ]
                                then
                                    git pull origin main
                                else
                                    git clone https://github.com/hectorrf16/FinalProjectDO ../FinalProjectDO
                                fi
                            fi
                            break;;
                        "Start")
                            echo "Starting the installed instance"
                            cd docker
                            sudo docker compose up -d
                            break;;
                        "Repair")
                            clear
                            cd docker
                            
                            echo -e "What instance would you like to repair?\n"
                            select ropt in "${repairoptions[@]}" Quit
                            do
                                case $ropt in
                                    "Postgres")
                                        clear
                                        echo "Restoring Postgres instance"
                                        sudo docker stop postgres && sudo docker remove postgres && sudo docker volume rm docker_postgres-db && sudo docker compose up -d db
                                        sleep 5
                                        clear
                                        echo "First Config - Postgres"
                                        sudo docker exec -ti postgres sh /tmp/psrun.sh
                                        break;;
                                    "App")
                                        clear
                                        echo "Restoring App instance"
                                        sudo docker stop python-app && sudo docker remove python-app && sudo docker compose up -d app
                                        break;;
                                    "PgAdmin")
                                        clear
                                        echo "Restoring PgAdmin instance"
                                        sudo docker stop pgadmin && sudo docker remove pgadmin && sudo docker volume rm docker_pgadmin-data && sudo docker compose up -d pgadmin
                                        sleep 2
                                        clear
                                        echo "First Config - PgAdmin"
                                        sudo docker exec -ti pgadmin sh /tmp/pgrun.sh
                                        break;;
                                    "Grafana")
                                        clear
                                        echo "Restoring Grafana instance"
                                        sudo docker stop grafana && sudo docker remove grafana && sudo docker volume rm docker_grafana-data && sudo docker compose up -d grafana
                                        sleep 2
                                        clear
                                        echo "First Config - Grafana"
                                        sudo docker exec -it grafana sh /tmp/grafanarun.sh
                                        break;;
                                    "Jenkins")
                                        clear
                                        echo "Restoring Jenkins instance"
                                        if ['docker ps -a -f status=running --format 'table {{.Names}}' -f 'name=jenkins' | awk 'NR>1{print}'' -eq 'jenkins']
                                        then
                                            sudo docker stop jenkins && sudo docker remove jenkins && sudo docker volume rm docker_jenkins-data && sudo docker image rm docker-jenkins --force && sudo docker compose up -d jenkins
                                        else
                                            sudo docker image rm docker-jenkins --force && sudo docker compose up -d jenkins
                                        fi
                                        sleep 2
                                        clear
                                        echo "First Config - Jenkins"
                                        sudo docker exec -it jenkins sh /tmp/jkrun.sh
                                        break;;
                                    "All")
                                        clear
                                        echo "Restoring all instances"
                                        sudo docker compose down && sudo docker componse up -d
                                        break;;
                                    "Quit")
                                        break;;
                                    *) echo "Invalid option \"$REPLY\"";;
                                esac
                            done
                            break;;
                        "Uninstall")
                            cd docker
                            echo "Uninstalling local instance"
                            sudo docker compose down && sudo docker volume rm docker_postgres-db docker_grafana-data docker_pgadmin-data docker_jenkins-data
                            sudo docker ps
                            break;;
                        "Upload Images to Docker Hub")
                            echo "Login into Docker Hub"
                            sudo docker login
                            echo "Uploading images to docker hub"
                            for i in "${containers[@]}"
                            do
                                sudo docker ps | grep $i | awk '{print $2}' | xargs -i docker tag {} hectorrf16/finalprojectdo:$i && docker image push hectorrf16/finalprojectdo:$i
                            done
                            break;;
                        "Quit")
                            break;;
                        *)
                            echo "Invalid option \"$REPLY\"";;
                    esac
                done
                break;;
            "Cloud Instance")
                echo "Working on it"
                break;;
            "Quit")
                break;;
            *) echo "Invalid option \"$REPLY\"";;
        esac
    done
}

main "$@"