#!/bin/bash

RPS_HOME='/home/aresuser/ARES-Setup'
if [ ! -z "$1" ];then
    RPS_HOME="$1"
fi
if [ ! -d "$RPS_HOME" ];then
    echo "RetroPie-Setup directory $RPS_HOME doesn't exist. Please input the location of Ares."
    echo "EX: ./install-extras.sh /home/aresuser/ARES-Setup"
    exit
fi

echo "Placing scriptmodules in $RPS_HOME"
cp -R scriptmodules/* $RPS_HOME/scriptmodules
