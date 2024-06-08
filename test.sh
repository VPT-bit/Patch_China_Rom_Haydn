#!/bin/bash
dir=$(pwd)
sudo chmod 777 -R *
apkpath=$(find . -type f -name *.apk)
bin/apktool/apktool d $apkpath
