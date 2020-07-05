#!/bin/bash
 
function help(){
echo "usage:"
echo "this script need a urls and regex for specify the scope"
echo -e "\t l \t fetch list of js file(require)"
echo -e "\t u \t get all urls "
echo -e "\t p \t get all paths"
#echo -e "\t t \t get all token "

}



function crl(){
mkdir -p ./js_output
echo -ne "curl  $1"\\r
filename=$(echo "$1" | sha256sum |awk '{print $1}')
curl -sL  $1 -o ./js_output/$filename &>/dev/null
echo "$1    $filename" >> ./js_output/index
}


function get_urls(){
	find  ./  -type f|grep   -oriahE  "https?://[^\"\\'> ]+"
}

function get_paths(){
        find  ./  -type f|grep   -oriahE  "//[^\"\\'> ]+"
}


function secret(){

find  ./  -type f|grep -f ./reg.txt  -irEhnao

}



function fetch(){
cat $1 |grep -iE ".js$" > list.txt
export -f crl 
cat list.txt |xargs -n 1 -P 10 -I {}  bash -c ' crl "$@"' _ {}
rm list.txt
}



while getopts ":l:u:p:" OPTION
do
        case $OPTION in
                l)
                        fetch "$OPTARG"
			exit 
                        ;;
                u)
                        get_urls "$OPTARG"
			exit 
                        ;;
                p)
                        get_paths "$OPTARG"
			exit
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


