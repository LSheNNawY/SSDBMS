#!/usr/bin/bash

clear
projDir="$PWD/SSDBMS"
mkdir -p $projDir
# including colors file
. .colors.sh

#including database scripts
. .createDB.sh
. .dropDB.sh
. .selectAllDBs.sh
. .selectDB.sh

# including tables scripts
. .tablesMenu.sh
. .showTables.sh
. .createTable.sh
. .dropTable.sh
. .selectFromTable.sh
. .insertIntoTable.sh

echo "#########################################################"
echo "#                                                       #"
echo "# ----------------- Welcome to SSDBMS ----------------- #"
echo "#                                                       #"
echo -e "#########################################################\n"

mainMenu() {
	echo "1) Select database"
	echo "2) Create database"
	echo "3) List databases"
	echo "4) Drop database"
	echo "5) Exit"

	read 
	case $REPLY in 
		1 ) selectingDB;;
		2 ) creatingDB;;
		3 ) selectingAll;;
		4 ) droppingDB;;
		5 ) exit;;
		* ) echo -e "${yellow}Wrong choice${reset}\n"; mainMenu ;;
	esac
}

mainMenu
