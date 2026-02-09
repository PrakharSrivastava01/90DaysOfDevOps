#!/bin/bash

read -p "Enter the number : " number

if [ " $number" -gt 0 ]; then
	echo "positive"
elif [ "$number" -lt 0 ]; then 
	echo "negative"
else 
	echo "number is zero"
fi
