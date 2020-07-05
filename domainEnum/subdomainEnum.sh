#!/bin/bash

function amss(){
	echo "start amass...."
	amass enum -passive -d $1 -o ./amass.txt &> /dev/null
	#if [ -f ./amass.txt ];then
	#	m_nbr=$(wc -l ./amass.txt|awk '{print $!F}') 
	#	echo -e  "a\e[36mamass \e[39m find  \e[36m$dm_nbr  domains \e[39m"
	#fi

}
function assetfinder(){
	echo "start asseffinder...."
	assetfinder  -subs-only $1 > ./assetfinder.txt
	#if [ -f ./assetfinder.txt ];then
	#	dm_nbr=$(wc -l ./assetfinder.txt|awk '{print $1F}')
	#	echo -e "\e[36m assetfinder \e[39m find \e[36m$dm_nbr domain \e[39m"
	#fi
}


function sublister(){ 
	echo "start sublister...."
	sublist3r -d $1  -t 40 -o ./sublister.txt &> /dev/null
	#if [ -f ./sublister.txt ];then
	#	dm_nbr=$(wc -l ./sublister.txt |awk '{print $1F}')
	#	echo  -e "\e[36m sublister  \e[39m finds \e[36m$dm_nbr domains \e[39m"
 	#fi
}


function  subfinder(){
	echo "start subfinder...."
	subfinder -d $1 -silent -o ./subfinder.txt &> /dev/null
	#if [ -f ./subfinder.txt ];then
	#	dm_nbr=$(wc -l ./subfinder.txt|awk '{print $1F}') 
	#	echo -e  "\e[36m subfinder \e[39m find \e[36m$dm_nbr domains \e[39m"
	#fi

}


function findomain(){
	echo "start findomain....."
	findomain -t $1  >> ./d
	cat ./d |grep -v -iE  "(Target ==>|A total of)" |grep "$1" > ./finddomain.txt
	dm_nbr= $(wc -l ./finddomain.txt |awk '{print $1F}') 2>/dev/null
	echo -e "\e[36m finddomain \e[39m find  \e[36m$dm_nbr domains \e[39m"
	rm ./d
}

function collect(){
	echo " collect result..."
	cat ./* |sort -u  >>./domain 
	#echo "we find \e[35m$(wc -l $1/domain|awk '{print $1F}') domains \e[39m "
}

function collect_all(){
	cat $1|xargs -n1 -I{} cat "{}_domain"/domain >> ./d
	cat d |sort -u >> ../domains && rm ./d
}



function enum(){
	mkdir -p ./$1_domain
	path="./$1_domain"
	cd $path
	echo -e  "start enumurating \e[36m$1 \e[39m" 
	sublister $1
	amss $1 
	#findomain $1 
	#assetfinder $1
	subfinder $1 
	collect 
	cd ..
}



if [ $# -eq 1 ];then
	if [ -a $1 ];then
		#export -f  enum 
		#cat $1 |xargs -n1  -I{} bash -c 'enum "$@"' _ {}
		#collect_all $1	
		echo "this functionnality doesn't exist yet, please manualy !!! "
	else
		enum $1
	fi
else
	echo "plase porvide a domain or file_list of domain"
fi

