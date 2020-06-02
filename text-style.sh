#!/bin/bash

bold='\033[1m' ;
normal='\033[0m' ;

function turn_text_to_style() {
    style="$1" ;
    nonewline=$2 ;
    cmd="echo -e " ;
    if [ "$nonewline" = true ]; then
        cmd="${cmd} -n" ;
    fi
    $cmd "$style" ;
}

function turn_text_to_bold() {
    turn_text_to_style "$bold" $1;
}

function turn_text_to_normal() {
    turn_text_to_style "$normal" $1 ;
}
