#!/bin/bash


for i in $(cat $1 |unfurl format %s://%d |sort -u );do
	cat $1 |grep "$i" > $(echo $i|cut -d "/" -f 3 )
done
