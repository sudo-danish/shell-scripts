#!/bin/bash

x=$(cat /etc/resolv.conf | grep -E "nameserver" | wc -l )
if [ $x -gt 2 ]
then
	echo "There are 2 DNS servers in this system "
elif [ $x -eq 1 ]
then
	echo "There are only one/primary Nameserver in this System "
else
	echo "there is no nameserver in this system "
fi

