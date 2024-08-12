#!/bin/bash
#
# Import or Update Kernel Drivers
# By SpiDyNub
#

HOME_DIR="$(pwd)"
GITHUB=https://github.com
CLO_REPO=https://git.codelinaro.org/clo/la/platform/vendor

read -p "Please Input the CLO Tag: " CLO_TAG

IMPORT () {
	DIR=$1
	REPO=$2
	if [ $3 = "-b" ]; then
		TAG=$4
	else
		TAG=$CLO_TAG
	fi
	if [ -d $DIR ]; then
		git fetch $REPO $TAG
		git merge -X subtree="$DIR" FETCH_HEAD
	else
		git subtree add --prefix="$DIR" $REPO $TAG
	fi
}

IMPORT_TP () {
	read -p "Wanna Import or Update $1 ? [Y/N]: " TP
	if [ $TP = "y" -o $TP = "Y" ]; then
		IMPORT $1 $2 $CLO_TAG
	else
		echo -e "Skipped $1"
	fi
}

read -p "Wanna Import DTS for SDM660? [Y/N]: " DTS
if [ $DTS = "y" -o $DTS = "Y" ]; then
	IMPORT arch/arm64/boot/dts/vendor $GITHUB/cty-android/android_kernel_qcom_devicetree -b LA.UM.9.12
fi

read -p "Wanna Import or update qcacld-3.0, qca-wifi-host-cmn, fw-api? [Y/N]: " WLAN
if [ $WLAN = "y" -o $WLAN = "Y" ]; then
	IMPORT drivers/staging/qca-wifi-host-cmn-legacy $CLO_REPO/qcom-opensource/wlan/qca-wifi-host-cmn $CLO_TAG
	IMPORT drivers/staging/qcacld-3.0-legacy $CLO_REPO/qcom-opensource/wlan/qcacld-3.0 $CLO_TAG
	IMPORT drivers/staging/fw-api-legacy $CLO_REPO/qcom-opensource/wlan/fw-api $CLO_TAG
fi

read -p "Wanna Import or update techpack drivers? [Y/N]: " TECH
if [ $TECH = "y" -o $TECH = "Y" ]; then
        IMPORT_TP techpack/audio $CLO_REPO/opensource/audio-kernel
        IMPORT_TP techpack/data $CLO_REPO/qcom-opensource/data-kernel
        IMPORT_TP techpack/camera $CLO_REPO/opensource/camera-kernel
        IMPORT_TP techpack/display $CLO_REPO/opensource/display-drivers
        IMPORT_TP techpack/video $CLO_REPO/opensource/video-driver
fi

read -p "Wanna Import or update exfat drivers? [Y/N]: " EXFAT
if [ $EXFAT = "y" -o $EXFAT = "Y" ]; then
	IMPORT fs/exfat $GITHUB/namjaejeon/linux-exfat-oot -b for-kernel-version-from-4.1.0
else
	echo -e "Skipped Exfat drivers"
fi
