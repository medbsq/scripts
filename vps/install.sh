#!/bin/bash
#install nuclei

go get -u -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei


git clone https://github.com/projectdiscovery/nuclei-templates.git   ~/nuclei-templates

git clone https://github.com/medbsq/ncl.git  ~/ncl

cd ~/ncl && chmod +x ncl.sh  && sudo  cp ncl.sh /usr/local/bin/ncl 

mkdir -p   ~/templates

ncl  -u 

mkdir -p ~/tools

#install assetfinder	
go get -u github.com/tomnomnom/assetfinder
go get github.com/tomnomnom/waybackurls
go get -u -v github.com/lc/gau
git clone https://github.com/tomnomnom/hacks.git
#install httpx
#GO111MODULE=auto go get -u -v github.com/projectdiscovery/httpx/cmd/httpx
git clone https://github.com/projectdiscovery/httpx.git; cd httpx/cmd/httpx; go build; mv httpx /usr/local/bin/

#install httprobe
go get -u github.com/tomnomnom/httprobe
#install ffuf
git clone https://github.com/ffuf/ffuf.git ; cd ffuf ; go get ; go build
#go get -u github.com/ffuf/ffuf

pip3 install dnsgen
