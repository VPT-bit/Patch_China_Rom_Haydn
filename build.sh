#!/bin/bash

build_user="vpt"
build_host=$(hostname)

baserom="$1"

work_dir=$(pwd)
tools_dir=${work_dir}/bin/$(uname)/$(uname -m)
export PATH=$(pwd)/bin/$(uname)/$(uname -m)/:$(pwd)/otatools/bin:$PATH

source functions.sh

shopt -s expand_aliases
if [[ "$OSTYPE" == "darwin"* ]]; then
    yellow "macOS detected, setting alias"
    alias sed=gsed
    alias tr=gtr
    alias grep=ggrep
    alias du=gdu
    alias date=gdate
    #alias find=gfind
fi

check unzip aria2c 7z zip java zipalign python3 zstd bc xmlstarlet



if [ ! -f "${baserom}" ] && [ "$(echo $baserom | grep http)" != "" ];then
    blue "Download link detected, start downloading.."
    aria2c --max-download-limit=1024M --file-allocation=none -s10 -x10 -j10 ${baserom}
    baserom=$(basename ${baserom} | sed 's/\?t.*//')
    if [ ! -f "${baserom}" ];then
        error "Download error!"
    fi
elif [ -f "${baserom}" ];then
    green "BASEROM: ${baserom}"
else
    error "BASEROM: Invalid parameter"
    exit
fi


if [ "$(echo $baserom | grep miui_)" != "" ]; then
    device_code=$(basename $baserom | cut -d '_' -f 2)
else
    error "Undefined ROM"
    exit
fi

blue "Validating BASEROM.."
if unzip -l ${baserom} | grep -q "payload.bin"; then
    baserom_type="payload"
    green "Found payload.bin file"
    super_list="vendor mi_ext odm odm_dlkm system system_dlkm vendor_dlkm product product_dlkm system_ext"
else
    error "payload.bin not found, please use HyperOS official OTA zip package."
    exit
fi
green "ROM validation passed."

mkdir -p build/baserom/images/

if [[ ${baserom_type} == 'payload' ]];then
    blue "Extracting files from BASEROM [payload.bin]"
    payload-dumper --out build/baserom/images/ $baserom
    green "[payload.bin] extracted."

pack_type=$($tools_dir/gettype -i build/baserom/images/system.img)

for part in system product vendor; do
    if [[ -f build/baserom/images/${part}.img ]]; then
        extract_partition build/baserom/images/${part}.img build/baserom/images
        green "Extracted ${part}"
    fi
done

super_list=$(sed '/^#/d;/^\//d;/overlay/d;/^$/d' build/baserom/images/vendor/etc/fstab.qcom | awk '{ print $1}' | sort | uniq)
green "Partitions of super:"
green "$super_list"

base_android_version=$(< build/baserom/images/system/system/build.prop grep "ro.system.build.version.release" | awk 'NR==1' | cut -d '=' -f 2)
green "Android Version: ${base_android_version}"
base_rom_version=$(< build/baserom/images/vendor/build.prop grep "ro.vendor.build.version.incremental" |awk 'NR==1' |cut -d '=' -f 2)

#baseAospWifiResOverlay=$(find build/baserom/images/product -type f -name "AospWifiResOverlay.apk")
##portAospWifiResOverlay=$(find build/baserom/images/product -type f -name "AospWifiResOverlay.apk")
#if [ -f ${baseAospWifiResOverlay} ] && [ -f ${portAospWifiResOverlay} ];then
#    blue "正在替换 [AospWifiResOverlay.apk]"
#    cp -rf ${baseAospWifiResOverlay} ${portAospWifiResOverlay}
#fi

# radio lib
# blue "信号相关"
# for radiolib in $(find build/baserom/images/system/system/lib/ -maxdepth 1 -type f -name "*radio*");do
#     cp -rf $radiolib build/baserom/images/system/system/lib/
# done

# for radiolib in $(find build/baserom/images/system/system/lib64/ -maxdepth 1 -type f -name "*radio*");do
#     cp -rf $radiolib build/baserom/images/system/system/lib64/
# done


# audio lib
# blue "音频相关"
# for audiolib in $(find build/baserom/images/system/system/lib/ -maxdepth 1 -type f -name "*audio*");do
#     cp -rf $audiolib build/baserom/images/system/system/lib/
# done

# for audiolib in $(find build/baserom/images/system/system/lib64/ -maxdepth 1 -type f -name "*audio*");do
#     cp -rf $audiolib build/baserom/images/system/system/lib64/
# done

