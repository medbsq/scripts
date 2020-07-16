#!/bin/bash
echo -en "\e[33mgoogle api key: $1 \e[0m \n"
cat google_urls|while read a ;do
	url=$(echo $a |awk '{print $NF}')
	ty=$(echo $a |awk '{print $1F}')
	curl -s  $url$1  -o /dev/null  -w  "$ty [%{http_code}] \n"  
done
