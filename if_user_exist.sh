#!/bin/bash

#read -p "user to check: " x
#if grep $x /etc/passwd
#then
#	echo "user $x exist"
#	ls -d "/home/shah3"
#	echo "homedir exist"
#else
#	echo "$x doesnt exist"
#fi


user=shah4
if [ $user = $(grep $user /etc/passwd) ]
then
	echo "$user exists"
else
	echo "$user doent exist"
fi