# # bt lib
# blue "蓝牙相关"
# for btlib in $(find build/baserom/images/system/system/lib/ -maxdepth 1 -type f -name "*bluetooth*");do
#     cp -rf $btlib build/baserom/images/system/system/lib/
# done

# for btlib in $(find build/baserom/images/system/system/lib64/ -maxdepth 1 -type f -name "*bluetooth*");do
#     cp -rf $btlib build/baserom/images/system/system/lib64/
# done

# MusicFX
#baseMusicFX=$(find build/baserom/images/product build/baserom/images/system -type d -name "MusicFX")
#portMusicFX=$(find build/baserom/images/product build/baserom/images/system -type d -name "MusicFX")
#if [ -d ${baseMusicFX} ] && [ -d ${portMusicFX} ];then
#    blue "正在替换 MusicFX"
##    rm -rf ./${portMusicFX}/*
 #   cp -rf ./${baseMusicFX}/* ${portMusicFX}/
#fi

# props from k60
echo "persist.vendor.mi_sf.optimize_for_refresh_rate.enable=1" >> build/baserom/images/vendor/build.prop
echo "ro.vendor.mi_sf.ultimate.perf.support=true"  >> build/baserom/images/vendor/build.prop

#echo "debug.sf.set_idle_timer_ms=1100" >> build/baserom/images/vendor/build.prop

#echo "ro.surface_flinger.set_touch_timer_ms=200" >> build/baserom/images/vendor/build.prop

# https://source.android.com/docs/core/graphics/multiple-refresh-rate
echo "ro.surface_flinger.use_content_detection_for_refresh_rate=false" >> build/baserom/images/vendor/build.prop
echo "ro.surface_flinger.set_touch_timer_ms=0" >> build/baserom/images/vendor/build.prop
echo "ro.surface_flinger.set_idle_timer_ms=0" >> build/baserom/images/vendor/build.prop


blue "StrongToast UI fix"
patch_smali "MiuiSystemUI.apk" "MIUIStrongToast\$2.smali" "const\/4 v9\, 0x0" "iget-object v9\, v1\, Lcom\/android\/systemui\/toast\/MIUIStrongToast;->mRLLeft:Landroid\/widget\/RelativeLayout;\\n\\tinvoke-virtual {v9}, Landroid\/widget\/RelativeLayout;->getLeft()I\\n\\tmove-result v9\\n\\tint-to-float v9,v9"


if [[ ! -d tmp ]];then
    mkdir -p tmp/
fi
blue "Disalbe Android 14 Apk Signature Verfier"
mkdir -p tmp/services/
cp -rf build/baserom/images/system/system/framework/services.jar tmp/services.jar

java -jar bin/apktool/APKEditor.jar d -f -i tmp/services.jar -o tmp/services  > /dev/null 2>&1
target_method='getMinimumSignatureSchemeVersionForTargetSdk' 
old_smali_dir=""
declare -a smali_dirs

while read -r smali_file; do
    smali_dir=$(echo "$smali_file" | cut -d "/" -f 3)

    if [[ $smali_dir != $old_smali_dir ]]; then
        smali_dirs+=("$smali_dir")
    fi

    method_line=$(grep -n "$target_method" "$smali_file" | cut -d ':' -f 1)
    register_number=$(tail -n +"$method_line" "$smali_file" | grep -m 1 "move-result" | tr -dc '0-9')
    move_result_end_line=$(awk -v ML=$method_line 'NR>=ML && /move-result /{print NR; exit}' "$smali_file")
    orginal_line_number=$method_line
    replace_with_command="const/4 v${register_number}, 0x0"
    { sed -i "${orginal_line_number},${move_result_end_line}d" "$smali_file" && sed -i "${orginal_line_number}i\\${replace_with_command}" "$smali_file"; } &&    blue "${smali_file}  修改成功" "${smali_file} patched"
    old_smali_dir=$smali_dir
done < <(find tmp/services/smali/*/com/android/server/pm/ tmp/services/smali/*/com/android/server/pm/pkg/parsing/ -maxdepth 1 -type f -name "*.smali" -exec grep -H "$target_method" {} \; | cut -d ':' -f 1)

