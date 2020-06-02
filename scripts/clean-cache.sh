#!/bin/bash

function logs_cache_clean() {
    func=$1 ;
    prog=$2 ;
    echo "Start cache cleaning for ${prog}..." ;
    $func ;
    echo "Finished cache cleaning for ${prog}.✅" ;
}

function clean_packages_cache_for_pacman() {
    if [ ! -x "$(command -v paccache)" ]; then
        echo "⚠️ paccache might not be installed. ⚠️ Impossible to clean the cache without it." ;
        exit 2 ;
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
}

function help() {
    echo "" ;
    echo "Cache cleaning for different tools:" ;
    echo "- Cache cleaning for go [go]" ;
    echo "- Cache cleaning for pacman [pacman]" ;
    echo "" ;
    echo "~ [help] to display this help." ;
    echo "~ [exit] to exit cache cleaning."
}

function clean_go_cache() {
    if [ ! -x "$(command -v go)" ]; then
        echo "⚠️ go might not be installed.⚠️ No need to clean cache." ;
        exit 2 ;
    fi
    go clean -cache ;
    echo "Cleaned .cache/go-build. ✅" ;
}

help ;
while read cmd ; do
    case $cmd in
        "help") help ;;
        "exit") break ;;
        "go") logs_cache_clean clean_go_cache "go" ;;
        "pacman") logs_cache_clean clean_packages_cache_for_pacman "pacman" ;;
    esac
    echo "Continue on cache cleaning. [help] to display the help." ;
done ;
