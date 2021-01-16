#! /usr/bin/bash

selectingAll() {
        if [ $(ls -A $projDir | wc -w) -gt 0 ]; then
                databases=$(ls -l $projDir | grep '^d' | rev | cut -d' ' -f1 | rev)

                echo -e "${cyan}----- Databases -----"
                for db in $databases; do
                        echo $db
                        echo -e "---------------------"
                done
                echo -e "${reset}"
        else
                echo "--------------------"
                echo "No databases"
                echo "--------------------"
        fi

        mainMenu

}
