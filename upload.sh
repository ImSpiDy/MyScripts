#!/usr/bin/env bash
#
# upload file to github or devupload
#

echo "github release = 1 | devuploads = 2"
read -p "Please enter site name: " UP
read -p "Please enter file path/name: " FP

if [ $UP == "1" ]; then
read -p "Please enter github repo link: " GH
FN="$(basename $FP)"
echo -e "Started uploading file on github..."
gh release create $FN --generate-notes --repo $GH
gh release upload --clobber $FN $FP --repo $GH
else
read -p "Please enter devupload key: " KEY
echo -e "Started uploading file on DevUploads..."
bash <(curl -s https://devuploads.com/upload.sh) -f $FP -k $KEY

fi