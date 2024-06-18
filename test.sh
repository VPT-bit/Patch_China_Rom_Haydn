#!/bin/bash
source functions.sh
dir=$(pwd)
patch_method()
{
  stock_file=$(find . -type f -name "$1")
  [ -f $stock_file ] && green "Found $1 in $stock_file" || error "Not found $1"
  java -jar bin/apktool/apktool_2.9.3.jar d $stock_file -o tmp > /dev/null 2>&1 && green "Decompile $1 successfully" || error "Failed to decompile $1"
  for filesmali in $(find tmp/smali -type f -name *.smali);
  do
    if grep -q "$2" "$filesmali"; then
      sed -i "s/$2/$3/g" "$filesmali" && yellow "Patched $filesmali" || error "Error"
    fi
  done
  mkdir -p output
  java -jar bin/apktool/apktool_2.9.3.jar b tmp -o output/$1.recompile > /dev/null 2>&1 && green "Compile $1 successfully" || error "Failed to compile $1"
  zipalign -p -v 4 output/$1.recompile output/$1 > /dev/null 2>&1 && green "Zipalign successfully" || error "Failed to zipalign"
  rm -rf tmp/*
}
sudo python3 test.py "test.smali" "parseTopSmartAppFromDb" "\n\t.registers 4\n\n\treturn-void\n"
