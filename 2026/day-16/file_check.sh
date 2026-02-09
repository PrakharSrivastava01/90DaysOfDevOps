#!/bin/bash

read -p " Enter the filename: " file

if [ -f "$file" ];then
	echo " file exists..!"
else
	echo "file not exists..!"

fi
