#!/bin/bash
   
for prog in $(cat programs);do
	cd $prog
	for dir in $(find ./ -name "nuclei_*"|grep -v "nuclei_Hosts");do
	for res i $(ls $dir);do 
			cat $dir/$res >> ./nuclei_Hosts/$res
		done
	done

	cat Hosts* |sort -u -o Hosts
	cat Domains*|sort -u -o Domains  
	rm $di $(ls|grep -E "Hosts[0-9]")  $(ls|grep -E "Domains[0-9]") 


	cd ..
done

