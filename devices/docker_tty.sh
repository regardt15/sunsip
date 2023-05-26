#!/usr/bin/env bash

echo "$(date): Usb event: $1 $2 $3 $4 $5" >> /var/log/docker_tty.log
if [ ! -z "$(docker ps -qf name=homeassistant)" ]
then
if [ "$1" == "added" ]
    then
        docker exec -u 0 homeassistant mknod $2 c $3 $4
        docker exec -u 0 homeassistant chmod -R 777 $2
        docker exec -u 0 homeassistant ln -s $2 /dev/ttyINVERTER$5
        echo "$(date): Adding $2 (inverter $5) to docker" >> /var/log/docker_tty.log
    else
        docker exec -u 0 homeassistant rm $2
        docker exec -u 0 homeassistant rm /dev/ttyINVERTER$5
        echo "$(date): Removing $2 (inverter $5) from docker" >> /var/log/docker_tty.log
    fi
fi
