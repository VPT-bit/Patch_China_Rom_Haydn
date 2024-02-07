@echo off
if exist bin\platform-tools-windows\fastboot.exe PATH=%PATH%;bin\platform-tools-windows
setlocal enabledelayedexpansion
title HyperOS line brush script [Do not select the window, otherwise you deserve to be stuck. If you are stuck, press the right button or press Enter or zoom in and out to recover]
echo.
echo.Notes on flashing:
echo.The data needs to be cleared when flashing HyperOS for the first time.
echo.If packets of decrypted data and non-decrypted data are flushed each other, the data needs to be cleared.
echo.
zstd --rm -d images/super.zst -o images/super.img
echo.
set /p wipeData="Do you need to clear data? (y/n)"
echo.
echo. Please do not move around during the flashing process. Please pay attention to the title.
echo.

if exist images\boot_magisk.img (
	echo.
	set /p rootOrNot="Do you need ROOT?£¨y/n£©"
	if /i "!rootOrNot!" == "y" (
		fastboot flash boot_a images/boot_magisk.img
		fastboot flash boot_b images/boot_magisk.img
	) else (
		fastboot flash boot_a images/boot_official.img
		fastboot flash boot_b images/boot_official.img
	)
) else (
	fastboot flash boot_a images/boot_official.img
	fastboot flash boot_b images/boot_official.img
)

if exist images\boot_apatch.img (
	echo.
	set /p twrpOrNot="Do you need Apatch and TWRP?£¨y/n£©"
	if /i "!twrpOrNot!" == "y" (
		fastboot flash boot_a images/boot_apatch.img
		fastboot flash boot_b images/boot_apatch.img
	)
)

rem
fastboot flash xbl_config_a images/xbl_config.img
fastboot flash xbl_config_b images/xbl_config.img
fastboot flash xbl_a images/xbl.img
fastboot flash xbl_b images/xbl.img
fastboot flash vendor_boot_a images/vendor_boot.img
fastboot flash vendor_boot_b images/vendor_boot.img
fastboot --disable-verity --disable-verification flash vbmeta_system_a images/vbmeta_system.img
fastboot --disable-verity --disable-verification flash vbmeta_system_b images/vbmeta_system.img
fastboot --disable-verity --disable-verification flash vbmeta_a images/vbmeta.img
fastboot --disable-verity --disable-verification flash vbmeta_b images/vbmeta.img
fastboot flash uefisecapp_a images/uefisecapp.img
fastboot flash uefisecapp_b images/uefisecapp.img
fastboot flash tz_a images/tz.img
fastboot flash tz_b images/tz.img
fastboot flash shrm_a images/shrm.img
fastboot flash shrm_b images/shrm.img
fastboot flash qupfw_a images/qupfw.img
fastboot flash qupfw_b images/qupfw.img
fastboot flash modem_a images/modem.img
fastboot flash modem_b images/modem.img
fastboot flash keymaster_a images/keymaster.img
fastboot flash keymaster_b images/keymaster.img
fastboot flash imagefv_a images/imagefv.img
fastboot flash imagefv_b images/imagefv.img
fastboot flash hyp_a images/hyp.img
fastboot flash hyp_b images/hyp.img
fastboot flash featenabler_a images/featenabler.img
fastboot flash featenabler_b images/featenabler.img
fastboot flash dtbo_a images/dtbo.img
fastboot flash dtbo_b images/dtbo.img
fastboot flash dsp_a images/dsp.img
fastboot flash dsp_b images/dsp.img
fastboot flash devcfg_a images/devcfg.img
fastboot flash devcfg_b images/devcfg.img
fastboot flash cpucp_a images/cpucp.img
fastboot flash cpucp_b images/cpucp.img
fastboot flash bluetooth_a images/bluetooth.img
fastboot flash bluetooth_b images/bluetooth.img
fastboot flash aop_a images/aop.img
fastboot flash aop_b images/aop.img
fastboot flash abl_a images/abl.img
fastboot flash abl_b images/abl.img


if exist images\preloader_raw.img (
	fastboot flash preloader_a images/preloader_raw.img 1>nul 2>nul
	fastboot flash preloader_b images/preloader_raw.img 1>nul 2>nul
	fastboot flash preloader1 images/preloader_raw.img 1>nul 2>nul
	fastboot flash preloader2 images/preloader_raw.img 1>nul 2>nul
)

if exist images\cust.img fastboot flash cust images/cust.img
echo.
echo.
echo. If invalid sparse file format at header magic is displayed, it is normal and not an error.
echo. If invalid sparse file format at header magic is displayed, it is normal and not an error.
echo.
echo. Please wait patiently. How long it takes to be stuck here depends on the performance of your computer. You can also look at the title.
echo. Please wait patiently. How long it takes to be stuck here depends on the performance of your computer. You can also look at the title.
echo.
echo.
if exist images\super.img fastboot flash super images/super.img
echo.
echo.
echo. After flashing super, it may be stuck for a while. Please wait patiently and do not restart by yourself, otherwise it may not boot and need to be flashed again.
echo.
echo. If there is no response for a long time, please try to turn it on manually or flash it again.
echo.
echo.

if /i "!wipeData!" == "y" (
	fastboot erase userdata
	fastboot erase metadata
)
fastboot set_active a
fastboot reboot

pause
