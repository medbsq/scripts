#!/bin/bash 

mkdir -p $1_program
cd ./$1_program
mv ../$1 ./scope
if [ -f scope ];then
	cat scope   |xargs -n 1 -P 200 -I {} bash -c 'assetfinder -subs-only {}|tee -a Domains '
	subfinder -dL ./scope -all |tee -a Domains
	cat Domains | sort -u -o Domains
	cat Domains | xargs -n 1 -P 200 -I {} bash -c 'httprobe -prefer-https|tee -a Hosts '
	cat Domains | httpx -threads 500 |tee -a Hosts 
	cat Hosts   |sort -u -o Hosts
fi
