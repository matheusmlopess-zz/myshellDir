#!/bin/bash	

	local path=$(pwd);
	pushd ~/Desktop;

	local MSG="";
	local repository="";
	local response="";
	local token="";

		if [ ! -d ~/Desktop/gits ]; then
			mkdir gits && chmod 700 ~/Desktop/gits
			git clone https://github.com/matheusmlopess/dotFiles-linux.git 
		else
			command cd gits;
		fi


	if [[ -z "$@" ]]; then
	 	echo "u ain't got no commits, get outta here!";

	elif [[ $1 == "bashrc" ]]
	then 
		cd dotFiles-linux;
		local NUM=$[ ($RANDOM % 9999) +1 ];
		ls -la	&& printf "\n"
		mv .bashrc temp/.bashrc$NUM;
		command cp $HOME/.bashrc .
		
		git add .bashrc
		git add temp/
		github_ssh
			
			while [ -z "$MSG" ]; do
				read -p "commit msg: " -r MSG;
				#shit solution... f"$%"# it
				if [[ ! -n "$MSG" ]]; then
				 	echo "shit son! empty message! try again ..."
				fi
			done;
		
		printf "\n";
		git commit -m "${MSG}'";
		git push origin master

	elif [[ $1 == "new" ]]; then 
		pwd
		while [ -z "$repository" ]; do 
			
			read -p " New repo name: " -r repository
			if [[ ! -n "$repository" ]]; then
				echo "${mag}   shit son! empty message or typo, try again ...  ${end}"
			else 
				read -p "${grn} Are you sure you entered the name repo correctly:${end} ${yel} \"$repository\" ${end} [y/N] " -r response
				response=${response,,}    # tolower
				if [[ "$response" =~ ^(yes|y)$ ]]; then 
					echo "${grn}*****|_Ok moving on ...${end} "
				else
					repository="";				
				fi;
			fi;

		done;

                token=`openssl enc -aes-256-cbc -d -in ~/.ssh/token.dat`
		curl -u matheusmlopess:$token https://api.github.com/user/repos -d '{ "name": "'$repository'" }'
		echo "${blu}"
		echo "  *****************************************"
		echo "  **** repo created successfully!! ********"
		echo "  *****************************************"
		echo "${end}"
		echo "${yel} git cloning new repo ... ${end}"
		git clone https://github.com/matheusmlopess/$repository.git 
		
		printf "\n"
		github_ssh 0 ${repository}

	elif [[ $1 == "." ]]; then
		cd $path
		ls -la	&& printf "\n"
		
		git add .
		github_ssh
			
			while [ -z "$MSG" ]; do
				read -p "commit msg: " -r MSG;
				#shit solution... f"$%"# it
				if [[ ! -n "$MSG" ]]; then
				 	echo "shit son! empty message! try again ..."
				fi
			done;
		
		printf "\n";
		git commit -m "${MSG}";
		printf "\n";
		git push origin master
	else
		echo under construction
	
	fi
	
	popd;
