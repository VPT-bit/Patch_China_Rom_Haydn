#!/bin/bash
source functions.sh
dir=$(pwd)
ksud="$GITHUB_WORKSPACE"/bin/ksud
disable="
    .registers 4

    return-void
"

patch_fps_limit()
{
    path="$1"
    name=$(basename "$path")
    [ -f $path ] && green "Found $name" || error "Not found $name"
    java -jar bin/apktool/apktool_2.9.3.jar if "$path" > /dev/null 2>&1 && green "installed framework" || error "failed to install framework"
    java -jar bin/apktool/apktool_2.9.3.jar d "$path" -o tmp > /dev/null 2>&1 && green "decompling done" || error "failed to decompile"
    file_smali=$(find . -type f -name DisplayFrameSetting.smali)
    sudo python3 remake_method.py "$file_smali" "setScreenEffect" "$disable" && green "Patched method setScreenEffect in $file_smali" || error "Failed to patch method setScreenEffect"
    sudo python3 remake_method.py "$file_smali" "setScreenEffect" "$disable" && green "Patched method setScreenEffect in $file_smali" || error "Failed to patch method setScreenEffect"
    sudo python3 remake_method.py "$file_smali" "setScreenEffectInternal" "$disable" && green "Patched method setScreenEffectInternal in $file_smali" || error "Failed to patch method setScreenEffectInternal"
    mkdir -p output
    java -jar bin/apktool/apktool_2.9.3.jar b -c tmp -o output/$name.out && green "compiling done" || error "failed to compile"
    zipalign -p -f -v 4 output/$name.out output/$name > /dev/null 2>&1 && green "Zipalign successfully" || error "Failed to zipalign"
    apksigner sign output/$name > /dev/null 2>&1 && green "signed" || error "fail to sign"
    if [ ! -f output/$name ]; then
        error "broken process"
        exit
    fi
    rm -rf tmp/*
}

$ksud boot-patch --boot tmp/boot.img --magiskboot bin/magiskboot --kmi android12-5.10
