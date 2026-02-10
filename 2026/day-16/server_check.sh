#!/bin/bash


read -p " Which service's status You want to check: ? " service
read -p " Do you want to check the status of $service ? Y/N/D " answer

if [ "$answer" = "Y" ];then
	sudo systemctl status "$service"
	echo " $service is running "

elif [ "$answer" = "D" ];then
	 sudo apt-get update &> /dev/null
         sudo apt-get install "$service" 
         echo " Installation done..! " &> /dev/null
	 sudo systemctl start "$service"
    	 sudo systemctl status "$service"

elif [ "$answer" = "N" ];then
	echo "skipped"

else
	echo " Task successfully..! "
fi
