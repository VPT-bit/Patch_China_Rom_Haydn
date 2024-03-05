#!/bin/bash

disable='
    .registers 4

    return-void
'
apktool d PowerKeeper.apk -o tmp/
./apktool/smali.jar -check -method "setScreenEffect" -remake "$disable" -dir "tmp/"
./apktool/smali.jar -check -method "setScreenEffectInternal" -remake "$disable" -dir "tmp/"
apktool -preserve-signature -recompile "tmp/" -output .
