#!/bin/bash

for i in $(cat $1);do
        echo $i | tee -a res
	mkdir -p ff_out
	ffuf  -w ./wl -u $i/FUZZ    -t 40 -o a -mc all |tee -a ff_out/$(echo $i|cut -d "/" -f 3)
done
