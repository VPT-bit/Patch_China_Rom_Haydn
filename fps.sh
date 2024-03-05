#!/bin/bash

disable='
    .registers 4

    return-void
'
java -jar apktool/apktool.jar d PowerKeeper.apk -o tmp/
for nmethod in grep -rn "setScreenEffect" "tmp/smali"
do
  replace1=`cut -d ':' -f 1 $nmethod`
  replace2=`cut -d ':' -f 2 $nmethod`
done
java -jar apktool/apktool.jar b -f "tmp/" -o "tmp/"
