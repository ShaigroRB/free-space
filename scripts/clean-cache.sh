#!/bin/bash

function clean_packages_cache_for_pacman() {
    echo "Start cache cleaning for pacman..." ;

    if [ ! -x "$(command -v paccache)" ]; then
        echo "⚠️ paccache might not be installed. ⚠️ Impossible to clean the cache without it." ;
        #exit 2 ;
    fi

    echo "" ;
    echo "pacman cache cleaning can be of three types:" ;
    echo "- safest way, less space removed (removes all cached packages except for the last three versions of each package) [safe]" ;
    echo "- unadvised way, more space removed (removes all cached packages for uninstalled packages) [unadv]" ;
    echo "- ⚠️ even more unadvised way, even more space removed (removes all cached packages) [crazy] ⚠️" ;
    read -p "[safe/unadv/crazy]: " answer ;

    function finished() {
        type=$1 ;
        echo "Finished $type cache cleaning for pacman. ✅" ;
    }

    function safest() {
        paccache -r ;
        finished "safe" ;
    }

    function unadvised() {
        pacman -Sc ;
        finished "unadvised" ;
    }

    function crazy() {
        read -p "Are you sure about that? [y/n]" answer ;
        if [ "$answer" == "y" ]; then
            pacman -Scc ;
        fi
        finished "crazy" ;
    }

    case $answer in
        "safe") safest ;;
        "unadv") unadvised ;;
        "crazy") crazy ;;
        *) echo "No cache cleaning option typed." ;
    esac

    echo "Finished cache cleaning for pacman. ✅"
}

function help() {
    echo "" ;
    echo "Cache cleaning for different tools:" ;
    echo "- Cache cleaning for pacman [pacman]" ;
    echo "" ;
    echo "~ [help] to display this help." ;
    echo "~ [exit] to exit cache cleaning."
}


help ;
while read cmd ; do
    case $cmd in
        "help") help ;;
        "exit") break ;;
        "pacman") clean_packages_cache_for_pacman ;;
    esac
    echo "Continue on cache cleaning. [help] to display the help." ;
done ;
