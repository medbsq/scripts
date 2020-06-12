#1/bin/bash

#assetfinder
echo "start asseffinder...."
assetfinder  -subs-only $1 > $2/assetfinder.txt
dm_nbr=$(wc -l $2/assetfinder.txt|awk '{print $1F}')
echo -e "\e[36m assetfinder \e[39m find \e[36m$dm_nbr domain \e[39m"
