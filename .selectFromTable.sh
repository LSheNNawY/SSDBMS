#!/usr/bin/zsh

selectingFromTable () {
    read -p "Enter table name: " tableName

    if [[ $tableName == "" || ! -f "$projDir/$DBName/$tableName" ]]; then
        echo -e "\n${yellow}Table not found!${reset}\n"
    else
       # check if there is no data
       if [[ `cat "$projDir/$DBName/$tableName" | wc -l` == 0 ]]; then
           echo -e "\n${yellow}No data found${reset}\n"
       else
           # get table columns name
           colNum=`head -n 1 "$projDir/$DBName/.$tableName" | cut -d',' -f2`
           colNames=`tail -n+2 "$projDir/$DBName/.$tableName" | cut -d',' -f1`

           counter=1
           for col in $colNames
           do
               echo "$counter ) select by $col"
               (( counter++ ))
           done

           while true; do
                read selectedCol
               if [[ $selectedCol == "" || $selectedCol -lt 1 || $selectedCol -gt $colNum ]]; then
                    echo -e "${yellow}Choose correct value${reset}"
               else
                    # selected col name
                    needle=`echo $colNames | cut -d' ' -f $selectedCol`
                    # returned values
                    values=`awk -F ',' -v arg="$selectedCol" '{ print $arg }' "$projDir/$DBName/$tableName"`

                    echo -e "${cyan}------ $needle -------"
                    for val in $values
                    do
                        echo $val
                        echo -e "-------------------"
                    done
                    echo -e "${reset}"

                   break
               fi
           done
       fi
    fi

    tablesMenu $DBName

}