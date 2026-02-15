#!/bin/bash

read -p "Enter the number : " user

n="$user"

while ((n >= 10));
do
	echo " $n "
	((n--))
done
