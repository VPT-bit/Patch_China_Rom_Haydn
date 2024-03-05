#!/bin/bash

disable='
    .registers 4

    return-void
'
java -jar apktool/apktool.jar d PowerKeeper.apk -o tmp/
for nmethod in grep -rn "setScreenEffect" "tmp/smali"
do
  echo $nmethod
done
java -jar apktool/apktool.jar b -f "tmp/" -o "tmp/"
