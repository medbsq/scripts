#!/bin/bash 

cat $1|xargs -n1 -I{} cat {}/domain >> ./d
cat d |sort -u > ./domains && rm ./d
