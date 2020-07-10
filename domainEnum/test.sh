#!/bin/bash 

enum  $1
cat ./$1_domain/domain >./domains

cat domaims |httprobe -prefer-https |tee -a ./hosts


webscreenshot.sh -i  ./hosts -o shots 

../ncl/test.sh /home/mohamed/mytools/domainEnumTools/nuclei-templates  hosts


