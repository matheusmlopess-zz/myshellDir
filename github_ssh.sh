#!/bin/bash

  yel=$'\e[1;33m'
  cyn=$'\e[1;36m'
  end=$'\e[0m'

  
	echo ${yel}
	SSH_CHK=$(eval "git remote -v");
	echo $(pwd)
	echo ${end}
	printf "\n"

		if [[ $SSH_CHK == *"git@github.com:matheusmlopess"* ]]; then
	  		echo "ssh checked and all good! ...:"
			git remote -v;
		elif [[ $SSH_CHK == *"https://github.com/matheusmlopess"* ]];then
			
			repository=${PWD##*/}
 			read -p "is ('$repository' ) the right github repository [Y/n]" -r YesNo; 
				case "$YesNo" in
					[yY][eE][sS]|[yY]) 
					
					git remote set-url origin git@github.com:matheusmlopess/$repository.git
			                echo "All good now... ssh set and running"
					git remote -v;
					;;
					*)
				       	read -p " Respository name (clone path) :" -r respositoryname 
					git remote set-url origin git@github.com:matheusmlopess/$repositoryname.git
					echo "All good now... ssh set and running"
					git remote -v 
					;;
				esac
		elif [[ $1 == "0" ]]; then
			cd $2
			echo Applying ssh new repository permissions ... son!
			git remote set-url origin git@github.com:matheusmlopess/$2.git

			echo ${cyn} ssh permission successfully done: 
			git remote -v 
			echo ${end}

		else	
			git remote -v;
		fi


