#!/bin/bash 
function help(){
echo "usage:"
echo -e "\t f \t read from file"
echo -e "\t d \t domain"
}


function enum(){
#assetfinder
echo -ne "\e[33m$1\e[0m"\\r
assetfinder -subs-only $1 >>assetfinder_$1.txt &> /dev/null
#amass
amass enum -passive -d $1 -o ./amass_$1.txt &> /dev/null
#sublister
sublist3r -d $1  -t 40 -o ./sublister_$1.txt &> /dev/null
#findomain
findomain -t $1 -u findomain_$1.txt &> /dev/null 
#choas
chaos -d $1 -o choas_$1.txt  -silent &> /dev/null
#git search


find ./ -type f |grep "$1.txt"|sort -u >$1_subdomain.txt
cat $1_subdomain.txt | httprobe -prefer-https |tee -a $1_hosts.txt

}



function fl(){

if [ -f $1 ];then
	export -f enum
	cat $1 |xargs -n 1 -P 10 -I {} bash -c 'enum "$@"' _ {}
fi

}

while getopts ":f:d:" OPTION
do
        case $OPTION in
                f)
			fl $OPTARG
                        exit
                        ;;
                d)
                        enum $OPTARG
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




