#!/usr/bin/bash

droppingTable() {
        read -p "Enter table name: " tableName

        if [[ $tableName == "" || ! -f "$projDir/$DBName/$tableName" ]]; then
                echo -e "\n${yellow}Table not found!${reset}\n"
        else
                echo -e "${yellow}Are you sure? y/n:${reset} "
                read
                if [[ $REPLY == 'y' || $REPLY == 'Y' ]]; then
                        rm "$projDir/$DBName/$tableName" "$projDir/$DBName/.$tableName"
                        echo -e "\n${green}Table deleted successfully${reset}\n"
                fi
        fi

        tablesMenu $DBName
}
