#!/usr/bin/bash

clear
projDir="$HOME/SSDBMS"
mkdir -p $projDir
# including colors file
. .colors.sh

#including database scripts
. .createDB.sh
. .dropDB.sh


echo "#########################################################"
echo "#                                                       #"
echo "# ----------------- Welcome to SSDBMS ----------------- #"
echo "#                                                       #"
echo -e "#########################################################\n"

mainMenu() {
	echo "1) Select database"
	echo "2) Create database"
	echo "3) Rename database"
	echo "4) Drop database"
	echo "5) Exit"

	read 
	case $REPLY in 
		1 ) echo "Select database logic";;
		2 ) creatingDB;;
		3 ) echo "Rename database logic";;
		4 ) droppingDB;;
		5 ) exit;;
		* ) echo -e "Wrong choice\n"; mainMenu ;;
	esac
}

mainMenu
