#!/usr/bin/env bash

ylw='\e[33m'
rst='\e[0m'
dim='\e[2m'

echo -e "$ylw[*] This script will perform apt-get updating and so will require sudo password!$rst"
sudo apt-get update && sudo apt-get dist-upgrade -y && sudo apt-get autoremove -y
echo -e "$rst"
