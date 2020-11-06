#!/bin/bash
function host(){
	ffuf  -w $1 -u FUZZ -H 'Host: $2' -t 300 -o  host.result
}
host  $1 $2
