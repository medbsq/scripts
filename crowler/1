#!/bin/bash

function crl(){
mkdir -p ./output
echo -ne "curl  $1"\\r
filename=$(echo "$1" | sha256sum |awk '{print $1}')
curl -sL  $1 -o ./output/$filename &>/dev/null
echo "$1     $filename" >> ./output/index
}



function crowl(){
if [ $# -lt 1 ];then
	help 
	exit 1
fi

echo -e "crowl: \e[32m$1 \e[0m \ndeep: \e[32m $3 \e[0m  \nregex:\e[32m  $2 \e[0m" 
if [ -f $1 ];then
	cat $1 > new.txt
else
	echo "$1" > new.txt
fi
#old=1
export -f crl
touch paths.txt
#new=0
#while [ $new -ne $old ] ;do
for i in $(seq  $3);do
	cat new.txt |xargs -n 1 -P 10 -I {} bash -c 'crl "$@"' _ {}
	find ./output/ -type f| grep -oirahE "https?://[^\"\\'> ]+"|grep -iE "$2" |sort -u >urls.txt
	comm --nocheck-order -13 paths.txt urls.txt > new.txt
#	old=$(cat paths.txt |wc -l)
	cat urls.txt >paths.txt
#	new=$(cat paths.txt |wc -l)
done

#rm -rf  urls.txt new.txt
#echo "$(cat paths.txt |wc -l) url founds"
}
 
function help(){
echo "usage:"
echo "this script need a urls and regex for specify the scope"
echo -e "\t i \t input url or file (require)"
echo -e "\t r \t regex for scope "
echo -e "\t d \t deep (default 3)"
}


deep=3
regex=""
while getopts ":i:r:d:" OPTION
do
        case $OPTION in
                i)
			input="$OPTARG" 
                        ;;
                r)
                        regex="$OPTARG"
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

crowl $input $regex $deep
rm -rf  urls.txt new.txt
echo "$(cat paths.txt |wc -l) url founds"

