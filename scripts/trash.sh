#!/bin/bash

echo "Starting trash 🗑️ cleaning..." ;

read -p "Cleaning .local/share/Trash? [y/n]" answer ;
if [ "$answer" == "y" ]; then
    rm -rf ~/.local/share/Trash/* ;
    echo "Finished cleaning .local/share/Trash ✅" ;
else
    echo "Not cleaning .local/share/Trash" ;
fi

echo "Finished trash 🗑️ cleaning." ;
