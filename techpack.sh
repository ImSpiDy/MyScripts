#!/bin/bash
#
# Kanged by ImSpiDy
# Import or update techpack drivers
#

kt_dir="$(pwd)"

read -p "Please input the tag name: " tag

read -p " Wanna import audio-kernel? ( y or n ): " ans1
if [ $ans1 = "y" ]; then
git subtree add --prefix=techpack/audio https://git.codelinaro.org/clo/la/platform/vendor/opensource/audio-kernel $tag
else
echo " Skipped audio-kernel"
fi

read -p " Wanna import data-kernel? ( y or n ): " ans2
if [ $ans2 = "y" ]; then
git subtree add --prefix=techpack/data https://git.codelinaro.org/clo/la/platform/vendor/qcom-opensource/data-kernel $tag
else
echo " Skipped data-kernel"
fi

rm -rf $kt_dir/import

echo "Done."

