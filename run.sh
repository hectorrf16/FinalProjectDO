#!/bin/bash

set -o errexit

main() {
    local task=$1

    case $task in
        *) menu;;
    esac
}

menu() {
    clear

    columns=12
    PS3='Please, enter your choice: '
    options=("Install local instance" "Install cloud instance" "Repair local instance")
    echo -e "What do you want to do?\n"
    select opt in "${option[@]}" Quit
    do
        case $opt in
            "Install local instance")
                username=$(whoami)
                
                if [-d "./docker"]
                then
                    if groups $username | grep -q "\bdocker\b"
                    then
                        echo "Running Containers Creation"
                        docker build --pull --rm -f app-dockerfile -t app
                        docker ps | awk  '$NF ~/python/{print $1}' | xargs -i docker container commit '{}' app && docker image tag app:latest hectorrf16/finalprojectdo && docker image push hectorrf16/finalprojectdo
                        docker compose up -d
                        docker ps
                    else
                        echo "Running Containers Creation"
                        sudo docker build --pull --rm -f app-dockerfile -t finalprojectdo:app
                        sudo docker ps | awk  '$NF ~/python/{print $1}' | xargs -i docker container commit '{}' add && docker image tag app:latest hectorrf16/finalprojectdo && docker image push hectorrf16/finalprojectdo
                        sudo docker compose up -d
                        sudo docker ps
                    fi
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

                break;;

            "Repair local instance")

                break;;

            "Quit")
                break;;

            *) echo "Invalid option \"$REPLY\"";;
        esac
    done
}

main "$@"