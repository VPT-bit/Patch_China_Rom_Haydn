#!/bin/bash

disable='
    .registers 4

    return-void
'
apktool d PowerKeeper.apk -o tmp/
java -jar apktool/smali.jar -check -method "setScreenEffect" -remake "$disable" -dir "tmp/"
java -jar apktool/smali.jar -check -method "setScreenEffectInternal" -remake "$disable" -dir "tmp/"
apktool b "tmp/" -o .
