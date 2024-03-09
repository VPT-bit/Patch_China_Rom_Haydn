#!/bin/bash
export PATH=$PATH:$(pwd)/bin/
stock_rom="$1"
work_dir=$(pwd)

# Import functions
source functions.sh

# Setup
sudo apt-get install -y git zip unzip tar axel python3-pip zipalign apktool apksigner xmlstarlet busybox p7zip-full openjdk-8-jre android-sdk-libsparse-utils > /dev/null 2>&1
pip3 install ConfigObj > /dev/null 2>&1
green "Setup Completed"

# unzip rom
axel -n $(nproc) $stock_rom > /dev/null 2>&1
name_stock_rom=$(basename $stock_rom)
unzip ${name_stock_rom}.zip > /dev/null 2>&1
rm -rf ${name_stock_rom}.zip
blue "Unzip Rom Successfully"

# unpack payload.bin & image
payload-dumper-go -o rom/images ./payload.bin > /dev/null 2>&1
rm -rf payload.bin
green "Unpack payload.bin Completed"
cd ./rom/images
vbmeta-disable-verification ./vbmeta.img
for pname in system product vendor; do
  extract.erofs -i ./${pname}.img -x > /dev/null 2>&1
  rm -rf ./${pname}.img
  green "Extracted ${pname} Successfully"
done

