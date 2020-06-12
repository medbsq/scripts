#!/bin/bash

#function main(){
#	#set env
#	mkdir -p ./$1_domain
#	path="./$1_domain/"
	
	
#	~/scripts/domainEnum/fun_sublister.sh $1 $path
#	~/scripts/domainEnum/fun_amass.sh  $1 $path
#	~/scripts/domainEnum/fun_findomain.sh $1 $path
#	~/scripts/domainEnum/fun_amass.sh $1 $path
#	~/scripts/domainEnum/fun_subfinder.sh $1 $path
#	~/scripts/domainEnum/fun_collect.sh  $path


#}

if [ $# -eq 1 ];then
	if [ $(find . -iname "$1" |wc -l) -eq 1 ];then
	#	cat $1 |xargs -n1  -I{} ~/scripts/domainEnum/main.sh {}
	#	~/scripts/domainEnum/collect_all.sh $1	
	echo "no" &>/dev/null
	else
		~/scripts/domainEnum/main.sh $1
	fi
else
	echo "plase porvide a domain or file_list of domain"
fi

