#!/bin/bash

function help(){
echo "usage:"	
echo -e "\\t -h	help"
echo -e "\\t -d test one domain"
echo -e "\\t -l test a list of domain"
echo -e "\\t -f	fetch data "
echo -e "\\t -g	get responses"

}

#work with f option 
function fetch(){
echo "$1"
cd output/ && find ./  -type f |grep -HnroE "$1"|awk  -F":" '{print $1F}'|xargs -n1  -P10 -I{} grep {} index |sort -u
}

function gether(){

export -f echo_var
seq -f "n%04g" 1 100 | xargs -n 1 -P 10 -I {} bash -c 'echo_var "$@"' _ {}
}

function curl_it(){
mkdir -p ./output
echo -ne "curl  $1"\\r
filename=$(echo "$1" | sha256sum |awk '{print $1}')
curl -sL  $1 -o ./output/$filename &>/dev/null
echo "$1     $filename" >> ./output/index
#this is test for git cmd 
}


function verify(){
domain=$1.service-now.com
echo -e "\e[32m$domain \e[0m"
if host $domain &>/dev/null;then
           tst $domain
else
           echo -e "\e[31m not exist!!!! \e[0m"
fi

}

function verify_list(){
if [ -a $1 ];then
	cat $1 |while read d ;do
		domain=$d.service-now.com
		echo -e "\e[32m$domain \e[0m  "
		if host $domain &>/dev/null;then
			tst $domain
		else
			echo -e "\e[31m not exist!!!! \e[0m"
		fi
	done
else
	echo "no such file "
fi
}


function tst(){
	 url=https://$1/kb_view_customer.do?sysparm_article=KB001
	seq -w 1 100 1000 |xargs -n1 -P10 -I{}  curl -s -w "%{url_effective}    %{http_code}    %{size_download} \n"  $url{} -o /dev/null
}



while getopts ":f:g:d:l:" OPTION
do
	case $OPTION in
		d)
                        verify "$OPTARG"
                        exit
                        ;;

		l)
                        verify_list "$OPTARG"
                        exit
                        ;;

		f)
			fetch "$OPTARG"	
			exit
			;;
		g)
			export -f curl_it 
			cat "$OPTARG" | xargs -n 1 -P 10 -I {} bash -c 'curl _it  "$@"' _ {}
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



