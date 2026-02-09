#!/bin/bash


read -p " Which service's status You want to check: ? " service
read -p " Do you want to check the status of $service ? Y/N " answer
 
if [ $answer=Y ];then
	sudo systemctl status $service
	echo " $service is running "
else
	echo " Skipped "

fi 

