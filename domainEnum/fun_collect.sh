#!/bin/bash

echo " collect result..."
cat $1/* |sort -u  >>$1/domain
echo "we find \e[35m$(wc -l $1/domain|awk '{print $1F}') domains \e[39m "

