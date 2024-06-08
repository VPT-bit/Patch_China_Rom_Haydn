#!/bin/bash
dir=$(pwd)
sudo chmod 777 -R *
apkpath=$(find . -type f -name *.apk)
apktool d $apkpath -o tmp
