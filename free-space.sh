#!/bin/sh

scripts="./scripts" ;

# docker
read -p "Docker pruning? [y/n]" answer ;
if [ "$answer" == "y" ] && [ -f "${scripts}/prune-docker.sh" ]; then
    . "${scripts}/prune-docker.sh" ;
fi

# trash
read -p "Trash cleaning? [y/n]" answer ;
if [ "$answer" == "y" ] && [ -f "${scripts}/trash.sh" ]; then
    . "${scripts}/trash.sh" ;
fi
