#!/bin/sh

# docker
if [ -f prune-docker.sh ]; then
    . ./prune-docker.sh ;
fi

# trash
if [ -f trash.sh ]; then
    . ./trash.sh ;
fi
