#!/usr/bin/env bash
#
# reupload file on pixel drain

wget https://github.com/ChemicalHaxard/BuildOS/releases/download/crdroidandroid/crDroidAndroid-11.0-CORE-20230813-lavender-v7.33.zip

wget https://github.com/ManuelReschke/go-pd/releases/download/v1.4.0/go-pd_1.4.0_linux_amd64.tar.gz

tar -xf go-pd*

./go-pd upload cr*
