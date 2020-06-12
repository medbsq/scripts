#!/bin/bash 
#subfinder
echo "start subfinder...."
subfinder -d $1 -silent -o $2/subfinder.txt &> /dev/null
dm_nbr=$(wc -l $2/subfinder.txt|awk '{print $1F}')
echo -e  "\e[36m subfinder \e[39m find \e[36m$dm_nbr domains \e[39m"
