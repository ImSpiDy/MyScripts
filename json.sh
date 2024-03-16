#!/bin/bash

zipname=$(ls o*/t*/p*/*/*.zip)
sha256sum=$(sha256sum o*/t*/p*/*/*.zip)
datetime=$(cat o*/t*/p*/*/system/build.prop | grep ro.build.date.utc)
zipsize=$(stat -c%s o*/t*/p*/*/*zip)

# Zip path
cd o*/t*/p*/*/

echo "json file
Zip name :- $zipname
Shasum :- $sha256sum
DateTime :- $datetime
Zip Size :- $zipsize
" > json.txt
