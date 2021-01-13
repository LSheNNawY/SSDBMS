#!/usr/bin/bash

creatingTable() {

    read -p "Enter table name: " tableName
    if [[ $tableName == "" || ! $tableName =~ (^[a-zA-Z]+) ]]; then
        echo -e "\n${yellow}Enter a valid name!${reset}\n"

    elif [ -f "$projDir/$DBName/$tableName" ]; then
        echo -e "\n${yellow}Table '$tableName' already exists!${reset}\n"
    else

        touch "$projDir/$DBName/$tableName" "$projDir/$DBName/.$tableName"

        validColNum=0

        while [ $validColNum -eq 0 ]; do
            read -p "Enter number of columns: " colNumber
            # check number of columns
            if [[ $colNumber -eq 0 || $colNumber == "" ]]; then
                echo -e "\n${yellow}Must be valid number & gt 0${reset}\n"
            else
                # inserting columns
                for (( i = 1; i <= $colNumber; i++ )); do
                    validColName=0
                    while [ $validColName -eq 0 ]; do
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
                            validColName=1
                        fi
                    done
                    # column types
                    echo "1) int"
                    echo "2) string"

                    choice=0
                    # validate user input
                    while [ $choice -eq 0 ]; do
                        read
                        if [[ $REPLY == 1 ]]; then
                            colType="int"
                            echo "$colName,$colType" >>"$projDir/$DBName/.$tableName"
                            choice=1
                        elif [[ $REPLY == 2 ]]; then
                            colType="string"
                            echo "$colName,$colType" >>"$projDir/$DBName/.$tableName"
                            choice=1
                        else
                            echo -e "\n${yellow}Wrong choice${reset}\n"
                        fi
                    done

                    validColNum=1
                done
            fi
        done

    fi

    tablesMenu $DBName
}
