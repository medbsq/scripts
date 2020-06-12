#1/bin/bash


#set env
mkdir -p ./$1_domain
path="./$1_domain"

echo -e  "start enumurating \e[36m$1 \e[39m" 
~/scripts/domainEnum/fun_sublister.sh $1 $path
~/scripts/domainEnum/fun_amass.sh  $1 $path
~/scripts/domainEnum/fun_findomain.sh $1 $path
~/scripts/domainEnum/fun_assetfinder.sh $1 $path
~/scripts/domainEnum/fun_subfinder.sh $1 $path
~/scripts/domainEnum/fun_collect.sh $path

