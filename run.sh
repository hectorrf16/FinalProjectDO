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
    options=("Install local instance" "Start local instance" "Repair local instance" "Uninstall local instance" "Upload local image to Docker Hub" "Install cloud instance")
    echo -e "What do you want to do?\n"
    select opt in "${options[@]}" Quit
    do
        case $opt in
            "Install local instance")
                username=$(whoami)
                dir=$(pwd)
                
                if [ -d "$dir/docker" ]
                then
                        echo "Running Containers Creation"
                        cd docker
                        sudo docker compose up -d 
                        sudo docker ps

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
            "Start local instance")
                echo "Starting the installed instance"
                cd docker
                sudo docker compose up -d
                break;;
            "Repair local instance")
                clear
                cd docker
                repairoptions=("Postgres" "App" "PdAgmin" "Grafana" "All")
                echo -e "What instance would you like to repair?\n"
                select ropt in "${repairoptions[@]}" Quit
                do
                    case $ropt in
                        "Postgres")
                            echo "Restoring Postgres instance"
                            sudo docker stop postgres && sudo docker remove postgres && sudo docker compose up -d postgres &> /dev/null
                            break;;
                        "App")
                            echo "Restoring App instance"
                            sudo docker stop python-app && sudo docker remove python-app && sudo docker compose up -d python-app &> /dev/null
                            break;;
                        "PGadmin")
                            echo "Restoring PgAdmin instance"
                            sudo docker stop pgadmin && sudo docker remove pgadmin && sudo docker compose up -d pgadmin &> /dev/null
                            break;;
                        "Grafana")
                            echo "Restoring Grafana instance"
                            sudo docker stop grafana && sudo docker remove grafana && sudo docker compose up -d grafana &> /dev/null
                            break;;
                        "All")
                            echo "Restoring all instances"
                            sudo docker compose down && sudo docker componse up -d
                            break;;
                        "Quit")
                            break;;
                        *) echo "Invalid option \"$REPLY\"";;
                    esac
                done
                break;;
            "Uninstall local instance")
                cd docker
                echo "Uninstalling local instance"
                docker compose down && docker volume rm docker_postgres-db docker_grafana-data docker_pgadmin-data
                break;;
            "Upload local image to Docker Hub") 
                echo "Login into Docker Hub"
                docker login
                echo "Uploading images to docker hub"
                for i in "${containers[@]}"
                do
                    sudo docker ps | grep $i | awk '{print $2}' | xargs -i docker tag {} hectorrf16/finalprojectdo:$i && docker image push hectorrf16/finalprojectdo:$i
                done

                break;;
            "Install cloud instance")
                echo "Working on it"
                break;;

            "Quit")
                break;;

            *) echo "Invalid option \"$REPLY\"";;
        esac
    done
}

main "$@"