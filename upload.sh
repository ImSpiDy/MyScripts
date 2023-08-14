#!/usr/bin/env bash
#
# Upload Files
#

echo " "
echo -e "github release = 1 | devuploads = 2"
echo -e "pixeldrain = 3 | temp.sh = 4"
read -p "Please enter your number: " UP
read -p "Please enter file path/name: " FP

if [ $UP == 1 ]; then
read -p "Please enter github repo link: " GH
FN="$(basename $FP)" && FN="${FN%%.*}"
echo -e "Started uploading file on github..."
gh release create $FN --generate-notes --repo $GH
gh release upload --clobber $FN $FP --repo $GH
fi

if [ $UP == 2 ]; then
read -p "Please enter devupload key: " KEY
echo -e "Started uploading file on DevUploads..."
bash <(curl -s https://devuploads.com/upload.sh) -f $FP -k $KEY
fi

if [ $UP == 3 ]; then
#read -p "Please enter Pixel Drain key: " KEY
echo -e "Started uploading file on PixelDrain..."
ls go-pd || PixelDrain=1
if [ "$PixelDrain" == "1" ]; then
wget https://github.com/ManuelReschke/go-pd/releases/download/v1.4.0/go-pd_1.4.0_linux_amd64.tar.gz
tar -xf go-pd*
rm -rf go-pd_*.tar.gz
fi
./go-pd upload $FP
fi

if [ $UP == 4 ]; then
curl -T $FP temp.sh
echo -e "Started uploading file on Temp..."
fi
