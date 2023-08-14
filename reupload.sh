#!/usr/bin/env bash
#
# reupload file on pixel drain with help of circleci

# Remove 0 and enter your file link
URL=0

if [ $URL == 0 ]; then
exit 0
fi

wget $URL

FileName="$(basename $URL)"

wget https://github.com/ManuelReschke/go-pd/releases/download/v1.4.0/go-pd_1.4.0_linux_amd64.tar.gz

tar -xf go-pd*

./go-pd upload $FileName
