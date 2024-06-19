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
    java -jar bin/apktool/apktool_2.9.3.jar d "$path" -o tmp > /dev/null 2>&1 && green "decompling done" || error "failed to decompile"
    for file_smali in $(find tmp -type f -name *.smali);
    do
        if [ grep -q "setScreenEffect" "$file_smali" ]; then
            sudo python3 remake_method.py "$file_smali" "setScreenEffect" "$disable" && green "Patched method setScreenEffect in $file_smali" || error "Failed to patch method setScreenEffect"
        fi 
        if [ grep -q "setScreenEffectInternal" "$file_smali" ]; then
            sudo python3 remake_method.py "$file_smali" "setScreenEffectInternal" "$disable" && green "Patched method setScreenEffectInternal in $file_smali" || error "Failed to patch method setScreenEffectInternal"
        fi
    done
    mkdir -p output
    java -jar bin/apktool/apktool_2.9.3.jar b -c tmp -o output/$name.out > /dev/null 2>&1 && green "compiling done" || error "failed to compile"
    zipalign -p -f -v 4 output/$name.out output/$name > /dev/null 2>&1 && green "Zipalign successfully" || error "Failed to zipalign"
    apksigner verify output/$name && green "signed" || error "fail to sign"
    if [ ! -f output/$name ]; then
        error "broken process"
        exit
    fi
    rm -rf tmp/*
}

patch_fps_limit "PowerKeeper.apk"
