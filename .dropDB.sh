#! /usr/bin/bash

droppingDB() {

        read -p "Enter database name to drop: " DBName
        if [[ $DBName == "" ]]; then
                echo -e "\n${yellow}Empty name entered!${reset}\n"
                mainMenu

        elif [ -d "$projDir/$DBName" ]; then
                # confirmation
                echo -e "${yellow}Are you sure? y/n: ${reset}"
                read confirm

                if [[ $confirm == "Y" || $confirm == "y" ]]; then
                        rm -fr "$projDir/$DBName"
                        echo -e "\n${green}Database $DBName deleted successfully ${reset}\n"
                else
                        echo -e "\n${yellow}Database not deleted${reset}\n"
                fi
        else
                echo -e "\n${yellow}Database $DBName not found!${reset}\n"
        fi

        mainMenu
}