# add gpu driver
blue "Installing gpu driver..."
###
cd ${work_dir}
echo /system/system/lib/egl/libVkLayer_ADRENO_qprofiler.so u:object_r:system_lib_file:s0 >> ./rom/images/config/system_file_contexts
echo /system/system/lib64/egl/libVkLayer_ADRENO_qprofiler.so u:object_r:system_lib_file:s0 >> ./rom/images/config/system_file_contexts
echo /system/system/lib64/libEGL.so u:object_r:system_lib_file:s0 >> ./rom/images/config/system_file_contexts
echo /system/system/lib64/libGLESv1_CM.so u:object_r:system_lib_file:s0 >> ./rom/images/config/system_file_contexts
echo /system/system/lib64/libGLESv2.so u:object_r:system_lib_file:s0 >> ./rom/images/config/system_file_contexts
echo /system/system/lib64/libGLESv3.so u:object_r:system_lib_file:s0 >> ./rom/images/config/system_file_contexts
echo /system/system/lib64/libvulkan.so u:object_r:system_lib_file:s0 >> ./rom/images/config/system_file_contexts
echo /system/system/lib/libEGL.so u:object_r:system_lib_file:s0 >> ./rom/images/config/system_file_contexts
echo /system/system/lib/libGLESv1_CM.so u:object_r:system_lib_file:s0 >> ./rom/images/config/system_file_contexts
echo /system/system/lib/libGLESv2.so u:object_r:system_lib_file:s0 >> ./rom/images/config/system_file_contexts
echo /system/system/lib/libGLESv3.so u:object_r:system_lib_file:s0 >> ./rom/images/config/system_file_contexts
echo /system/system/lib/libvulkan.so u:object_r:system_lib_file:s0 >> ./rom/images/config/system_file_contexts
###
echo /vendor/etc/sphal_libraries.txt u:object_r:same_process_hal_file:s0 >> ./rom/images/config/vendor_file_contexts
echo /vendor/lib/libEGL_adreno.so u:object_r:same_process_hal_file:s0 >> ./rom/images/config/vendor_file_contexts
echo /vendor/lib/libGLESv2_adreno.so u:object_r:same_process_hal_file:s0 >> ./rom/images/config/vendor_file_contexts
echo /vendor/lib/libadreno_app_profiles.so u:object_r:same_process_hal_file:s0 >> ./rom/images/config/vendor_file_contexts
echo /vendor/lib/libq3dtools_adreno.so u:object_r:same_process_hal_file:s0 >> ./rom/images/config/vendor_file_contexts
echo /vendor/lib/libllvm-qgl.so u:object_r:same_process_hal_file:s0 >> ./rom/images/config/vendor_file_contexts
echo /vendor/lib/libllvm-glnext.so u:object_r:same_process_hal_file:s0 >> ./rom/images/config/vendor_file_contexts
echo /vendor/lib/libllvm-qcom.so u:object_r:same_process_hal_file:s0 >> ./rom/images/config/vendor_file_contexts
echo /vendor/lib/hw/vulkan.adreno.so u:object_r:same_process_hal_file:s0 >> ./rom/images/config/vendor_file_contexts
echo /vendor/lib/egl/ u:object_r:same_process_hal_file:s0 >> ./rom/images/config/vendor_file_contexts
echo /vendor/lib64/ u:object_r:same_process_hal_file:s0 >> ./rom/images/config/vendor_file_contexts
echo /vendor/lib/libVkLayer_ADRENO_qprofiler.so u:object_r:same_process_hal_file:s0 >> ./rom/images/config/vendor_file_contexts
echo /vendor/lib64/libVkLayer_ADRENO_qprofiler.so u:object_r:same_process_hal_file:s0 >> ./rom/images/config/vendor_file_contexts
echo /vendor/lib64/libEGL_adreno.so u:object_r:same_process_hal_file:s0 >> ./rom/images/config/vendor_file_contexts
echo /vendor/lib64/libGLESv2_adreno.so u:object_r:same_process_hal_file:s0 >> ./rom/images/config/vendor_file_contexts
echo /vendor/lib64/libadreno_app_profiles.so u:object_r:same_process_hal_file:s0 >> ./rom/images/config/vendor_file_contexts
echo /vendor/lib64/libq3dtools_adreno.so u:object_r:same_process_hal_file:s0 >> ./rom/images/config/vendor_file_contexts
echo /vendor/lib64/hw/vulkan.adreno.so u:object_r:same_process_hal_file:s0 >> ./rom/images/config/vendor_file_contexts
echo /vendor/lib64/libllvm-qgl.so u:object_r:same_process_hal_file:s0 >> ./rom/images/config/vendor_file_contexts
echo /vendor/lib64/libllvm-glnext.so u:object_r:same_process_hal_file:s0 >> ./rom/images/config/vendor_file_contexts
echo /vendor/lib64/libllvm-qcom.so u:object_r:same_process_hal_file:s0 >> ./rom/images/config/vendor_file_contexts
echo /vendor/lib64/egl/ u:object_r:same_process_hal_file:s0 >> ./rom/images/config/vendor_file_contexts
echo /vendor/lib64/libdmabufheap.so u:object_r:same_process_hal_file:s0 >> ./rom/images/config/vendor_file_contexts
echo /vendor/lib/libdmabufheap.so u:object_r:same_process_hal_file:s0 >> ./rom/images/config/vendor_file_contexts
echo /vendor/lib64/libCB.so u:object_r:same_process_hal_file:s0 >> ./rom/images/config/vendor_file_contexts
echo /vendor/lib64/notgsl.so u:object_r:same_process_hal_file:s0 >> ./rom/images/config/vendor_file_contexts
echo /vendor/lib64/libadreno_utils.so u:object_r:same_process_hal_file:s0 >> ./rom/images/config/vendor_file_contexts
###
mkdir -p tmp
cd tmp
axel -n $(nproc) https://github.com/VPT-bit/Patch_China_Rom_Haydn/releases/download/alpha/free_744.12_A660__Magisk.zip > /dev/null 2>&1
unzip free_744.12_A660__Magisk.zip > /dev/null 2>&1
cd $work_dir
cp -rf tmp/system/vendor/* ./rom/images/vendor > /dev/null 2>&1
rm -rf tmp/*
green "Add GPU Driver Successfully"

# add leica camera
blue "Installing Leica Camera..."
cd tmp
axel -n $(nproc) https://github.com/VPT-bit/Patch_China_Rom_Haydn/releases/download/alpha/HolyBearMiuiCamera.apk > /dev/null 2>&1
mv HolyBearMiuiCamera.apk MiuiCamera.apk > /dev/null 2>&1
cd ${work_dir}
mv -v tmp/MiuiCamera.apk ./rom/images/product/priv-app/MiuiCamera > /dev/null 2>&1
rm -rf tmp/*
green "Add Leica Camera Successfully"

# add launcher mod
mv -v patch_rom/product/priv-app/MiuiHomeT/MiuiHomeT.apk ./rom/images/product/priv-app/MiuiHomeT > /dev/null 2>&1
mv -v patch_rom/product/etc/permissions/privapp_whitelist_com.miui.home.xml ./rom/images/product/etc/permissions > /dev/null 2>&1
mv -v patch_rom/system/system/etc/permissions/privapp_whitelist_com.miui.home.xml ./rom/images/system/system/etc/permissions > /dev/null 2>&1
mv -v patch_rom/product/overlay/MiuiPocoLauncherResOverlay.apk ./rom/images/product/overlay > /dev/null 2>&1
green "Add Launcher Mod Successfully"

# add xiaomi.eu extension
mkdir -p ./rom/images/product/priv-app/XiaomiEuExt > /dev/null 2>&1
mv -v patch_rom/product/priv-app/XiaomiEuExt/XiaomiEuExt.apk ./rom/images/product/priv-app/XiaomiEuExt > /dev/null 2>&1
mv -v patch_rom/product/etc/permissions/privapp_whitelist_eu.xiaomi.ext.xml ./rom/images/product/etc/permissions > /dev/null 2>&1
green "Add XiaomiEuExt Successfully"

# patch performance
mv -v patch_rom/product/pangu/system/app/Joyose/Joyose.apk ./rom/images/product/pangu/system/app/Joyose > /dev/null 2>&1
mv -v patch_rom/system/system/app/PowerKeeper/PowerKeeper.apk ./rom/images/system/system/app/PowerKeeper > /dev/null 2>&1
green "Patch Performance Successfully"

# add overlay
blue "Building the Overlay..."
git clone https://github.com/VPT-bit/overlay.git > /dev/null 2>&1
cd overlay
sudo chmod +x build.sh > /dev/null 2>&1
./build.sh > /dev/null 2>&1
cd ${work_dir}
mv -v overlay/output/* ./rom/images/product/overlay > /dev/null 2>&1
rm -rf overlay
green "Overlay Build Has Been Completed"

# disable apk protection
blue "Disabling Apk Protection"
cd ${work_dir}
mkdir -p tmp/services/
cp -rf ./rom/images/system/system/framework/services.jar tmp/services/services.jar

7z x -y tmp/services/services.jar *.dex -o tmp/services > /dev/null 2>&1
target_method='getMinimumSignatureSchemeVersionForTargetSdk' 
for dexfile in tmp/services/*.dex;do
    smali_fname=${dexfile%.*}
    smali_base_folder=$(echo $smali_fname | cut -d "/" -f 3)
    java -jar bin/apktool/baksmali.jar d --api "30" ${dexfile} -o tmp/services/$smali_base_folder
done

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
    { sed -i "${orginal_line_number},${move_result_end_line}d" "$smali_file" && sed -i "${orginal_line_number}i\\${replace_with_command}" "$smali_file"; } &&    blue "${smali_file}  Successfully Modified"
    old_smali_dir=$smali_dir
done < <(find tmp/services -type f -name "*.smali" -exec grep -H "$target_method" {} \; | cut -d ':' -f 1)

for smali_dir in "${smali_dirs[@]}"; do
    blue "Decompilation is successful, start back compilation $smali_dir"
    java -jar bin/apktool/smali.jar a --api "30" tmp/services/${smali_dir} -o tmp/services/${smali_dir}.dex
    pushd tmp/services/ > /dev/null 2>&1
    7z a -y -mx0 -tzip services.jar ${smali_dir}.dex > /dev/null 2>&1
    popd > /dev/null 2>&1
done
cd ${work_dir}
cp -rf tmp/services/services.jar ./rom/images/system/system/framework/services.jar
green "Disabling APK Protection Is Complete"


# patch .prop and .xml
cd $work_dir
# product .prop
echo "ro.miui.cust_erofs=0" >> ./rom/images/product/etc/build.prop
sed -i 's/<item>120<\/item>/<item>120<\/item>\n\t\t<item>90<\/item>/g' ./rom/images/product/etc/device_features/haydn.xml

# system .prop
echo debug.hwui.renderer=vulkan >> ./rom/images/system/system/build.prop
echo bhlnk.hypervs.overlay=true >> ./rom/images/system/system/build.prop

# vendor .prop
sed -i 's|ro\.hwui\.use_vulkan=|ro\.hwui\.use_vulkan=true|' ./rom/images/vendor/build.prop
echo "persist.vendor.mi_sf.optimize_for_refresh_rate.enable=1" >> ./rom/images/vendor/build.prop
echo "ro.vendor.mi_sf.ultimate.perf.support=true"  >> ./rom/images/vendor/build.prop
echo "ro.surface_flinger.use_content_detection_for_refresh_rate=false" >> ./rom/images/vendor/build.prop
echo "ro.surface_flinger.set_touch_timer_ms=0" >> ./rom/images/vendor/build.prop
echo "ro.surface_flinger.set_idle_timer_ms=0" >> ./rom/images/vendor/build.prop
green "Patching .prop and .xml completed"

# font
cd ${work_dir}
cd tmp
axel -n $(nproc) https://github.com/googlefonts/roboto-classic/releases/download/v3.009/Roboto_v3.009.zip > /dev/null 2>&1
unzip Roboto_v3.009.zip > /dev/null 2>&1
rm -rf Roboto_v3.009.zip 
mv -v android/Roboto[ital,wdth,wght].ttf android/MiSansVF.ttf > /dev/null 2>&1
cd ${work_dir}
mv -v tmp/android/MiSansVF.ttf system/system/fonts > /dev/null 2>&1
rm -rf tmp/*
green "Replace Font Successfully"

# debloat
cd ${work_dir}
cp -r ./rom/images/product/data-app/MIMediaEditor tmp > /dev/null 2>&1
cp -r ./rom/images/product/data-app/MIUICleanMaster tmp > /dev/null 2>&1
cp -r ./rom/images/product/data-app/MIUINotes tmp > /dev/null 2>&1
cp -r ./rom/images/product/data-app/MiuiScanner tmp > /dev/null 2>&1
cp -r ./rom/images/product/data-app/MIUIScreenRecorder tmp > /dev/null 2>&1
cp -r ./rom/images/product/data-app/MIUISoundRecorderTargetSdk30 tmp > /dev/null 2>&1
cp -r ./rom/images/product/data-app/MIUIWeather tmp > /dev/null 2>&1
cp -r ./rom/images/product/data-app/SmartHome tmp > /dev/null 2>&1
cp -r ./rom/images/product/data-app/ThirdAppAssistant tmp > /dev/null 2>&1
rm -rf ./rom/images/product/data-app/* > /dev/null 2>&1
rm -rf ./rom/images/product/app/AnalyticsCore > /dev/null 2>&1
rm -rf ./rom/images/product/app/MSA > /dev/null 2>&1
rm -rf ./rom/images/product/priv-app/MIUIBrowser > /dev/null 2>&1
rm -rf ./rom/images/product/priv-app/MIUIQuickSearchBox > /dev/null 2>&1
cp -r tmp/* ./rom/images/product/data-app > /dev/null 2>&1
rm -rf tmp/*
green "Debloat Completed"

# patch context and fsconfig
cd ${work_dir}
for pname in system product vendor; do
  python3 bin/contextpatch.py ./rom/images/${pname} ./rom/images/config/${pname}_file_contexts > /dev/null 2>&1
  python3 bin/fspatch.py ./rom/images/${pname} ./rom/images/config/${pname}_fs_config > /dev/null 2>&1
  green "Patching ${pname} contexts and fsconfig completed"
done
cd ./rom/images
for pname in system product vendor; do
  option=`sed -n '3p' ./config/${pname}_fs_options | cut -c28-`
  mkfs.erofs $option > /dev/null 2>&1
  rm -rf ${pname}
  mv ${pname}_repack.img ${pname}.img > /dev/null 2>&1
  green "Packaging ${pname} is complete"
done

# pack super
system_size=`stat -c '%n %s' system.img | cut -d ' ' -f 2`
system_ext_size=`stat -c '%n %s' system_ext.img | cut -d ' ' -f 2`
product_size=`stat -c '%n %s' product.img | cut -d ' ' -f 2`
vendor_size=`stat -c '%n %s' vendor.img | cut -d ' ' -f 2`
odm_size=`stat -c '%n %s' odm.img | cut -d ' ' -f 2`
mi_ext_size=`stat -c '%n %s' mi_ext.img | cut -d ' ' -f 2`
sum_size=`echo "$system_size + $system_ext_size + $product_size + $vendor_size + $odm_size + $mi_ext_size" | bc`
###
blue "Packing Super..."
command="--metadata-size 65536 --super-name super --metadata-slots 3 --device super:9126805504 --group qti_dynamic_partitions_a:$sum_size --partition product_a:readonly:$product_size:qti_dynamic_partitions_a --image product_a=./product.img --partition system_a:readonly:$system_size:qti_dynamic_partitions_a --image system_a=./system.img --partition system_ext_a:readonly:$system_ext_size:qti_dynamic_partitions_a --image system_ext_a=./system_ext.img --partition vendor_a:readonly:$vendor_size:qti_dynamic_partitions_a --image vendor_a=./vendor.img --partition odm_a:readonly:$odm_size:qti_dynamic_partitions_a --image odm_a=./odm.img --partition mi_ext_a:readonly:$mi_ext_size:qti_dynamic_partitions_a --image mi_ext_a=./mi_ext.img --group qti_dynamic_partitions_b:0 --partition product_b:readonly:0:qti_dynamic_partitions_b --partition system_b:readonly:0:qti_dynamic_partitions_b --partition system_ext_b:readonly:0:qti_dynamic_partitions_b --partition vendor_b:readonly:0:qti_dynamic_partitions_b --partition odm_b:readonly:0:qti_dynamic_partitions_b --partition mi_ext_b:readonly:0:qti_dynamic_partitions_b --virtual-ab --sparse --output ./super"
./lpmake $command
if test ./super; then
   green "Super Has Been Packaged"
fi
###
blue "Super Is Being Compressed"
zstd --rm ./super -o ./super.zst > /dev/null 2>&1
if test ./super.zst; then
  green "Super Has Been Compressed"
for part in product system system_ext vendor odm mi_ext
do
  rm -rf $part.img
done

# cleanup
cd ${work_dir}
blue "Packing and Cleaning Up..."
rm rom/images/cc
cd rom
zip -r haydn_rom.zip *
cd ${work_dir}
mv -v rom/haydn_rom.zip .
rm -rf rom
green "Done, Prepare to Upload...'

