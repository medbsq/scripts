#!/bin/bash

function crl(){
mkdir -p ./output
echo -ne "curl  $1"\\r
filename=$(echo "$1" | sha256sum |awk '{print $1}')
curl -sL  $1 -o ./output/$filename &>/dev/null
echo "$1     $filename" >> ./output/index
}




function crowl(){
if [ -f $1 ];then
	old=1
	cat $1 > new.txt
	export -f crl
	touch paths.txt
else
	echo "no  sush file or directory !!!!"
	old=0
fi
new=0
while [ $new -ne $old ] ;do 
	echo "start "
	cat new.txt |xargs -n 1 -P 10 -I {} bash -c 'crl "$@"' _ {}
	find ./output/ -type f| grep -oirahE "https?://[^\"\\'> ]+"|grep -iE "$2" |sort -u >urls.txt
	comm --nocheck-order -1 paths.txt urls.txt > new.txt
	old=$(cat paths.txt |wc -l)
	cat new.txt >>paths.txt
	new=$(cat paths.txt |wc -l)
done

rm -rf  urls.txt new.txt
echo "$(cat paths.txt &2>/dev/null |wc -l) url founds"
}


crowl $1
