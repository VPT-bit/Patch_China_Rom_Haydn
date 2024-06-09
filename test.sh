#!/bin/bash
dir=$(pwd)
sudo chmod 777 -R *
patch_method()
{
  for filesmali in $(find tmp/smali -type f -name *.smali);
  do
    if grep -q "$1" "$filesmali"; then
      echo Patching $filesmali...
      sed -i "s/$1/$2/g" "$filesmali" && echo Patched $filesmali || echo Error
    fi
  done
}
apkpath=$(find . -type f -name *.apk)
apktool d $apkpath -o tmp
patch_method "Lmiui\/os\/Build;->IS_INTERNATIONAL_BUILD:Z" "Lmiuix\/os\/Build;->IS_INTERNATIONAL_BUILD:Z"
apktool b tmp -o tmp
