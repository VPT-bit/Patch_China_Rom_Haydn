#!/bin/bash

disable='
    .registers 4

    return-void
'
java -jar apktool/apktool.jar d PowerKeeper.apk -o tmp/
java -jar apktool/apktool.jar b -f "tmp/"
