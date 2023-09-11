#!/bin/bash

pkg () {
apt install -y lld git-lfs
}

sync () {
# Sync source
repo init --depth=1 --no-repo-verify -u https://github.com/DerpFest-AOSP/manifest.git -b 13 --git-lfs -g default,-mips,-darwin,-notdefault

# Sync source without unnecessary messages, try with -j30 first, if fails, it will try again
repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j24 || repo sync -c --no-clone-bundle --no-tags --optimized-fetch --prune --force-sync -j12

# tree
git clone --depth=1 https://github.com/ImSpiDy/device_xiaomi_lavender device/xiaomi/lavender -b 13X
git clone --depth=1 https://github.com/wHo-EM-i/vendor_lavender vendor/xiaomi/lavender -b 13
git clone --depth=1 https://github.com/wHo-EM-i/device_xiaomi_sdm660-common device/xiaomi/sdm660-common -b 13
git clone --depth=1 https://github.com/wHo-EM-i/vendor_xiaomi_sdm660-common vendor/xiaomi/sdm660-common -b 13

git clone --depth=1 https://github.com/ImSpiDy/kernel_xiaomi_lavender-4.19 kernel/xiaomi/sdm660 -b 13-Retro

rm -rf hardware/xiaomi
git clone --depth=1 https://github.com/arrowos-devices/android_hardware_xiaomi hardware/xiaomi -b arrow-13.1

rm -rf device/qcom/sepolicy-legacy-um
git clone --depth=1 https://github.com/ArrowOS/android_device_qcom_sepolicy-legacy-um device/qcom/sepolicy-legacy-um -b arrow-13.1

#rm -rf device/xiaomi/lavender/libhidl
rm -rf hardware/xiaomi/megvii/*.bp

# clang 17
git clone --depth=1 https://gitlab.com/crdroidandroid/android_prebuilts_clang_host_linux-x86_clang-r498229 prebuilts/clang/host/linux-x86/aosp-clang

#hals
sed -i 's|QCOM_HARDWARE_VARIANT := msm8998|QCOM_HARDWARE_VARIANT := sdm660|' vendor/*/config/B*Qcom.mk
rm -rf hardware/qcom-caf/sdm660/audio hardware/qcom-caf/sdm660/media hardware/qcom-caf/sdm660/display
git clone --depth=1 https://github.com/wHo-EM-i/android_hardware_qcom_audio hardware/qcom-caf/sdm660/audio -b 13-caf-sdm660
git clone --depth=1 https://github.com/wHo-EM-i/android_hardware_qcom_display hardware/qcom-caf/sdm660/display -b 13-caf_4.19
git clone --depth=1 https://github.com/wHo-EM-i/android_hardware_qcom_media hardware/qcom-caf/sdm660/media -b 13-caf-sdm660

# patch
#rm -rf bionic
#git clone --depth=1 https://github.com/wHo-EM-i/bionic -b los20
cd bionic
curl https://github.com/wHo-EM-i/bionic/commit/9e3a6c972f82910d2ae0faf56b8db3a0c2bd83a6.patch | git am #revert lib for jemalloc
curl https://github.com/wHo-EM-i/bionic/commit/2a8b590dfe23620be18a535420af6a5f7ebaae16.patch | git am #jemalloc
curl https://github.com/wHo-EM-i/bionic/commit/e8b68f026fb0d6ce13351c55695a6d6cf2742dff.patch | git am
curl https://github.com/wHo-EM-i/bionic/commit/8bfccafe0a7c5d2584ce0aa414c846a13caee07b.patch | git am
curl https://github.com/wHo-EM-i/bionic/commit/6db6121472c45316bc6135f05da38227fdc9962e.patch | git am
}

setup () {
. b*/e*.sh
lunch derp_lavender-userdebug
export TZ=Asia/Kolkata
export SELINUX_IGNORE_NEVERALLOWS=true
export RELAX_USES_LIBRARY_CHECK=true
export USE_GAPPS=true
export WITH_GMS=true
export WITH_GAPPS=true
export TARGET_USES_MINI_GAPPS=true
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
mka derp -j48
}

upload () {
cd out/target/product/lavender/
[ -e *-eng*.zip ] && rm -rf *-eng*.zip
[ -e *-ota-*.zip ] && rm -rf *-ota-*.zip
[ -e *.zip ] && curl -T *.zip temp.sh
REL=https://github.com/ImSpiDy/build-release
gh release create ROM-REL --generate-notes --repo $REL
gh release upload --clobber ROM-REL *.zip --repo $REL
}

pkg
sync
setup
#cache
build
upload
