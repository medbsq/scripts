#!/bin/bash

#tomnomnom tools
go get -u github.com/tomnomnom/assetfinder
cd ~/go/src/github.com/tomnomnom/assetfinder && go build && sudo cp assetfinder /usr/local/bin/
go get -u github.com/tomnomnom/httprobe
cd ~/go/src/github.com/tomnomnom/httprobe && go build && sudo cp httprob /usr/local/bin/
go get github.com/tomnomnom/waybackurls
cd ~/go/src/github.com/tomnomnom/waybackurls  && go build && sudo cp waybackurls  /usr/local/bin/
git clone https://github.com/tomnomnom/hacks.git ~/tools
cd ~/tools/hacks/qsreplace && go build && sudo cp qsreplace  /usr/local/bin/
cd ~/tools/hacks/unfurl    && go build && sudo cp unfurl     /usr/local/bin/



#projectdiscovery tools
 go get -u -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei
 cd ~/go/src/github.com/projectdiscovery/nuclei/v2/cmd/nuclei && go build && sudo cp nuclei /usr/local/bin/

 git clone https://github.com/projectdiscovery/httpx.git ~/tools ; cd ~/tools/httpx/cmd/httpx; go build;sudo cp  httpx /usr/local/bin/

 go get -u -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder
 cd ~/go/src/github.com/projectdiscovery/nuclei/v2/cmd/subfinder && go build && sudo cp subfinder /usr/local/bin/


#install ffuf and gau
go get -u -v github.com/lc/gau
cd ~/go/src/github.com/lc/gau && go build && sudo cp gau /usr/local/bin/
git clone https://github.com/ffuf/ffuf  ~/tools ; cd ~/tools/ffuf ; go get ; go build ;sudo cp ffuf /usr/local/bin/

