#!/bin/bash

for i in {1..5};
do
        read -p "Enter the username" user
        sudo useradd $user
        echo "user added successfully.!!"
done