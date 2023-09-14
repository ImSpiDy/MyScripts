#!/bin/bash
#
# Import or update qcacld-3.0, qca-wifi-host-cmn, fw-api and exfat
# By SpiDyNub
#

kt_dir="$(pwd)"
Link=https://git.codelinaro.org/clo/la/platform/vendor/qcom-opensource/wlan

read -p "Please input the tag name: " tag

read -p "Wanna Import or update qcacld-3.0, qca-wifi-host-cmn, fw-api? ( y or n ): "  ans
if [ $ans = "y" ]; then
    if [ -d drivers/staging/qcacld-3.0 ]; then
        git fetch $Link/qcacld-3.0 $tag
        git merge -X subtree=drivers/staging/qcacld-3.0 FETCH_HEAD
    else
        git subtree add --prefix=drivers/staging/qcacld-3.0 $Link/qcacld-3.0 $tag
    fi

    if [ -d drivers/staging/qca-wifi-host-cmn ]; then
        git fetch $Link/qca-wifi-host-cmn $tag
        git merge -X subtree=drivers/staging/qca-wifi-host-cmn FETCH_HEAD
    else
        git subtree add --prefix=drivers/staging/qca-wifi-host-cmn $Link/qca-wifi-host-cmn $tag
    fi

    if [ -d drivers/staging/fw-api ]; then
        git fetch $Link/fw-api $tag
        git merge -X subtree=drivers/staging/fw-api FETCH_HEAD
    else
        git subtree add --prefix=drivers/staging/fw-api $Link/fw-api $tag
    fi
else
    echo " Skipped qcacld-3.0, qca-wifi-host-cmn, fw-api"
fi

read -p " Wanna import Exfat? ( y or n ): " ans1
if [ $ans1 = "y" ]; then
    read -p " Linux Version is 4.4 or Below 4.4 ? ( y or n ): " ans2
    if [ $ans2 = "y" ]; then
        K=old
    else
        K=master
    fi
    if [ -d fs/exfat ]; then
        git fetch https://github.com/arter97/exfat-linux $K
        git merge -X subtree=fs/exfat FETCH_HEAD
    else
        git subtree add --prefix=fs/exfat https://github.com/arter97/exfat-linux $K
    fi
else
    echo " Skipped Exfat Driver"
fi

echo "Done."
