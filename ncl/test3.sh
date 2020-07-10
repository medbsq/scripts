#!/bin/bash
 
function help(){
echo "usage:"
echo "this script take list of template and test it on list of url  "
echo -e "\t u \t update  templates"
echo -e "\t s \t show templates "
echo -e "\t l \t provide list of url (require) "
echo -e "\t t \t use specific template tmp1,tmp2,tmp3,..."
}

function ncl(){
	mkdir -p  nuclei_$1 
	for i in $(ls /home/mohamed/git_workspace/scripts/ncl/tmp) ;do 
		template="/home/mohamed/git_workspace/scripts/ncl/tmp/$i"
		output="./nuclei_$1/$i.txt"
		echo  -ne "\e[33mtemplate :  $i"\\r
		nuclei -t  $template   -silent  -l $1 -o $output  -c $2
	done
	find ./$output -empty -delete
}


function update_tmp(){
	cd /home/mohamed/mytools/domainEnumTools/nuclei-templates && git pull 
	cd - 

	for i in basic-detections cves security-misconfiguration files security-misconfiguration panels vulnerabilities tokens subdomain-takeover workflows ;do
		cp /home/mohamed/mytools/domainEnumTools/nuclei-templates/$i/* /home/mohamed/git_workspace/scripts/ncl/tmp/
	done

}

function list_tmp(){
	ls  /home/mohamed/git_workspace/scripts/ncl/tmp 

}

function specific_tmp(){
	templt=$(echo $2 |sed 's/,/ /g' )
	mkdir -p ./nuclei_$1
	for i in $templt ;do
                template="/home/mohamed/git_workspace/scripts/ncl/tmp/$i"
                output="./nuclei_$1/$i.txt"
                echo  -ne "\e[33mtemplate :  $i"\\r
                nuclei -t  $template   -silent  -l $1 -o $output -c $3
        done
	find ./$output -empty -delete

}

#ncl $1

tm=""
url=""
occurence=10
while getopts ":l:t:su" OPTION
do
        case $OPTION in
                s)
			list_tmp
			exit
                        ;;
                t)
                        tm="$OPTARG"
                        ;;
		c)
                        occurence="$OPTARG"
                        ;;
                l)
                        url="$OPTARG"
                        ;;
		u)
                        #update_tmp
			echo "update"
			exit
                        list_tmp;;
                :)
                        help
                        exit 1
                        ;;
                \?)
                        help
                        exit 1
                        ;;

        esac
done

if [[ $tm == "" ]] && [[ $url == "" ]];then
	help
	exit
elif [[ $tm == "" ]] && [[ $url != "" ]];then
	ncl $url  $occurence
	exit
elif [[ $tm != "" ]] && [[ $url == "" ]];then
	help
        exit
else
	specific_tmp $url $tm $occurence

	exit
fi





