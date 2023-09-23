#!/bin/bash

read -p "Enter UserName: " x

y=$(who | awk '{print $1}' | grep $x)
if [ "$x" = "$y" ]
then
	echo "$x is logged in"
else
	echo "$x not logged in"
fi
