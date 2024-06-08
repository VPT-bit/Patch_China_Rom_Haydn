#!/bin/bash
dir=$(pwd)
sudo chmod 777 -R *
apkpath=$(find . -type f -name *.apk)
apktool d $apkpath -o tmp
sed -i "s/Lmiui\/os\/Build;->IS_INTERNATIONAL_BUILD:Z/Lmiuix\/os\/Build;->IS_INTERNATIONAL_BUILD:Z/g" "tmp/smali/miuix/os/Build.smali"
