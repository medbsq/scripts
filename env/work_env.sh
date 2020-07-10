#!/bin/bash 

read -sp 'sudo password: ' password

function sd(){
	echo "$password" |sudo -S $1   || echo -e " $1\e[33m failled \e[0m"
}

sd "apt update  -y" 
sd "apt upgrade -y" 

#dependencies 
#if [ $(python3 -V | cut -d"." -f2) -lt 6 ];then 
#	sd "apt install python3 -y 
#elif [ go]
sd "apt install python3 -y " 
sd "apt install golang -y "  
sd "apt install awk -y "     
sd "apt install git -y"      
sd "apt install pip3 -y"     
sd "apt install snapd"       


################################################### tools ##################################################
mkdir  -p  ~/mytools  && cd ~/mytools 
#sublister
git clone  https://github.com/aboul3la/Sublist3r.git
pip3 install -r ./Sublist3r/requirements.txt


#amass
sd "snap install amass " 



#dirsearch
git clone https://github.com/maurosoria/dirsearch.git


#web screenshod
sd "pip3 install webscreenshot" 



#tomnonom tools
go get -u github.com/tomnomnom/meg
go get -u github.com/tomnomnom/assetfinder
go get -u github.com/tomnomnom/httprobe
go get -u github.com/tomnomnom/gron

################################################### scripts ##################################################

git clone https://github.com/medbsq/scripts
git clone https://github.com/medbsq/gf
git clone https://github.com/maurosoria/dirsearch




############################################ bashrc file ########################################
#github token
#tavis Token

















