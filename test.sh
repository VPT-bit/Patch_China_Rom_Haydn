#!/bin/bash
sudo apt install axel zip unzip apktool apksigner zipalign busybox p7zip-full openjdk-8-jre android-sdk-libsparse-utils
source functions.sh
axel -n $(nproc) https://github.com/VPT-bit/Patch_China_Rom_Haydn/releases/download/alpha/com.miui.powerkeeper_4.2.00-40200_minAPI33.nodpi._apkmirror.com.apk
mkdir -p rom/images
mkdir -p tmp
mv -v com.miui.powerkeeper*.apk PowerKeeper.apk
mv -v PowerKeeper.apk rom/images
method=".method public setScreenEffect(II)V/,/.end method"
replace_string=".method public setScreenEffect(II)V\n\t\t.registers 4\n\n\t\treturn-void\n.end method"
patch_smali "PowerKeeper.apk" "*.smali" $method $replace_string
