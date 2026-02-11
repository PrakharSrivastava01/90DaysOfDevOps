#!/bin/bash

<< help
-s - Status flag (checks if package is installed)
Exit code 0 = Package is installed ✓ ( Condition is true )
Exit code 1 = Package is NOT installed ✗ ( Condition is false )
If status code is "0", then it will go to else(error) part and if status code is "1", then it will go to then(successful) part.
[] = only when there's a condition, else, no use of [].
help

read -p " Enter the package, you want to install : " package
echo "checking if the package is already installed or not..!"

if dpkg -s $package >/dev/null 2>&1; then  #dpkg=Debian package manager 2=standard output 1 & standard error 2
    echo "$package is already installed."
    exit 1
else
    sudo apt-get update &> /dev/null
    sudo apt-get install $package -y &> /dev/null
    systemctl status $package
fi

echo "Updating the system & installing the package"
sudo apt-get install $package
systemctl status $package

echo "$package installed..!"