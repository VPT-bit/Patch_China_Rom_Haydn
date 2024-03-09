#!/bin/bash
export PATH=$(pwd)/bin/:$PATH

# Import functions
source functions.sh

# Setup
sudo apt-get install -y git wget zip unzip axel python3-pip zipalign apksigner xmlstarlet
pip3 install ConfigObj

# unzip rom
unzip *HAYDN*.zip
rm -rf *HAYDN*.zip
