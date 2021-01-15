#!/usr/bin/bash

insertingIntoTable () {
    read -p "Enter table name: " tableName

    if [[ $tableName == "" || ! -f "$projDir/$DBName/$tableName" ]]; then
        echo -e "\n${yellow}Table not found!${reset}\n"
    else
        # check if there is data type inserted while creating table
        if [ `cat "$projDir/$DBName/.$tableName" | wc -l` -gt 1 ]; then

            # declare arrays
            declare -a colNames
            declare -a colDataType

            # number of columns
            colNum=$(head -n 1 "$projDir/$DBName/.$tableName" | cut -d',' -f2)
            # columns names
            names=$(tail -n+2 "$projDir/$DBName/.$tableName" | cut -d',' -f1)
            # data types
            dataType=$(tail -n+2 "$projDir/$DBName/.$tableName" | cut -d',' -f2)
            # assign arrays
            colNames=($names)
            colDataType=($dataType)

            rowData=""
            for (( i=0; i < $colNum; i++ )); do
                while true; do
                    read -p "Enter ${colNames[i]}: " colVal
                    # validate col data type if it is int
                    if [[ ${colDataType[i]} == "int" ]]; then
                        if [[ $colVal == "" || ! $colVal =~ (^[0-9]+)$ ]]; then
                            echo -e "${yellow}Invalid ${colNames[i]} ${reset}"
                        else
                            # save data
                            if [ $i -eq 0 ]; then
                                # check for primary key
                                if [[ `cat "$projDir/$DBName/$tableName" | cut -d',' -f1 | grep "$colVal"` -gt 0 ]]
                                then
                                    echo -e "\n${yellow}this ${colNames[i]} (PK) exists.${reset}\n"
                                    break 2
                                fi
                                rowData+="$colVal"
                            else
                                rowData+=",$colVal"
                            fi
                            break
                        fi
                    # validate col if it is string
                    elif [[ ${colDataType[i]} == "string" ]]; then
                        if [[ $colVal == "" || ! $colVal =~ (^[a-zA-Z]+[a-zA-Z0-9_ ]+) ]]; then
                            echo -e "${yellow}Invalid ${colNames[i]} ${reset}"
                        else
                            # save data to a variable
                            if [ $i -eq 0 ]; then
                                rowData+="$colVal"
                            else
                                rowData+=",$colVal"
                            fi
                            break
                        fi
                    fi
                done
            done

            # saving data to table
            if [[ ! $rowData == "" ]]; then
                echo $rowData >> "$projDir/$DBName/$tableName";
               # check if creation done
                if [ $? -eq 0 ]; then
                    echo -e "\n${green}Data inserted successfully${reset}\n"
                else
                    echo -e "\n${red}Error Inserting data table!${reset}"
                fi
            fi

        else
            echo -e "\n${red}Table has no columns or data types inserted${reset}\n"
        fi
    fi

    tablesMenu $DBName
}