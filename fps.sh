#!/bin/bash

disable='
    .registers 4

    return-void
'
apktool d PowerKeeper.apk -o tmp/
smali -check -method "setScreenEffect" -remake "$disable" -dir "tmp/"
smali -check -method "setScreenEffectInternal" -remake "$disable" -dir "tmp/"
apktool -preserve-signature -recompile "tmp/" -output .
