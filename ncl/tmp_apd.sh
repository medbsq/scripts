#!/bin/bash


cd /home/mohamed/mytools/domainEnumTools/nuclei-templates && git pull 
cd - 

for i in basic-detections cves security-misconfiguration files security-misconfiguration panels vulnerabilities tokens subdomain-takeover workflows  ;do
	cp /home/mohamed/mytools/domainEnumTools/nuclei-templates/$i/* /home/mohamed/git_workspace/scripts/ncl/tmp/
done

