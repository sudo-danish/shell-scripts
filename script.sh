#!/bin/bash

	# add single user with passwd script

#for i in `cat ./psd`
#do
#useradd $i
#echo abc | passwd --stdin $i 




for z in khan1 khan2; 
do sudo useradd $z;
echo abc | sudo passwd --stdin $z;
done


#for z in khan1 khan2;
#do sudo userdel $z;
#done