target_canJoinSharedUserId_method='canJoinSharedUserId' 
find tmp/services/ -type f -name "ReconcilePackageUtils.smali" | while read smali_file; do
    cp -rfv $smali_file tmp/
    method_line=$(grep -n "$target_canJoinSharedUserId_method" "$smali_file" | cut -d ':' -f 1)

    register_number=$(tail -n +"$method_line" "$smali_file" | grep -m 1 "move-result" | tr -dc '0-9')

    move_result_end_line=$(awk -v ML=$method_line 'NR>=ML && /move-result /{print NR; exit}' "$smali_file")

    replace_with_command="const/4 v${register_number}, 0x1"

    { sed -i "${method_line},${move_result_end_line}d" "$smali_file" && sed -i "${method_line}i\\${replace_with_command}" "$smali_file"; }
done
java -jar bin/apktool/APKEditor.jar b -f -i tmp/services -o tmp/services_patched.jar > /dev/null 2>&1
cp -rf tmp/services_patched.jar build/baserom/images/system/system/framework/services.jar


if [ -f build/baserom/images/system/system/etc/init/hw/init.rc ]; then
	sed -i '/on boot/a\'$'\n''    chmod 0731 \/data\/system\/theme' build/baserom/images/system/system/etc/init/hw/init.rc
fi


yellow "Debloating..." 
debloat_apps=("MSA" "mab" "MiBrowser" "MiService" "MIService" "SoterService" "Hybrid" "AnalyticsCore")

for debloat_app in "${debloat_apps[@]}"; do
    app_dir=$(find build/baserom/images/product -type d -name "*$debloat_app*")
    
    if [[ -d "$app_dir" ]]; then
        yellow "Removing directory: $app_dir"
        rm -rf "$app_dir"
    fi
done
rm -rf build/baserom/images/product/etc/auto-install*
rm -rf build/baserom/images/product/data-app/*GalleryLockscreen* >/dev/null 2>&1
mkdir -p tmp/app
kept_data_apps=("ThirdAppAssistant" "Weather" "Gallery" "SoundRecorder" "ScreenRecorder" "Calculator" "CleanMaster" "Calendar" "DeskClock" "Compass" "Notes" "MediaEditor" "Scanner")
for app in "${kept_data_apps[@]}"; do
    mv build/baserom/images/product/data-app/*"${app}"* tmp/app/ >/dev/null 2>&1
    done
rm -rf build/baserom/images/product/data-app/*
cp -rf tmp/app/* build/baserom/images/product/data-app
rm -rf tmp/app

blue "Modifying build.prop"

export LC_ALL=en_US.UTF-8
buildDate=$(date -u +"%a %b %d %H:%M:%S UTC %Y")
buildUtc=$(date +%s)
for i in $(find build/baserom/images -type f -name "build.prop");do
    blue "modifying ${i}"
    sed -i "s/persist.sys.timezone=.*/persist.sys.timezone=Asia\/Ho_Chi_Minh/g" ${i}
    sed -i "s/ro.build.user=.*/ro.build.user=${build_user}/g" ${i}
    sed -i "s/ro.product.mod_device=.*/ro.product.mod_device=${base_rom_code}/g" ${i}
    sed -i "s/ro.build.host=.*/ro.build.host=${build_host}/g" ${i}
done

#game spash screen
echo "debug.game.video.speed=true" >> build/baserom/images/product/etc/build.prop
echo "debug.game.video.support=true" >> build/baserom/images/product/etc/build.prop

#add 90Hz
new_fps=$(xmlstarlet sel -t -v "//integer-array[@name='fpsList']/item" mayfly.xml | sort -nr | awk '{print $0 "\n90"}' | sort -nr | tr '\n' ' ')
xmlstarlet ed -u "//integer-array[@name='fpsList']/item" -v "$(echo $new_fps | tr ' ' '\n')" mayfly.xml > temp.xml && mv temp.xml mayfly.xml


targetFrameworkExtRes=$(find build/baserom/images/system_ext -type f -name "framework-ext-res.apk")
if [[ -f $targetFrameworkExtRes ]] && [[ ${base_android_version} != "15" ]]; then
    mkdir tmp/  > /dev/null 2>&1 
    java -jar bin/apktool/APKEditor.jar d -i $targetFrameworkExtRes -o tmp/framework-ext-res -f > /dev/null 2>&1
    if grep -r config_celluar_shared_support tmp/framework-ext-res/ ; then  
        yellow "Enable Celluar Sharing feature"
        for xml in $(find tmp/framework-ext-res -name "*.xml");do
            sed -i 's|<bool name="config_celluar_shared_support">false</bool>|<bool name="config_celluar_shared_support">true</bool>|g' "$xml"
        done
    fi
    filename=$(basename $targetFrameworkExtRes)
    java -jar bin/apktool/APKEditor.jar b -i tmp/framework-ext-res -o tmp/$filename -f> /dev/null 2>&1 || error "apktool mod failed"
        cp -rf tmp/$filename $targetFrameworkExtRes
