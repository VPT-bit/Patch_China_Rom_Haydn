#!/bin/bash
sudo apt install axel zip unzip apktool apksigner zipalign busybox p7zip-full openjdk-8-jre android-sdk-libsparse-utils
source functions.sh
axel -n $(nproc) https://github.com/VPT-bit/Patch_China_Rom_Haydn/releases/download/alpha/com.miui.powerkeeper_4.2.00-40200_minAPI33.nodpi._apkmirror.com.apk
mkdir -p rom/images
mkdir -p tmp
mv -v com.miui.powerkeeper*.apk PowerKeeper.apk
mv -v PowerKeeper.apk rom/images
smali_path="DisplayFrameSetting*.smali"
method=".method public setScreenEffect(II)V/,/.end method"
replace_string=".method public setScreenEffect(II)V\n\t.registers 4\n\n\treturn-void\n.end method"
patch_smali "PowerKeeper.apk" "DisplayFrameSetting.smali" ".method public setScreenEffect(II)V/,/.end method" ".method public setScreenEffect(II)V\n\t.registers 4\n\n\treturn-void\n.end method"
