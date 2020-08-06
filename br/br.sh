#!/bin/bash

function resolver(){
	domain=$1
	if host $domain &>/dev/null;then
                        echo -e "\e[31m$domain \e[0m"
                        echo $domain >>  domains

                else
                        echo -e "\e[32m$domain \e[0m"
                fi
	}

function make_list(){
	for i in $(cat $2);do
		 echo "$1.$i" >>list.txt
 	done

}

make_list $1 $2

export  -f resolver

cat ./list.txt |xargs -n 1  -P10 -I {} bash -c 'resolver "$@"' _ {}
rm  ./list.txt
