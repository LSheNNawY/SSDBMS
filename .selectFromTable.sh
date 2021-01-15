#!/usr/bin/zsh

selectingFromTable() {
    read -p "Enter table name: " tableName

    if [[ $tableName == "" || ! -f "$projDir/$DBName/$tableName" ]]; then
        echo -e "\n${yellow}Table not found!${reset}\n"
    else
        # check if there is no data
        if [[ $(cat "$projDir/$DBName/$tableName" | wc -l) == 0 ]]; then
            echo -e "\n${cyan}No data found${reset}\n"
        else
            # get table columns name
            colNum=$(head -n 1 "$projDir/$DBName/.$tableName" | cut -d',' -f2)
            colNames=$(tail -n+2 "$projDir/$DBName/.$tableName" | cut -d',' -f1)

            counter=1
            for col in $colNames; do
                echo "$counter ) select by $col"
                ((counter++))
            done

            while true; do
                read selectedCol
                if [[ $selectedCol == "" || $selectedCol -lt 1 || $selectedCol -gt $colNum ]]; then
                    echo -e "${yellow}Choose correct value${reset}"
                else
                    # selected col name
                    needle=$(echo $colNames | cut -d' ' -f $selectedCol)

                    while true; do
                        read -p "Enter $needle: " search
                        if [[ $search == "" ]]; then
                            echo -e "${yellow}Not valid!${reset}"
                        else
                            iter=1
                            echo -e "\n${cyan}----------------------"
                            for i in $colNames; do
                                echo -ne "$i";
                                if [ $iter -lt $colNum ]; then
                                    echo -ne "\t| \t"
                                fi
                                (( iter++ ))
                            done
                            echo -e "\n----------------------"

                            awk -F',' -v arg="$selectedCol" -v ser="$search" 'BEGIN{OFS="\t|\t"} { $1=$1; if ( $arg == ser  ) { print } }' "$projDir/$DBName/$tableName"

                            echo -e "----------------------${reset}\n"
                            break
                        fi
                    done
                    break
                fi
            done
        fi
    fi

    tablesMenu $DBName

}
