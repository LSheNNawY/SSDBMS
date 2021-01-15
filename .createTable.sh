#!/usr/bin/bash

creatingTable() {

    read -p "Enter table name: " tableName
    if [[ $tableName == "" || ! $tableName =~ (^[a-zA-Z]+) ]]; then
        echo -e "\n${yellow}Enter a valid name!${reset}\n"

    elif [ -f "$projDir/$DBName/$tableName" ]; then
        echo -e "\n${yellow}Table '$tableName' already exists!${reset}\n"
    else
        while true; do
            read -p "Enter number of columns: " colNumber
            # check number of columns
            if [[ $colNumber -eq 0 || $colNumber == "" ]]; then
                echo -e "\n${yellow}Must be valid number & gt 0${reset}\n"
            else
                # creating table files [data file and meta file]
                touch "$projDir/$DBName/$tableName" "$projDir/$DBName/.$tableName"
                echo "$tableName,$colNumber" >> "$projDir/$DBName/.$tableName"
                # inserting columns
                for (( i = 1; i <= $colNumber; i++ )); do
                    # insert columns' names
                    while true; do
                        if [[ $i == 1 ]];
                        then
                            read -p "column #$i [primary] name: " colName
                        else
                            read -p "column #$i name: " colName
                        fi
                        # validate column name
                        if [[ $colName == "" || ! $colName =~ (^[a-zA-Z]+) ]]; then
                            echo -e "${yellow}Invalid name${reset}"
                        else
#                            validColName=1
                            break
                        fi
                    done
                    # column types
                    echo "1) int"
                    echo "2) string"

                    # validate user input data types
                    while true; do
                        read
                        if [[ $REPLY == 1 ]]; then
                            colType="int"
                            echo "$colName,$colType" >>"$projDir/$DBName/.$tableName"
                            break
                        elif [[ $REPLY == 2 ]]; then
                            colType="string"
                            echo "$colName,$colType" >>"$projDir/$DBName/.$tableName"
                            break
                        else
                            echo -e "${yellow}Wrong choice${reset}"
                        fi
                    done

                done
               break
            fi
        done

        # check if creation done
        if [ $? -eq 0 ]; then
            echo -e "\n${green}Table created successfully${reset}\n"
        else
            echo -e "\n${red}Error creating table!${reset}"
        fi

    fi

    tablesMenu $DBName
}
