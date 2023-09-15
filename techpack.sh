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
        git fetch https://git.codelinaro.org/clo/la/platform/vendor/opensource/audio-kernel $tag
        git merge -X subtree=techpack/audio FETCH_HEAD
    else
        git subtree add --prefix=techpack/audio https://git.codelinaro.org/clo/la/platform/vendor/opensource/audio-kernel $tag
    fi
else
    echo " Skipped audio-kernel"
fi

read -p " Wanna import data-kernel? ( y or n ): " ans2
if [ $ans2 = "y" ]; then
    if [ -d techpack/data ]; then
        git fetch https://git.codelinaro.org/clo/la/platform/vendor/qcom-opensource/data-kernel $tag
        git merge -X subtree=techpack/data FETCH_HEAD
    else
        git subtree add --prefix=techpack/data https://git.codelinaro.org/clo/la/platform/vendor/qcom-opensource/data-kernel $tag
    fi
else
    echo " Skipped data-kernel"
fi

read -p " Wanna import camera-kernel? ( y or n ): " ans3
if [ $ans3 = "y" ]; then
    if [ -d techpack/camera ]; then
        git fetch https://git.codelinaro.org/clo/la/platform/vendor/opensource/camera-kernel/ $tag
        git merge -X subtree=techpack/camera FETCH_HEAD
    else
        git subtree add --prefix=techpack/camera https://git.codelinaro.org/clo/la/platform/vendor/opensource/camera-kernel/ $tag
    fi
else
    echo " Skipped camera-kernel"
fi

read -p " Wanna import display-drivers? ( y or n ): " ans4
if [ $ans4 = "y" ]; then
    if [ -d techpack/display ]; then
        git fetch https://git.codelinaro.org/clo/la/platform/vendor/opensource/display-drivers/ $tag
        git merge -X subtree=techpack/display FETCH_HEAD
    else
        git subtree add --prefix=techpack/display https://git.codelinaro.org/clo/la/platform/vendor/opensource/display-drivers/ $tag
    fi
else
    echo " Skipped display-drivers"
fi

read -p " Wanna import video-driver? ( y or n ): " ans5
if [ $ans5 = "y" ]; then
    if [ -d techpack/video ]; then
        git fetch https://git.codelinaro.org/clo/la/platform/vendor/opensource/video-driver/ $tag
        git merge -X subtree=techpack/video FETCH_HEAD
    else
        git subtree add --prefix=techpack/video https://git.codelinaro.org/clo/la/platform/vendor/opensource/video-driver/ $tag
    fi
else
    echo " Skipped video-driver"
fi

echo "Done."

