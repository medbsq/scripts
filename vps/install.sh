#!/bin/bash
#install nuclei

go get -u -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei


git clone https://github.com/projectdiscovery/nuclei-templates.git   ~/nuclei-templates

git clone https://github.com/medbsq/ncl.git  ~/ncl

cd ~/ncl && chmod +x ncl.sh  && sudo  cp ncl.sh /usr/local/bin/ncl 

mkdir -p   ~/templates

ncl  -u 

#install assetfinder	
go get -u github.com/tomnomnom/assetfinder

#install httpx
#GO111MODULE=auto go get -u -v github.com/projectdiscovery/httpx/cmd/httpx
git clone https://github.com/projectdiscovery/httpx.git; cd httpx/cmd/httpx; go build; mv httpx /usr/local/bin/


#install ffuf
git clone https://github.com/ffuf/ffuf.git ; cd ffuf ; go get ; go build
#go get -u github.com/ffuf/ffuf


