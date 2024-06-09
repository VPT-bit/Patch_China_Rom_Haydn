#!/bin/bash
dir=$(pwd)
sudo chmod 777 -R *
patch_method()
{
  stock_file=$(find . -type f -name "$1")
  [ -f $stock_file ] && echo Found $1 in $stock_file || echo Not found $1
  java -jar bin/apktool/apktool_2.9.3.jar d $stock_file -o tmp > /dev/null 2>&1 && echo Decompile $1 successfully || echo Failed to decompile $1
  for filesmali in $(find tmp/smali -type f -name *.smali);
  do
    if grep -q "$2" "$filesmali"; then
      sed -i "s/$2/$3/g" "$filesmali" && echo Patched $filesmali || echo Error
    fi
  done
  java -jar bin/apktool/apktool_2.9.3.jar b tmp -o $1.recompile > /dev/null 2>&1 && echo Compile $1 successfully || echo Failed to compile $1
  zipalign -p -v 4 $1.recompile $1 > /dev/null 2>&1 && echo Zipalign successfully || echo Failed to zipalign
  rm -rf tmp/*
}
patch_method "PowerKeeper.apk" "Lmiui\/os\/Build;->IS_INTERNATIONAL_BUILD:Z" "Lmiuix\/os\/Build;->IS_INTERNATIONAL_BUILD:Z"
