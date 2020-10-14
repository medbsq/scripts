#!/bin/bash

for prog in $(cat programs);do
	cd $prog
	for i in $(cat scope);do
	assetfinder -subs-only $i|tee -a d

	done
	cat d |httpx -threads 50 |tee -a h
	cat h |sort -u -o h
	cat Hosts |sort -u -o Hosts
	comm -23  h Hosts> Hosts2
	rm h 
	cd .. 
done