fi

targetMiLinkOS2APK=$(find build/baserom -type f -name "MiLinkOS2CN.apk")
if [[ -f $targetMiLinkOS2APK ]];then
    cp -rf $targetMiLinkOS2APK tmp/$(basename $targetMiLinkOS2APK).bak
    java -jar bin/apktool/APKEditor.jar d -i $targetMiLinkOS2APK -o tmp/MiLinkOS2 -f > /dev/null 2>&1
    targetsmali=$(find tmp/MiLinkOS2 -name "HMindManager.smali")
    python3 bin/patchmethod.py -d tmp/MiLinkOS2 -k "isSupportCapability() context == null" -return true
    python3 bin/patchmethod.py $targetsmali J -return true
    java -jar bin/apktool/APKEditor.jar b -i tmp/MiLinkOS2 -o $targetMiLinkOS2APK -f > /dev/null 2>&1

fi

targetMIUIThemeManagerAPK=$(find build/baserom -type f -name "MIUIThemeManager.apk")
if [[ -f $targetMIUIThemeManagerAPK ]];then
    cp -rf $targetMIUIThemeManagerAPK tmp/$(basename $targetMIUIThemeManagerAPK).bak
    java -jar bin/apktool/APKEditor.jar d -i $targetMIUIThemeManagerAPK -o tmp/MIUIThemeManager -f > /dev/null 2>&1
    targetsmali=$(find tmp/ -name "o1t.smali" -path "*/basemodule/utils/*")
    python3 bin/patchmethod.py $targetsmali mcp -return true
    java -jar bin/apktool/APKEditor.jar b -i tmp/MIUIThemeManager -o $targetMIUIThemeManagerAPK -f > /dev/null 2>&1

fi

targetSettingsAPK=$(find build/baserom -type f -name "Settings.apk")
if [[ -f $targetSettingsAPK ]];then
    cp -rf $targetSettingsAPK tmp/$(basename $targetSettingsAPK).bak
    java -jar bin/apktool/APKEditor.jar d -i $targetSettingsAPK -o tmp/Settings -f > /dev/null 2>&1
    targetsmali=$(find tmp/ -type f -path "*/com/android/settings/InternalDeviceUtils.smali")
    python3 bin/patchmethod.py $targetsmali isAiSupported -return true
    java -jar bin/apktool/APKEditor.jar b -i tmp/Settings -o $targetSettingsAPK -f > /dev/null 2>&1
fi


