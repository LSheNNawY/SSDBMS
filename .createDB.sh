#! /usr/bin/bash

# creating new database

creatingDB() {

	read -p "Enter database name: " DBName
	
	if [ ! -d "$projDir/$DBName" ]
	then
		mkdir -p "$projDir/$DBName" 
		echo -e "\n${green}Database Created successfully${reset}\n"
		mainMenu
	else
		echo -e "\n${red}Database Already exists${reset}\n"
		mainMenu
	fi
}
