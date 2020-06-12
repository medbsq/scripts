#!/bin/bash

echo "start findomain....."
findomain -t $1  >> $2/d
cat $2/d |grep -v -iE  "(Target ==>|A total of)" |grep "$1" > $2/finddomain.txt
dm_nbr= $(wc -l $2/finddomain.txt |awk '{print $1F}')
echo -e "\e[36m finddomain \e[39m find  \e[36m$dm_nbr domains \e[39m"
rm $2/d

