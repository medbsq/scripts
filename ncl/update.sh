#!/bin/bash 



function update_tmp(){
	original_location="~/tools/nuclei-templates"
	work_location="~/templates"

#update template from github 
       # cd $original_location && git pull
       # cd - &> /dev/null

#transfer tmp process

        for i in  cves security-misconfiguration files security-misconfiguration panels vulnerabilities tokens subdomain-takeover workflows ;do
                for j in $(ls $original_location/$i);do
			#old tmp
                       if [  -f $work_location/$j ];then
                           #echo "$work_location/$j"
			     a="$(cat   $work_location/$j |wc -c )"
                             b="$(cat  $original_location/$i/$j|wc -c  )"
                                if [ $a -ne $b ];then
                                       echo "$j" >> update_tmp.txt
                                fi
                        fi

                done
              #  rm  -rf update_tmp.txt &> /dev/null

              #cp ~/tools/nuclei-templates/$i/* /home/mohamed/git_workspace/scripts/ncl/tmp
	cp ~/tools/nuclei-templates/$i/* ~/templates
        done

#custom templates
        for j in $(ls ~/ncl/costum_tmp);do
                        #old tmp
                        if [  -f ~/templates/$j ];then
                           #echo /$j"
                             a="$(cat   ~/templates/$j |wc -c )"
                             b="$(cat  ~/ncl/costum_tmp/$j |wc -c  )"
                                if [ $a -ne $b ];then
                                        echo "$j" >> update_tmp.txt
                                fi
                        fi

        done

        cp ~/ncl/costum_tmp  ~/templates

        for log in $(find $1 -iname "nuclei_*" -type f) ;do
                        cat $log |grep  -v -f update_tmp.txt |sort -o $log
        done
        for i in  typescript  swagger-panel.yaml basic-cors-flash.yaml ;do
                rm ~/templates/$i &> /dev/null
        done

}



update_tmp 
