#!/bin/bash
function get_builds_id(){
	echo -e "\e[32mfetching /$1 builds  \e[0m"

#get builds 
curl https://api.travis-ci.org/repos/$1/builds  -H "Accept: application/vnd.travis-ci.2.1+json" -H "Content-Type: application/json" -H "Authorization: token $TAVIS_TOKEN" -o  ./builds.json &> /dev/null
if [ -f ./builds.json ];then
	#get builds id
        gron ./builds.json |grep -iE "\.id =" |sed  's/\;//g' |awk -F'id =' '{printf $NF}' |xargs -n1 > ./builds_id.txt 
else
	 echo " error while fetching builds"
        exit 
fi 
if gron ./builds.json 2&> /dev/null;then
	gron ./builds.json > ./builds.txt
	rm ./builds.json
fi
}


function fetch_logs(){
	echo -ne "\e[32m fetch $1 \e[0m"\\r
	curl https://api.travis-ci.org/v3/job/$1/log.txt   -H "Accept: application/vnd.travis-ci.2.1+json" -H "Content-Type: application/json" -H "Authorization: token $TAVIS_TOKEN" -o ./$1.txt &> /dev/null
}


if [ -z $TAVIS_TOKEN ];then
	echo "you should set the TAVIS_TOKEN variable"
	exit 
elif [ $# -eq 0 ];then
	echo "the repo name and the owner are missing"
        exit 
else

	repo=$(echo "$1" |cut -d "/" -f2)
	owner=$(echo "$1" |cut -d "/" -f1)
	path="$repo-tvs-builds"
	mkdir -p $path
	export -f fetch_logs
	cd $path
	get_builds_id $1
        cat ./builds_id.txt |xargs -n 1 -P 10 -I {} bash -c 'fetch_logs "$@"' _ {}
	cd ..
fi
