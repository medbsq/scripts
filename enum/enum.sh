#!/bin/bash


mkdir -p $1
cd $1
subdomainEnum $1


cat domains |httprobe -prefer-https >>hosts


cat hosts |nuclei -t /home/mohamed/mytools/domainEnumTools/nuclei-templates/subdomain-takeover/detect-all-takeovers.yaml -o takeover


webscreenshot.sh -i hosts -o ./shots

cd ..
