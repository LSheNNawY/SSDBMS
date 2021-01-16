#! /usr/bin/bash

# creating new database

creatingDB() {

        read -p "Enter database name: " DBName
        if [[ $DBName == "" || ! $DBName =~ (^[a-zA-Z]+) ]]; then
                echo -e "\n${yellow}Database name not valid!${reset}\n"

        elif [ ! -d "$projDir/$DBName" ]; then
                mkdir -p "$projDir/$DBName"
                echo -e "\n${green}Database Created successfully${reset}\n"
        else
                echo -e "\n${yellow}Database '$DBName' Already exists!${reset}\n"
        fi

        mainMenu
}
