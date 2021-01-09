#! /usr/bin/bash

# creating new database

creatingDB() {

	read -p "Enter database name: " DBName
	if [[ $DBName == "" ]] 
	then
		echo -e "\n${yellow}Database name can not be empty!${reset}\n"

	elif [ ! -d "$projDir/$DBName" ];
	then
		mkdir -p "$projDir/$DBName" 
		echo -e "\n${green}Database Created successfully${reset}\n"
	else
		echo -e "\n${yellow}Database Already exists!${reset}\n"
	fi

	mainMenu
}
