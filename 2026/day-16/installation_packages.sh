#!/bin/bash

read -p " Enter the package, you want to install : " package
echo " Installing the $package"

sudo apt-get update &> /dev/null
sudo apt-get install $package
systemctl status $package

echo "$package installed..!"