#!/bin/bash

	if [ -z  "$@"  ]; then

            (zcat $(ls -tr /var/log/apt/history.log*.gz); cat /var/log/apt/history.log) 2>/dev/null | 
	     egrep '^(Start-Date:|Commandline:)' |
	     grep -v aptdaemon | 
	     egrep '^Commandline:' >> ~/Desktop/apt-installed-packge_aux.txt
	     
	     while IFS='' read -r line || [[ -n "$line" ]]; do
		     
		     if [[ $line == *"apt-get install"* ]]; then
		     	echo ${line//Commandline:/sudo} ;
	     	     fi

        done <  ~/Desktop/apt-installed-packge_aux.txt > ~/Desktop/gits/dotFiles-linux/apt-installed-packge.txt ; rm ~/Desktop/apt-installed-packge_aux.txt
		
        elif [ $1 -eq "bydate" ]; then

	      (zcat $(ls -tr /var/log/apt/history.log*.gz); cat /var/log/apt/history.log) 2>/dev/null |
	       egrep '^(Start-Date:|Commandline:)' |
	       grep -v aptdaemon |
	       egrep -B1 '^Commandline:' >> ~/Desktop/gits/dotFiles-linux/apt-installed-packge-byDate.txt
	else
		echo try: \"whatDidIdo bydate\" mate!
	fi

