#!/bin/bash


function test(){
	for port in $(cat ./port.txt);do
		for host in $(cat host.txt);do
			cred="$port -t $host@$1" 
			echo -en "\e[32m$cred"\\r
			if ssh -p $cred -i id_rsa 2&> /dev/null ;then
				echo -e "\e[33m$cred  success !!!!"		
				exit	
			fi

		done
	done
}


if [ ! -f ./address.txt ];then
        echo  "file address.txt missing !!! "
        exit
elif [ ! -f ./port.txt ];then
        echo  "file port.txt missing !!! "
        exit
elif [ ! -f ./host.txt ];then
        echo  "file host.txt missing !!! "
        exit
else
	export -f test
	cat address.txt |xargs -n1 -P10 -I {}  bash -c 'test "$@"' _ {}
fi
