#!/bin/bash


mkdir -p $1
cd $1
subdomainEnum $1


cat domains |httprobe -prefer-https |tee -a hosts


cat hosts |nuclei -t /home/mohamed/mytools/domainEnumTools/nuclei-templates/subdomain-takeover/detect-all-takeovers.yaml -o takeover

/home/mohamed/git_workspace/scripts/ncl/test.sh /home/mohamed/mytools/domainEnumTools/nuclei-templates  hosts

webscreenshot.sh -i hosts -o ./shots

cd ..
