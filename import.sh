#!/bin/bash
#
# Import or update qcacld-3.0, qca-wifi-host-cmn, fw-api and exfat
#

kt_dir="$(pwd)"
Link=https://git.codelinaro.org/clo/la/platform/vendor/qcom-opensource/wlan

read -p "Please input the tag name: " tag

read -p "Wanna Import or update qcacld-3.0, qca-wifi-host-cmn, fw-api? ( y or n ): "  ans
if [ $ans = "y" ]; then
if [ -d drivers/staging/qcacld-3.0 ]; then
git subtree pull --prefix=drivers/staging/qcacld-3.0 $Link/qcacld-3.0 $tag
else
git subtree add --prefix=drivers/staging/qcacld-3.0 $Link/qcacld-3.0 $tag
fi

if [ -d drivers/staging/qca-wifi-host-cmn ]; then
git subtree pull --prefix=drivers/staging/qca-wifi-host-cmn $Link/qca-wifi-host-cmn $tag
else
git subtree add --prefix=drivers/staging/qca-wifi-host-cmn $Link/qca-wifi-host-cmn $tag
fi

if [ -d drivers/staging/fw-api ]; then
git subtree pull --prefix=drivers/staging/fw-api $Link/fw-api $tag
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
git subtree add --prefix=fs/exfat https://github.com/arter97/exfat-linux old
else
git subtree add --prefix=fs/exfat https://github.com/arter97/exfat-linux master
fi
else
echo " Skipped Exfat Driver"
fi

rm -rf $kt_dir/import

echo "Done."
