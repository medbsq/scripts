#!/bin/bash
 
function help(){
echo "usage:"
echo "this script need a urls and regex for specify the scope"
echo -e "\t l \t fetch list of js file(require)"
echo -e "\t u \t get all urls "
echo -e "\t p \t get all paths"
}

function csv(){
	mkdir -p cve 
	for csv in $(ls $1/cves );do
		nuclei -t  $1/cves/$csv -v -l $2 -o "cve/$csv.txt"
	done
	for csv in $(ls $1/workflows);do
                nuclei -t  $1/workflows/$csv -v -l $2 -o "cve/$csv.txt"
        done

}

csv $1 $2



