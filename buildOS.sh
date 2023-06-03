#!/bin/bash

pkg () {
apt install -y lld git-lfs
}

sync () {
# Sync source
repo init --depth=1 --no-repo-verify -u https://github.com/crdroidandroid/android -b 11.0 --git-lfs

# Sync source without unnecessary messages, try with -j30 first, if fails, it will try again
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j10 || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j10

# tree
git clone --depth=1 https://github.com/ImSpiDy/device_xiaomi_lavender device/xiaomi/lavender -b R
git clone --depth=1 https://github.com/ImSpiDy/vendor_xiaomi_lavender vendor/xiaomi/lavender -b R
git clone --depth=1 https://github.com/ImSpiDy/kernel_xiaomi_lavender kernel/xiaomi/lavender -b X5.1

# extra stuff
#git clone --depth=1 https://github.com/LineageOS/android_hardware_lineage_livedisplay hardware/lineage/livedisplay -b lineage-17.1
#git clone --depth=1 https://github.com/Nub-XD/android_packages_apps_Dirac packages/apps/Dirac -b 10
#git clone --depth=1 https://github.com/Nub-XD/platform_vendor_lawnchair vendor/lawnchair -b 10
git clone --depth=1 https://gitlab.com/Project-Nexus/nexus-clang.git prebuilts/clang/host/linux-x86/nexus-clang -b nexus-14

# soc hals
#rm -rf hardware/qcom-caf/msm8998/display
#rm -rf hardware/qcom-caf/msm8998/audio
#rm -rf hardware/qcom-caf/msm8998/media
#git clone --depth=1 https://github.com/NusantaraProject-ROM/android_hardware_qcom_display hardware/qcom-caf/msm8998/display -b 10-msm8998
#git clone --depth=1 https://github.com/NusantaraProject-ROM/android_hardware_qcom_audio hardware/qcom-caf/msm8998/audio -b 10-msm8998
#git clone --depth=1 https://github.com/NusantaraProject-ROM/android_hardware_qcom_media hardware/qcom-caf/msm8998/media -b 10-msm8998

}

setup () {
. b*/e*.sh
lunch lineage_lavender-userdebug
export TZ=Asia/Kolkata
export SELINUX_IGNORE_NEVERALLOWS=true
export WITH_GMS=true
}

cache () {
wget https://emy.ehteshammalik4.workers.dev/cirrus-user/Prashant-1695/lavender/crdroidandroid/11.0/ccache.tar.gz
tar xf *.tar.gz
rm -rf *.tar.gz
export CCACHE_DIR=~/rr/ccache
export CCACHE_EXEC=$(which ccache)
export USE_CCACHE=1
ccache -M 15G
ccache -o compression=true
ccache -z
}

build () {
mka bacon
}

upload () {
cd out/target/product/lavender/
[ -e *-eng*.zip ] && rm -rf *-eng*.zip
[ -e *-ota-*.zip ] && rm -rf *-ota-*.zip
[ -e *.zip ] && curl -T *.zip temp.sh
}

pkg
sync
setup
cache
build
upload
