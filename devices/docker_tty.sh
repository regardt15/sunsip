#!/usr/bin/env bash  
                                                           
echo "Usb event: $1 $2 $3 $4" >> /var/log/docker_tty.log        
if [ ! -z "$(docker ps -qf name=homeassistant)" ]                                     
then                                                                            
if [ "$1" == "added" ]                                                          
    then                                                                        
        docker exec -u 0 homeassistant mknod $2 c $3 $4                               
        docker exec -u 0 homeassistant chmod -R 777 $2                                
        docker exec -u 0 homeassistant ln -s $2 /dev/ttyUSB-SERIAL
        echo "Adding $2 to docker" >> /var/log/docker_tty.log                
    else                                                                        
        docker exec -u 0 homeassistant rm $2                                          
        docker exec -u 0 homeassistant rm /dev/ttyUSB-SERIAL
        echo "Removing $2 from docker" >> /var/log/docker_tty.log            
    fi                                                                          
fi 
