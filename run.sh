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
    options=("Install local instance" "Install cloud instance" "Repair local instance")
    echo -e "What do you want to do?\n"
    select opt in "${options[@]}" Quit
    do
        case $opt in
            "Install local instance")
                username=$(whoami)
                
                if [-d "./docker"]
                then
                        echo "Running Containers Creation"
                        sudo docker build --pull --rm -f app-dockerfile -t finalprojectdo:app
                        sudo docker ps | awk  '$NF ~/python/{print $1}' | xargs -i docker container commit '{}' add && docker image tag app:latest hectorrf16/finalprojectdo && docker image push hectorrf16/finalprojectdo
                        sudo docker compose up -d
                        sudo docker ps
                else
                    echo "Error: Files doesn't exists, dowloading" 
                    if [-d "./.git"]
                    then
                        git pull origin main
                    else
                        git clone https://github.com/hectorrf16/finalprojectdo ../finalprojectdo
                    fi
                fi
                break;;

            "Install cloud instance")
                echo "Working on it"
                break;;

            "Repair local instance")
                clear
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

            "Quit")
                break;;

            *) echo "Invalid option \"$REPLY\"";;
        esac
    done
}

main "$@"