#!/bin/sh

scripts="./scripts" ;

function logs_free() {
    script=$1 ;
    msg=$2 ;
    echo "Starting ${msg} cleaning..." ;
    . "$script" ;
    echo "Finished ${msg} cleaning."
}

# docker
read -p "Docker pruning? [y/n]" answer ;
if [ "$answer" == "y" ] && [ -f "${scripts}/prune-docker.sh" ]; then
    logs_free "${scripts}/prune-docker.sh" "docker 🐳";
fi

# trash
read -p "Trash cleaning? [y/n]" answer ;
if [ "$answer" == "y" ] && [ -f "${scripts}/trash.sh" ]; then
    logs_free "${scripts}/trash.sh" "trash 🗑️" ;
fi
