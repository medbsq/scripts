#!/bin/bash
function pre(){
        j=0
        for i in $(cat $1);do
                h=$j.$2
                echo "$h $i" >> ref_$1
                ((j+=1))

        done

}


function req(){
        url=$(echo $1  |cut -d " " -f 2 )
        host=$(echo $1 |cut -d " " -f 1)
        echo "$url"    |httpx  -retries 3 -H 'Host: $host' -silent
	echo "$url"    |httpx  -retries 3 -H 'Base-Url: $host' -silent
	echo "$url"    |httpx  -retries 3 -H 'Http-Url: $host' -silent
	echo "$url"    |httpx  -retries 3 -H 'Proxy-Host: $host' -silent
	echo "$url"    |httpx  -retries 3 -H 'Proxy-Url: $host' -silent
	echo "$url"    |httpx  -retries 3 -H 'Real-Ip: $host' -silent
	echo "$url"    |httpx  -retries 3 -H 'Redirect: $host' -silent
	echo "$url"    |httpx  -retries 3 -H 'Referer: $host' -silent
	echo "$url"    |httpx  -retries 3 -H 'Referrer: $host' -silent
	echo "$url"    |httpx  -retries 3 -H 'Refferer: $host' -silent
	echo "$url"    |httpx  -retries 3 -H 'Request-Uri: $host' -silent
	echo "$url"    |httpx  -retries 3 -H 'Uri: $host' -silent
	echo "$url"    |httpx  -retries 3 -H 'Url: $host' -silent
	echo "$url"    |httpx  -retries 3 -H 'X-Forwarded: $host' -silent
	echo "$url"    |httpx  -retries 3 -H 'X-Forwarded-By: $host' -silent
	echo "$url"    |httpx  -retries 3 -H 'X-Forwarded-For: $host' -silent
	echo "$url"    |httpx  -retries 3 -H 'X-Forwarded-For-Original: $host' -silent
	echo "$url"    |httpx  -retries 3 -H 'X-Forwarded-Host: $host' -silent
	echo "$url"    |httpx  -retries 3 -H 'X-Forwarded-Server: $host' -silent
	echo "$url"    |httpx  -retries 3 -H 'X-Forwarder-For: $host' -silent
	echo "$url"    |httpx  -retries 3 -H 'X-Forward-For: $host' -silent
	echo "$url"    |httpx  -retries 3 -H 'X-Host: $host' -silent
	echo "$url"    |httpx  -retries 3 -H 'X-Http-Destinationurl: $host' -silent
	echo "$url"    |httpx  -retries 3 -H 'X-Http-Host-Override: $host' -silent
	echo "$url"    |httpx  -retries 3 -H 'X-Original-Remote-Addr: $host' -silent
	echo "$url"    |httpx  -retries 3 -H 'X-Original-Url: $host' -silent
	echo "$url"    |httpx  -retries 3 -H 'X-Proxy-Url: $host' -silent
	echo "$url"    |httpx  -retries 3 -H 'X-Real-Ip: $host' -silent
	echo "$url"    |httpx  -retries 3 -H 'X-Remote-Addr: $host' -silent
	echo "$url"    |httpx  -retries 3 -H 'X-Rewrite-Url: $host' -silent
        echo "$host $url"
}


function deg(){
echo "$1"
}

pre $1 $2
export -f req
cat ref_$1| xargs -n 1 -P 100  -I {} bash -c 'req "$@"' _ {}


