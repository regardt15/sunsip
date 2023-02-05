#!/usr/bin/env bash  
                                                           
echo "Usb event: $1 $2 $3 $4" >> /var/log/docker_tty.log        
if [ ! -z "$(docker ps -qf name=voltronic-mqtt)" ]                                     
then                                                                            
if [ "$1" == "added" ]                                                          
    then                                                                        
        docker exec -u 0 voltronic-mqtt mknod $2 c $3 $4                               
        docker exec -u 0 voltronic-mqtt chmod -R 777 $2                                
        docker exec -u 0 voltronic-mqtt ln -s $2 /dev/ttyUSB-SERIAL
        echo "Adding $2 to docker" >> /var/log/docker_tty.log                
    else                                                                        
        docker exec -u 0 voltronic-mqtt rm $2                                          
        docker exec -u 0 voltronic-mqtt rm /dev/ttyUSB-SERIAL
        echo "Removing $2 from docker" >> /var/log/docker_tty.log            
    fi                                                                          
fi 
