#!/bin/bash (shebang)

for i in {1..5};
do
    read -p "Enter the username : " user
    sudo useradd -m $user
    echo "user $user added successfully"
done
