#!/bin/bash

for prog in $(cat programs);do
	cd $prog
	cat scope |xargs -n 1 -P 100 -I {} bash -c 'assetfinder -subs-only {}|tee -a Domains2'
	cat Domains2 |httpx -threads 500 |tee -a h
	cat h |sort -u -o h
	cat Hosts |sort -u -o Hosts
	comm -23  h Hosts> Hosts2
	rm h 
	cd .. 
done

