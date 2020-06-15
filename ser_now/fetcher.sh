#!/bin/bash


cd output/ && find ./  -type f |grep -HnroE "$1"|awk  -F":" '{print $1F}'|xargs -n1  -P10 -I{} grep {} index |sort -u


