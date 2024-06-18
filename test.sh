#!/bin/bash
source functions.sh
dir=$(pwd)
disable="
    .registers 4

    return-void
"
patch_fps_limit()
{
  path="$1"
  name=$(basename "$path")
  [ -f $path ] && green "Found $name" || error "Not found $name"
  java -jar bin/apktool/apktool_2.9.3.jar d $path -o tmp > /dev/null 2>&1 && green "Decompile $name successfully" || error "Failed to decompile $name"
  for file_smali in $(find tmp -type f -name *.smali);
  do
    if grep -q "setScreenEffect" "$file_smali"; then
      sudo python3 remake_method.py "$file_smali" "setScreenEffect" "$disable" && green "Patched method setScreenEffect in $file_smali" || error "Failed to patch method setScreenEffect"
    fi
    
    if grep -q "setScreenEffectInternal" "$file_smali"; then
      sudo python3 remake_method.ly "$file_smali" "setScreenEffectInternal" "$disable" && green "Patched method setScreenEffectInternal in $file_smali" || error "Failed to patch method setScreenEffectInternal"
    fi
  done
  mkdir -p output
  java -jar bin/apktool/apktool_2.9.3.jar b tmp -o output/$name.recompile > /dev/null 2>&1 && green "Compile $name successfully" || error "Failed to compile $name"
  zipalign -p -v 4 output/$name.recompile output/$name > /dev/null 2>&1 && green "Zipalign successfully" || error "Failed to zipalign"
  apksigner verify output/$name && green "signed" || error "fail to sign"
  rm -rf tmp/*
}

patch_fps_limit "PowerKeeper.apk"
