#!/bin/bash

		qualPacote=$1
	      #----------------------
			XPKG_CHK=0;   #flag ... 
			# dont require sudo permissions
			# 2>&1 :Passing stderr (2) over "-v" pipe along with stdout (1)
			# by redirecting the stderr stream (file descriptor #2)
			# to stdout (file descriptor #1)	
			command -v $qualPacote >/dev/null 2>&1 || { XPKG_CHK=1;}
			if [ $XPKG_CHK -eq 0 ];
			then
				apt-cache policy ${qualPacote};
			else	
				read -r -p "Pakage not found... Do you want to install it [Y/n]? " response
				case "$response" in
					[yY][eE][sS]|[yY]) 
						sudo apt-get install $qualPacote;
					;;
					*)
						echo okay fine ...;	
				        ;;
				esac
			fi
