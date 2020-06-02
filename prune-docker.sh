#!/bin/bash

echo "Starting docker 🐳 pruning." ;

if [ -x "$(command -v docker )" ]; then
    echo "⚠️ This script might fail if docker is not running and you do not have the right to use docker. ⚠️" ;
else
    echo "⚠️ Docker might not be installed. ⚠️ No need to prune it." ;
    exit 2 ;
fi

echo "" ;
echo "Enter your prefered pruning for docker:" ;
echo "- Classic prune (volumes included) [classic]" ;
echo "- Full prune (stop all running containers & remove all containers and images) [full]" ;
echo "- Full safe prune (remove all stopped containers and unused images) [fullsafe]" ;
echo "- Step by step prune [step]" ;

read -p "[classic/full/fullsafe/step]: " pruningtype ;

function classic() {
    docker system prune --volumes -f ;
    echo "Dangling images, unused containers, networks and volumes removed. ✅" ;
}

function fullsafe() {
    docker rm $(docker ps -a -q) ;
    echo "Unused containers removed. ✅" ;
    docker image prune -a -f ;
    echo "Unused images removed. ✅" ;
}

function full() {
    docker stop $(docker ps -a -q) ;
    echo "Stopped all running containers. ✅" ;
    fullsafe ;
}

function step() {
    read -p "Stop running containers? [y/n]" answer ;
    if [ "$answer" == "y" ]; then
        docker stop $(docker ps -a -q) ;
        echo "Running containers stopped. ✅" ;
    fi

    read -p "Remove unused containers? [y/n]" answer ;
    if [ "$answer" == "y" ]; then
        docker rm $(docker ps -a -q) ;
        echo "Unused containers removed. ✅" ;
    fi

    read -p "Remove unused images? [y/n]" answer ;
    if [ "$answer" == "y" ]; then
        docker image prune -a -f ;
        echo "Unused images removed. ✅" ;
    fi

    read -p "Remove unused volumes? [y/n]" answer ;
    if [ "$answer" == "y" ]; then
        docker volume prune -f ;
        echo "Unused volumes removed. ✅" ;
    fi

    read -p "Remove unused networks? [y/n]" answer ;
    if [ "$answer" == "y" ]; then
        docker network prune -f ;
        echo "Unused networks removed. ✅" ;
    fi
}

function log_func() {
    func=$1 ;
    msg=$2 ;
    echo "Starting $msg prune..." ;
    $func ;
    echo "Finished $msg prune. ✅" ;
}

case "$pruningtype" in
    "classic") log_func classic "classic" ;;
    "full") log_func full "full" ;;
    "fullsafe") log_func fullsafe "full safe" ;;
    "step") log_func step "step by step" ;;
    *) echo "No pruning option typed." ;;
esac

echo "Docker 🐳 pruning finished. ✅" ;
