#!/usr/bin/env bash
#
# Upload Files
#

echo " "
echo "[1] Github Release [gh auth login]
[2] Devuploads [Key]
[3] Temp.sh
[4] Gofile
[5] oshi.at
"
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
echo -e "Started uploading file on Temp..."
curl -T $FP temp.sh
fi

if [ $UP == 4 ]; then
echo -e "Started uploading file on Gofile..."
SERVER=$(curl -X GET 'https://api.gofile.io/servers' | grep -Po '(store*)[^"]*' | tail -n 1)
curl -X POST https://${SERVER}.gofile.io/contents/uploadfile -F "file=@$FP" | grep -Po '(https://gofile.io/d/)[^"]*'
fi

if [ $UP == 5 ]; then
echo -e "Started uploading file on Oshi.at..."
curl -T $FP https://oshi.at
fi
