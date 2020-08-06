#!/bin/bash 

read -sp 'sudo password: ' password

function sd(){
	echo "$password" |sudo -S $1   || echo -e " $1\e[33m failled \e[0m"
}

sd "apt update  -y" 
sd "apt upgrade -y" 

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

git clone https://github.com/medbsq/scripts.git
git clone https://github.com/medbsq/gf.git
git clone https://github.com/maurosoria/dirsearch.git




############################################ bashrc file ########################################
#github token
#tavis Token
alias c='cd ..' >> ~/.bachrc
alias bb='cd ~/bug_bounty' >> ~/.bachrc
alias my='cd ~/mytools' >> ~/.bachrc
alias sc='cd ~/scripts' >> ~/.bachrc
alias la='ls -A' >> ~/.bachrc
export DIR_EXT="conf,config,back,backup,swp,old,db,sql,asp,aspx,asp~,asp~,py,py,rb,rb~,php,php~,bak,bkp,cache,cgi,csv,html,inc,jar,js,json,jsp,jsp~,lock,log,rar,sql.gz,sql.zip,sql.tar.zip,sql~,swp~,tar,tar.bz2,tar.gz,txt,wald,zip,.log,.xml,.json,.js" >> ~/.bachrc
















