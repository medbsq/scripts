#1/bin/bash

#sublister
echo "start sublister...."
sublist3r -d $1 -o $2/sublister.txt &> /dev/null
dm_nbr=$(wc -l $2/sublister.txt |awk '{print $1F}')
echo  -e "\e[36m sublister  \e[39m finds \e[36m$dm_nbr domains \e[39m"

