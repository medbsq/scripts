#!/bin/bash

function crl(){
mkdir -p ./output
echo -ne "curl  $1"\\r
filename=$(echo "$1" | sha256sum |awk '{print $1}')
curl -sL  $1 -m 3 -o ./output/$filename &>/dev/null
echo "$1     $filename" >> ./output/index
}



function crowl(){
mkdir -p js
cd js 
cp ../$1 ./

if [ $# -lt 1 ];then
	help 
	exit 1
fi

echo -e "crowl: \e[32m$1 \e[0m \ndeep: \e[32m  $2 \e[0m" 
if [ -f $1 ];then
	cat $1 > new.txt
else
	echo "$1" > new.txt
fi
export -f crl
touch paths.txt
for i in $(seq  $2);do
	cat new.txt |xargs -n 1 -P 10 -I {} bash -c 'crl "$@"' _ {}
	find ./output/ -type f| grep -oirahE "https?://[^\"\\'> ]+" |grep -viE "(jpg|jpej|gif|css|tif|tiff|png|ttf|woff|woff2|ico|svg)$" |sort -u >urls.txt
	comm --nocheck-order -13 paths.txt urls.txt > new.txt
	cat urls.txt >paths.txt
done

}
 
function help(){
echo "usage:"
echo "this script need a urls and regex for specify the scope"
echo -e "\t i \t input url or file (require)"
echo -e "\t d \t deep (default 3)"
}


deep=3
regex=""
while getopts ":i:d:" OPTION
do
        case $OPTION in
                i)
			input="$OPTARG" 
                        ;;
		d)
                        deep="$OPTARG"
                        ;;

		:)
                        help
                        exit 1
                        ;;
                \?)
                        help
                        exit 1
                        ;;

        esac
done

crowl $input  $deep
rm -rf  urls.txt new.txt
echo "$(cat paths.txt |wc -l) url founds"

