#! /usr/bin/bash

droppingDB () {

	read -p "Enter database name to drop: " DBName
	
	if [ -d "$projDir/$DBName" ]
	then 
		rm -fr "$projDir/$DBName"
		echo -e "\n${green}Database $DBName deleted successfully ${reset}\n"
		mainMenu
	else
		echo -e "\n${yellow}Database $DBName not found!${reset}\n"
		mainMenu
	fi
}
