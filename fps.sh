#!/bin/bash

disable='
    .registers 4

    return-void
'
java -jar apktool/apktool.jar d PowerKeeper.apk -o tmp/
grep -rn "setScreenEffect" "tmp/smali"
java -jar apktool/apktool.jar b -f "tmp/" -o "tmp/"
