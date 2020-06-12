#1/bin/bash
#amass
echo "start amass...."
amass enum -passive -d $1 -o $2/amass.txt &> /dev/null
dm_nbr=$(wc -l $2/amass.txt|awk '{print $!F}')
echo -e  "a\e[36mamass \e[39m find  \e[36m$dm_nbr  domains \e[39m"


