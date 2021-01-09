#! /usr/bin/bash

selectingDB () {
	read -p "Enter database name: " DBName
	if [[ ! -d "$projDir/$DBName" || $DBName == "" ]]
	then
		echo -e "${yellow}Database not found${reset}\n"
		mainMenu
	else
		echo -e "${blue}Database $DBName selected${reset}\n"
		tablesMenu $DBName
	fi
}
