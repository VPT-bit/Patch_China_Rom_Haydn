#!/bin/bash
dir=$(pwd)
sudo chmod 777 -R *
apkpath=$(find . -type f -name *.apk)
mkdir -p tmp
apktool d $apkpath -o tmp
