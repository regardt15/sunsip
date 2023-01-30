#!/usr/bin/env bash  
                                                           
echo "Usb event: $1 $2 $3 $4" >> /var/log/docker_tty.log        
if [ ! -z "$(docker ps -qf name=env_dev)" ]                                     
then                                                                            
if [ "$1" == "added" ]                                                          
    then                                                                        
        docker exec -u 0 env_dev mknod $2 c $3 $4                               
        docker exec -u 0 env_dev chmod -R 777 $2                                
        echo "Adding $2 to docker" >> /var/log/docker_tty.log                
    else                                                                        
        docker exec -u 0 env_dev rm $2                                          
        echo "Removing $2 from docker" >> /var/log/docker_tty.log            
    fi                                                                          
fi 
