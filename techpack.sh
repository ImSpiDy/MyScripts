#!/bin/bash
#
# Kanged by ImSpiDy
# Import or update techpack drivers
#

kt_dir="$(pwd)"

read -p "Please input the tag name: " tag

read -p " Wanna import audio-kernel? ( y or n ): " ans1
if [ $ans1 = "y" ]; then
    if [ -d techpack/audio ]; then
        git subtree pull --prefix=techpack/audio https://git.codelinaro.org/clo/la/platform/vendor/opensource/audio-kernel $tag
    else
        git subtree add --prefix=techpack/audio https://git.codelinaro.org/clo/la/platform/vendor/opensource/audio-kernel $tag
    fi
else
    echo " Skipped audio-kernel"
fi

read -p " Wanna import data-kernel? ( y or n ): " ans2
if [ $ans2 = "y" ]; then
    if [ -d techpack/data ]; then
        git subtree pull --prefix=techpack/data https://git.codelinaro.org/clo/la/platform/vendor/qcom-opensource/data-kernel $tag
    else
        git subtree add --prefix=techpack/data https://git.codelinaro.org/clo/la/platform/vendor/qcom-opensource/data-kernel $tag
    fi
else
    echo " Skipped data-kernel"
fi

read -p " Wanna import camera-kernel? ( y or n ): " ans3
if [ $ans3 = "y" ]; then
    if [ -d techpack/camera ]; then
        git subtree pull --prefix=techpack/camera https://git.codelinaro.org/clo/la/platform/vendor/opensource/camera-kernel/ $tag
    else
        git subtree add --prefix=techpack/camera https://git.codelinaro.org/clo/la/platform/vendor/opensource/camera-kernel/ $tag
    fi
else
    echo " Skipped camera-kernel"
fi

read -p " Wanna import display-drivers? ( y or n ): " ans4
if [ $ans4 = "y" ]; then
    if [ -d techpack/display ]; then
        git subtree pull --prefix=techpack/display https://git.codelinaro.org/clo/la/platform/vendor/opensource/display-drivers/ $tag
    else
        git subtree add --prefix=techpack/display https://git.codelinaro.org/clo/la/platform/vendor/opensource/display-drivers/ $tag
    fi
else
    echo " Skipped display-drivers"
fi

read -p " Wanna import video-driver? ( y or n ): " ans5
if [ $ans5 = "y" ]; then
    if [ -d techpack/video ]; then
        git subtree pull --prefix=techpack/video https://git.codelinaro.org/clo/la/platform/vendor/opensource/video-driver/ $tag
    else
        git subtree add --prefix=techpack/video https://git.codelinaro.org/clo/la/platform/vendor/opensource/video-driver/ $tag
    fi
else
    echo " Skipped video-driver"
fi

echo "Done."

