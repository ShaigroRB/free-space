#!/bin/sh

scripts="./scripts" ;

# docker
if [ -f "${scripts}/prune-docker.sh" ]; then
    . "${scripts}/prune-docker.sh" ;
fi

# trash
if [ -f "${scripts}/trash.sh" ]; then
    . "${scripts}/trash.sh" ;
fi