blue "Integrating perfect icons"  
git clone --depth=1 https://github.com/pzcn/Perfect-Icons-Completion-Project.git icons &>/dev/null
for pkg in "$work_dir"/build/baserom/images/product/media/theme/miui_mod_icons/dynamic/*; do
  if [[ -d "$work_dir"/icons/icons/$pkg ]]; then
    rm -rf "$work_dir"/icons/icons/$pkg
  fi
done
rm -rf "$work_dir"/icons/icons/com.xiaomi.scanner
mv "$work_dir"/build/baserom/images/product/media/theme/default/icons "$work_dir"/build/baserom/images/product/media/theme/default/icons.zip
rm -rf "$work_dir"/build/baserom/images/product/media/theme/default/dynamicicons
mkdir -p "$work_dir"/icons/res
mv "$work_dir"/icons/icons "$work_dir"/icons/res/drawable-xxhdpi
cd "$work_dir"/icons
zip -qr "$work_dir"/build/baserom/images/product/media/theme/default/icons.zip res
cd "$work_dir"/icons/themes/Hyper/
zip -qr "$work_dir"/build/baserom/images/product/media/theme/default/dynamicicons.zip layer_animating_icons
cd "$work_dir"/icons/themes/common/
zip -qr "$work_dir"/build/baserom/images/product/media/theme/default/dynamicicons.zip layer_animating_icons
mv "$work_dir"/build/baserom/images/product/media/theme/default/icons.zip "$work_dir"/build/baserom/images/product/media/theme/default/icons
mv "$work_dir"/build/baserom/images/product/media/theme/default/dynamicicons.zip "$work_dir"/build/baserom/images/product/media/theme/default/dynamicicons
rm -rf "$work_dir"/icons
cd "$work_dir"

if ! is_property_exists ro.miui.surfaceflinger_affinity build/baserom/images/product/etc/build.prop; then
    echo "ro.miui.surfaceflinger_affinity=true" >> build/baserom/images/product/etc/build.prop
fi

blue "Disable avb verification."
disable_avb_verify build/baserom/images/

sum_size=0
for pname in ${super_list}; do
    if [ -f "build/baserom/images/${pname}.img" ];then
        subsize=$(du -sb build/baserom/images/${pname}.img | tr -cd 0-9)
        sum_size=$((sum_size + subsize))
        unset subsize
    fi
done

blue "Packing img..."
for pname in ${super_list}; do
            blue "Packing ${pname}.img with $pack_type filesystem"
            python3 bin/fspatch.py build/baserom/images/${pname} build/baserom/images/config/${pname}_fs_config
            python3 bin/contextpatch.py build/baserom/images/${pname} build/baserom/images/config/${pname}_file_contexts
            #sudo perl -pi -e 's/\\@/@/g' build/baserom/images/config/${pname}_file_contexts
            mkfs.erofs -zlz4hc,9 --mount-point /${pname} --fs-config-file build/baserom/images/config/${pname}_fs_config --file-contexts build/baserom/images/config/${pname}_file_contexts build/baserom/images/${pname}.img build/baserom/images/${pname}
            if [ -f "build/baserom/images/${pname}.img" ]; then
                green "Packing ${pname}.img successfully with erofs format"
                rm -rf build/baserom/images/${pname}
            else
                error "Failed to pack ${pname} parition"
                exit 1
            fi
done
os_type="hyperos"
for img in $(find build/baserom/ -type f -name "vbmeta*.img"); do
    python3 bin/patch-vbmeta.py ${img} > /dev/null 2>&1
done


blue "Packing super.img"
lpargs="-F --virtual-ab --output build/baserom/images/super.img --metadata-size 65536 --super-name super --metadata-slots 3 --device super:auto --group=qti_dynamic_partitions_a:${sum_size} --group=qti_dynamic_partitions_b:${sum_size}"

for pname in ${super_list};do
    if [ -f "build/baserom/images/${pname}.img" ];then
        subsize=$(du -sb build/baserom/images/${pname}.img | tr -cd 0-9)
        green "Super sub-partition [$pname] size: [$subsize]"
        args="--partition ${pname}_a:readonly:${subsize}:qti_dynamic_partitions_a --image ${pname}_a=build/baserom/images/${pname}.img --partition ${pname}_b:readonly:0:qti_dynamic_partitions_b"
        lpargs="$lpargs $args"
        unset subsize
        unset args
    fi
done
lpmake $lpargs > /dev/null 2>&1

if [ -f "build/baserom/images/super.img" ]; then
    green "Pakcing super.img done."
else
    error "Unable to pack super.img."
    exit 1
fi

for pname in ${super_list};do
    rm -rf build/baserom/images/${pname}.img
done



blue "Comprising super.img"
zstd --rm build/baserom/images/super.img -o build/baserom/images/super.zst
mkdir -p out/${os_type}_${device_code}_${base_rom_version}/META-INF/com/google/android/


blue "Generating flashing script"

mkdir -p out/${os_type}_${device_code}_${base_rom_version}/bin/windows/
mv -f build/baserom/images/super.zst out/${os_type}_${device_code}_${base_rom_version}/
#firmware
cp -rf bin/flash/platform-tools-windows/* out/${os_type}_${device_code}_${base_rom_version}/bin/windows/
cp -rf bin/flash/mac_linux_flash_script.sh out/${os_type}_${device_code}_${base_rom_version}/
cp -rf bin/flash/windows_flash_script.bat out/${os_type}_${device_code}_${base_rom_version}/

cp -rf bin/flash/update-binary out/${os_type}_${device_code}_${base_rom_version}/META-INF/com/google/android/

mkdir -p out/${os_type}_${device_code}_${base_rom_version}/firmware-update


cp -f build/baserom/images/*.img out/${os_type}_${device_code}_${base_rom_version}/firmware-update/
for fwimg in $(ls out/${os_type}_${device_code}_${base_rom_version}/firmware-update | cut -d "." -f 1 | grep -vE "super|cust|preloader"); do
    if [[ $fwimg == *"reserve"* ]]; then
        continue
    elif [[ $fwimg == "mdm_oem_stanvbk" ]] || [[ $fwimg == "spunvm" ]] ;then
        sed -i "/REM firmware/a \\\bin\\\windows\\\fastboot.exe flash "${fwimg}" firmware-update\/"${fwimg}".img" out/${os_type}_${device_code}_${base_rom_version}/windows_flash_script.bat
        sed -i "/# firmware/a package_extract_file \"firmware-update/${fwimg}\" \"/dev/block/bootdevice/by-name/${part}\"" out/${os_type}_${device_code}_${base_rom_version}/META-INF/com/google/android/update-binary
    elif [ "$(echo ${fwimg} | grep vbmeta)" != "" ];then
        sed -i "/REM firmware/a \\\bin\\\windows\\\fastboot.exe --disable-verity --disable-verification flash "${fwimg}"_b firmware-update\/"${fwimg}".img" out/${os_type}_${device_code}_${base_rom_version}/windows_flash_script.bat
        sed -i "/REM firmware/a \\\bin\\\windows\\\fastboot.exe --disable-verity --disable-verification flash "${fwimg}"_a firmware-update\/"${fwimg}".img" out/${os_type}_${device_code}_${base_rom_version}/windows_flash_script.bat
        sed -i "/# firmware/a package_extract_file \"firmware-update/${fwimg}_a\" \"/dev/block/bootdevice/by-name/${part}\"" out/${os_type}_${device_code}_${base_rom_version}/META-INF/com/google/android/update-binary
        sed -i "/# firmware/a package_extract_file \"firmware-update/${fwimg}_b\" \"/dev/block/bootdevice/by-name/${part}\"" out/${os_type}_${device_code}_${base_rom_version}/META-INF/com/google/android/update-binary
    else
        sed -i "/REM firmware/a \\\bin\\\windows\\\fastboot.exe flash "${fwimg}"_b firmware-update\/"${fwimg}".img" out/${os_type}_${device_code}_${base_rom_version}/windows_flash_script.bat
        sed -i "/REM firmware/a \\\bin\\\windows\\\fastboot.exe flash "${fwimg}"_a firmware-update\/"${fwimg}".img" out/${os_type}_${device_code}_${base_rom_version}/windows_flash_script.bat
        sed -i "/# firmware/a package_extract_file \"firmware-update/${fwimg}_a\" \"/dev/block/bootdevice/by-name/${part}\"" out/${os_type}_${device_code}_${base_rom_version}/META-INF/com/google/android/update-binary
        sed -i "/# firmware/a package_extract_file \"firmware-update/${fwimg}_b\" \"/dev/block/bootdevice/by-name/${part}\"" out/${os_type}_${device_code}_${base_rom_version}/META-INF/com/google/android/update-binary
    fi
done

cp -rf bin/flash/zstd out/${os_type}_${device_code}_${base_rom_version}/META-INF/

sed -i "s/portversion/${base_rom_version}/g" out/${os_type}_${device_code}_${base_rom_version}/META-INF/com/google/android/update-binary
sed -i "s/baseversion/${base_rom_version}/g" out/${os_type}_${device_code}_${base_rom_version}/META-INF/com/google/android/update-binary
sed -i "s/andVersion/${base_android_version}/g" out/${os_type}_${device_code}_${base_rom_version}/META-INF/com/google/android/update-binary
sed -i "s/device_code/${base_rom_code}/g" out/${os_type}_${device_code}_${base_rom_version}/META-INF/com/google/android/update-binary
sed -i "s/device_code/${base_rom_code}/g" out/${os_type}_${device_code}_${base_rom_version}/mac_linux_flash_script.sh
sed -i "s/device_code/${base_rom_code}/g" out/${os_type}_${device_code}_${base_rom_version}/windows_flash_script.bat
busybox unix2dos out/${os_type}_${device_code}_${base_rom_version}/windows_flash_script.bat

find out/${os_type}_${device_code}_${base_rom_version} | xargs touch
pushd out/${os_type}_${device_code}_${base_rom_version}/ >/dev/null || exit
zip -r ${os_type}_${device_code}_${base_rom_version}.zip ./*
mv ${os_type}_${device_code}_${base_rom_version}.zip ../
popd >/dev/null || exit
pack_timestamp=$(date +"%m%d%H%M")
hash=$(md5sum out/${os_type}_${device_code}_${base_rom_version}.zip | head -c 10)
mv out/${os_type}_${device_code}_${base_rom_version}.zip out/${os_type}_${device_code}_${base_rom_version}_${hash}_${pack_timestamp}.zip

green "Building completed"    
green "Output: "
green "out/${os_type}_${device_code}_${base_rom_version}_${hash}_${pack_timestamp}.zip"