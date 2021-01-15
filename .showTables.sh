#!/usr/bin/zsh

listingTables () {

    if [[ `ls -l "$projDir/$DBName" | grep '^-' | wc -l` -gt 0 ]]; then

        tables=`ls -l "$projDir/$DBName" | grep '^-' | rev | cut -d' ' -f1 | rev`
        echo -e "${cyan}------ Tables -------"
        for table in $tables
        do
            echo $table
            echo -e "---------------------"
        done
        echo -e "${reset}"
  else
        echo -e "\n${cyan}--------------------"
        echo "No tables"
        echo -e "--------------------${reset}\n"
	fi

    tablesMenu $DBName

}