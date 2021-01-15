#!/usr/bin/bash

tablesMenu () {

	if [ $# -gt 0 ]
	then
		echo "1) Create table"
		echo "2) List tables"
		echo "3) Drop table"
		echo "4) Insert into table"
		echo "5) Select from table"
		echo "6) Delete from table"
		echo "7) Back to main menu"

		read 
		case $REPLY in
			1 ) creatingTable;;
			2 ) listingTables;;
			3 ) droppingTable;;
			4 ) insertingIntoTable;;
			5 ) selectingFromTable;;
			6 ) deletingFromTable;;
			7 ) mainMenu;;
			* ) echo -e "${yellow}Wrong choice${reset}\n";tablesMenu $DBName;;
		esac
	else
		echo "something went wrong!"
		mainMenu
	fi
	
	tablesMenu $DBName
}



