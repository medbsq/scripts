#!/bin/bash
 
function help(){
echo "usage:"
echo "this script need a urls and regex for specify the scope"
echo -e "\t u \t get all urls "
echo -e "\t p \t get all paths"
}

function ncl(){
	mkdir -p  nuclei_$1 
	for i in $(ls /home/mohamed/git_workspace/scripts/ncl/tmp) ;do 
		template="/home/mohamed/git_workspace/scripts/ncl/tmp/$i"
		output="./nuclei_$1/$i.txt"
		echo  -ne "\e[33mtemplate :  $i"\\r
		nuclei -t  $template   -silent  -l $1 -o $output
	done
}

ncl $1



