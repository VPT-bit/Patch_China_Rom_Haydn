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
  7z x -y "$path" *.dex -otmp/dex
  for dex_file in tmp/dex/*.dex; do
            dex_name=$(basename $dex_file | cut -d '.' -f 2)
            baksmali d --api 34 ${dex_file} -o tmp/dex/$dex_name > /dev/null 2>&1 && green "baksmaling $dex_name done" || error "baksmaling failed"
  done
  for file_smali in $(find tmp/dex -type f -name *.smali);
  do
    if grep -q "setScreenEffect" "$file_smali"; then
      sudo python3 remake_method.py "$file_smali" "setScreenEffect" "$disable" && green "Patched method setScreenEffect in $file_smali" || error "Failed to patch method setScreenEffect"
    fi 
    if grep -q "setScreenEffectInternal" "$file_smali"; then
      sudo python3 remake_method.py "$file_smali" "setScreenEffectInternal" "$disable" && green "Patched method setScreenEffectInternal in $file_smali" || error "Failed to patch method setScreenEffectInternal"
    fi
  done
  mkdir -p output
  for dex_file in tmp/dex/classes*; do
    dex_name=$(cut -d '/' -f 3 $dex_file)
    smali a --api 34 tmp/dex/$dex_name -o tmp/dex/$dex_name.dex > /dev/null 2>&1 && green "smaling done" || error "smaling failed"
  done
  pushd tmp/dex > /dev/null 2>&1 || exit
  7z a -y -mx0 -tzip $name tmp/dex/*.dex  > /dev/null 2>&1 || error "compress failed"
  popd >/dev/null || exit
  cp -rf tmp/dex/$name output/$name.recompile
  zipalign -p -v 4 output/$name.recompile output/$name > /dev/null 2>&1 && green "Zipalign successfully" || error "Failed to zipalign"
  apksigner verify output/$name && green "signed" || error "fail to sign"
  rm -rf tmp/*
}

patch_fps_limit "PowerKeeper.apk"
