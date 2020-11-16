#!/bin/bash


function ssrf(){	
	hash=$(echo $1  | sha256sum |cut -d ' '  -f 1)
	echo "$hash     $1" >> hash_$3
	host=$hash.$2
	curl  -H "Host: $host"  $1

collab=$2
export -f ssrf

cat $1 |xargs -n 1 -P 10 -I {} bash -c 'ssrf "$@"' _ {} $2 $1




