#!/bin/bash 
function help(){
echo "usage:"
echo -e "\\t -l     curl list of urls"
}

function crl(){
mkdir -p ./output
echo -ne "curl  $1"\\r
filename=$(echo "$1" | sha256sum |awk '{print $1}')
curl -sL  $1 -o ./output/$filename &>/dev/null
echo "$1     $filename" >> ./output/index
if gron ./output/$filename 2&> /dev/null;then
        gron ./output/$filename.txt > ./builds.txt
        rm ./output/$filename
fi

}


while getopts ":l:" OPTION
do
        case $OPTION in
                l)
                        export -f crl
                        cat "$OPTARG" | xargs -n 1 -P 10 -I {} bash -c 'crl  "$@"' _ {}
                        exit
                        ;;
                :)
                        help
                        exit 1
                        ;;
                \?)
                        help
                        exit 1
                        ;;

        esac
done



