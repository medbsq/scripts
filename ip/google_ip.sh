#!/bin/bash



for i in $(cat urls.txt) ;do
	curl -s  $i$1  -o /dev/null  -w "%{url_effective}	 %{http_code}    	%{redirect_url}\n"
done
