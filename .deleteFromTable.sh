#!/usr/bin/bash

deletingFromTable() {
        read -p "Enter table name: " tableName
        # check if the table found
        if [[ $tableName == "" || ! -f "$projDir/$DBName/$tableName" ]]; then
                echo -e "\n${yellow}Table not found!${reset}\n"
        else
                # check if there is data type inserted while creating table
                if [ $(cat "$projDir/$DBName/.$tableName" | wc -l) -gt 1 ]; then
                        # primary key name
                        primaryKey=$(sed -n '2p' "$projDir/$DBName/.$tableName" | cut -d',' -f1)

                        while true; do
                                read -p "Enter $primaryKey: " selectedPK
                                if [[ $selectedPK == "" ]]; then
                                        echo -e "\n${yellow}Invalid $primaryKey${reset}\n"
                                else
                                        # search for pk value
                                        PKsearch=$(cat "$projDir/$DBName/$tableName" | grep -nw "$selectedPK")
                                        # check if pk is found
                                        if [[ $(echo $PKsearch) != "" ]]; then
                                                echo -e "${yellow}Are you sure? y/n:${reset} "
                                                read
                                                if [[ $REPLY == 'y' || $REPLY == 'Y' ]]; then
                                                        # get line number of the primary key value
                                                        lineNumber=$(echo $PKsearch | cut -d':' -f1)
                                                        # delete record that contain searched value from table
                                                        sed -i "$lineNumber d" "$projDir/$DBName/$tableName"
                                                        # check if the deletion is done
                                                        if [ $? -eq 0 ]; then
                                                                echo -e "\n${green}Table deleted successfully${reset}\n"
                                                        else
                                                                echo -e "\n${red}Failed to delete record!${reset}\n"
                                                        fi
                                                fi
                                        else
                                                echo -e "${cyan}This $primaryKey Not found!${reset}\n"
                                        fi
                                        break
                                fi
                        done
                else
                        echo -e "\n${red}Table has no columns or data types inserted${reset}\n"
                fi
        fi

        tablesMenu $DBName

}
