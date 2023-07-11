#!/bin/bash

mkdir -p leaf

pkg () {
apt install -y lld git-lfs
}

sync () {
cd /leaf

repo init --depth=1 --no-repo-verify -u https://github.com/LeafOS-Project/android.git -b leaf-2.0 -g default,-mips,-darwin,-notdefault

# Sync source without unnecessary messages, try with -j30 first, if fails, it will try again
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j10 || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j10

# device stuff
git clone --depth=1 https://github.com/ImSpiDy/device_xiaomi_lavender device/xiaomi/lavender -b A13
git clone --depth=1 https://github.com/ImSpiDy/vendor_xiaomi_lavender vendor/xiaomi/lavender -b TF
git clone --depth=1 https://github.com/ImSpiDy/kernel_xiaomi_lavender kernel/xiaomi/lavender -b X7-Qti

#hals
rm -rf hardware/qcom-caf/msm8998/audio hardware/qcom-caf/msm8998/media hardware/qcom-caf/msm8998/display
git clone --depth=1 https://github.com/wHo-EM-i/android_hardware_qcom_audio hardware/qcom-caf/msm8998/audio -b 8998-4.4
git clone --depth=1 https://github.com/wHo-EM-i/android_hardware_qcom_display hardware/qcom-caf/msm8998/display -b 8998-4.4
git clone --depth=1 https://github.com/wHo-EM-i/android_hardware_qcom_media hardware/qcom-caf/msm8998/media -b 8998-4.4

# nex clang
git clone --depth=1 https://gitlab.com/Project-Nexus/nexus-clang.git /prebuilts/clang/host/linux-x86/nexus-clang -b nexus-14

cd /bionic
curl https://github.com/wHo-EM-i/bionic/commit/e8b68f026fb0d6ce13351c55695a6d6cf2742dff.patch | git am
curl https://github.com/wHo-EM-i/bionic/commit/8bfccafe0a7c5d2584ce0aa414c846a13caee07b.patch | git am
curl https://github.com/wHo-EM-i/bionic/commit/6db6121472c45316bc6135f05da38227fdc9962e.patch | git am

# patch
cd /system/libhidl && curl https://github.com/ArrowOS/android_system_libhidl/commit/fbdf10a33f546d202ae12b4b864177fea9faa998.patch | git am
}

setup () {
cd /leaf
. b*/e*.sh
lunch lavender-userdebug
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
m leaf
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
#cache
build
upload
