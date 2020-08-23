#!/bin/bash
 
function help(){
echo "usage:"
echo "this script take list of template and test it on list of url  "
echo -e "\t -u \t update  templates"
echo -e "\t -s \t show templates "
echo -e "\t -l \t provide list of url (require) "
echo -e "\t -t \t use specific template tmp1,tmp2,tmp3,..."
echo -e "\t -g \t ignore previous test"
echo -e "\t -c \t occurance number (10 default)"
echo -e "\t -a \t run nuclei on evry found program"
echo -e "\t -T \t run nuclei on evry found program with specific template tmp1,tmp2,tmp3,..."
}

function template_base_logs(){
	if [ -f ./nuclei_$1/.logs ];then
		a=""
		for i in $2 ;do
			if ! grep "$i" ./nuclei_$1/.logs &> /dev/null  ;then
				a="$a $i"
				
			fi
		done
	else
		a="$2"
	fi
	echo "$a"
}


function template_specific(){
	echo $(echo $1 |sed 's/,/ /g')
        }

function template_all(){
        ls /home/mohamed/git_workspace/scripts/ncl/tmp  |xargs
    	}

function a(){
echo $1
echo $2
echo $3
}

function ncl_f(){
	mkdir -p  nuclei_$1 
	for i in $3 ;do 
		template="/home/mohamed/git_workspace/scripts/ncl/tmp/$i"
		output="./nuclei_$1/$i.txt"
		if [ -f $template ];then
			echo  -ne "\e[33mtemplate :  $i"\\r
			nuclei -t  $template    -silent -l $1 -o $output  -c $2
			echo "$i		[$(date +%D__%X)]" >> ./nuclei_$1/.logs
		fi
	done
	echo "------------------------------------------------------------------------------------------------------------" >> ./nuclei_$1/.logs
	find ./$output -empty -delete &> /dev/null
}

function ncl_special(){
        mkdir -p  nuclei_$1
        for i in $3 ;do
                template="/home/mohamed/git_workspace/scripts/ncl/tmp/$i"
                output="./nuclei_$1/$i.txt"
                if [ -f $template ];then
                        echo  -ne "\e[33mtemplate :  $i"\\r
                        nuclei -t  $template  -l $1 -o $output  $4
                        echo "$i                [$(date +%D__%X)]" >> ./nuclei_$1/.logs
                fi
        done
        echo "------------------------------------------------------------------------------------------------------------" >> ./nuclei_$1/.logs
        find ./$output -empty -delete &> /dev/null
}


function ncl_all(){
	for i in $(find ./ -type d -name nuclei_*);do
		export -f ncl_f
		export -f template_base_logs

	         path=$(echo $i|awk -F'nuclei_' '{print $1F}')
       		 urls=$(echo $i|awk -F'nuclei_' '{print $NF}')
		 t="$(ls /home/mohamed/git_workspace/scripts/ncl/tmp)"
	         template=$(template_base_logs $urls "$t")
       		 ncl_f  $urls 70  "$template"
       		 cd - &> /dev/null
		 
    	done	

}

function ncl_all_with_tmps(){
        for i in $(find ./ -type d -name nuclei_*);do
                export -f ncl_f
                export -f template_base_logs

                 path=$(echo $i|awk -F'nuclei_' '{print $1F}')
                 urls=$(echo $i|awk -F'nuclei_' '{print $NF}')
                t="$(ls /home/mohamed/git_workspace/scripts/ncl/tmp)"
                template="$(template_specific $1)"
echo $template
		echo -e "\e[32m$path\e[0m"
                 cd $path
                 ncl_f  $urls 30  "$template"
                 cd - &> /dev/null
        done

}

function update_tmp(){
	cd /home/mohamed/mytools/domainEnumTools/nuclei-templates && git pull 
	cd - 

	for i in basic-detections cves security-misconfiguration files security-misconfiguration panels vulnerabilities tokens subdomain-takeover workflows ;do
		cp /home/mohamed/mytools/domainEnumTools/nuclei-templates/$i/* /home/mohamed/git_workspace/scripts/ncl/tmp/
	done
	for i in  typescript  swagger-panel.yaml basic-cors-flash.yaml ;do
		rm /home/mohamed/git_workspace/scripts/ncl/tmp/$i
	done 

}

function list_tmp(){
	ls  /home/mohamed/git_workspace/scripts/ncl/tmp 

}


#variables
template=""
url=""
occurence=10
params=""
ignore=0


#option handler
while getopts ":l:T:t:c:gasu" OPTION
do
        case $OPTION in
                s)
			list_tmp
			exit
                        ;;
                p)
                        params="$OPTARG"
                        exit
                        ;;
                T)
                        ncl_all_with_tmps "$OPTARG"
                        exit
                        ;;

	       	a)
                        ncl_all
                        exit
                        ;;

		t)
                        template="$OPTARG"
                        ;;
		c)
                        occurence="$OPTARG"
                        ;;
		g)
                        ignore=1
                        ;;

                l)
                        url="$OPTARG"
                        ;;
		u)
                        #update_tmp
			update_tmp
			exit
                        ;;
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


#get template
if [[ $template == "" ]] && [[ $url == "" ]];then
	help
	exit
elif [[ $template == "" ]] && [[ $url != "" ]];then
	template="$(template_all)"
elif [[ $template != "" ]] && [[ $url == "" ]];then
	help
        exit
else
	template="$(template_specific $template)"
		
fi

#logs filtration
if [ $ignore -eq 0 ];then
	template=$(template_base_logs $url "$template")
#template_base_logs $url "$template"
fi

 
ncl_f  $url $occurence "$template" "$params"

