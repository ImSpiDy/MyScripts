#!/bin/bash

GH_REPO=0
echo "Create Empty Repo to Store Keys /n and Please Keep Your Repo Private :)"
read -p "Please Enter github repo link: " GH_REPO
read -p "Please ROM DIR like 'home/lineage" ROM_DIR

if [ $GH_REPO == 0 ]; then
echo "Please Enter your repo link"
exit 0
fi

# Keys
PRIV='vendor/lineage-priv/keys'

rm -rf $PRIV; git clone $GH_REPO $PRIV

subject='/C=US/ST=California/L=Mountain View/O=Android/OU=Android/CN=Android/emailAddress=android@android.com'

for cert in bluetooth cyngn-app media networkstack platform releasekey sdk_sandbox shared testcert testkey verity; do \
    ./development/tools/make_key ~/$PRIV/$cert "$subject"; \
done
