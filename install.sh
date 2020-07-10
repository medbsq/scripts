#!/bin/bash

read -sp "sudo password :" password
for script in $(find  ./ -type d) ;do 
	scriptname=ls $script |grep -ie ".sh$"
	name=$(echo $scriptname |cut -d"." -f1)
	echo "$password" |sudo -S cp /script/$scriptname /usr/local/bin/$name
done
