#!/bin/bash

rnd=$'\e[38;05;'
  
	# init function: creat cmd folder the first time cmd() is called.
	pushd ~/Desktop;
	if [ ! -d ~/Desktop/gits ]; then 
		mkdir gits
		echo "dotFiles directory not found... in $(pwd)"
		git clone https://github.com/matheusmlopess/dotFiles-linux.git 
		cd dotFiles-linux
		echo " " > commands.txt
		github_ssh
		return 1;
	else
		cd gits/dotFiles-linux
	fi

   command ls -a;
   NUMBER=$[ ( $RANDOM % 255 )  + 1 ]
   VAR=$@;

	if [[ -z $VAR ]]; then 
		printf "\n"
		echo ${yel} 
		xclip -o;
        	echo  ${end}
		printf "\n"

     CONTEUDO=$(xclip -o);
        echo ${rnd}${NUMBER}m $CONTEUDO  >> commands.txt
	else
        echo ${rnd}${NUMBER}m $@ ${end} >> commands.txt
fi
popd;

