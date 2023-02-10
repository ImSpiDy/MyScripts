#!/usr/bin/env bash
#
# Kanged by ImSpiDy
# Import or update wireguard
#

kt_dir="$(pwd)"
wg_dir="${kt_dir}/net/wireguard"
user_agent="WireGuard-AndroidROMBuild/0.3 ($(uname -a))"
wireguard_url="https://git.zx2c4.com/wireguard-linux-compat/snapshot/wireguard-linux-compat"

if [ -d "${wg_dir}" ]; then
        rm -rf "${wg_dir}"
	wg_type="merge"
else
	wg_type="import"
fi

while read -r distro package version _; do
	if [[ $distro == upstream && $package == linuxcompat ]]; then
		ver="$version"
		break
	fi
done < <(curl -A "${user_agent}" -LSs --connect-timeout 30 https://build.wireguard.com/distros.txt)

if [ ! -f "wireguard-linux-compat-${ver}.zip" ]; then
	wget "${wireguard_url}"-"${ver}".zip
	unzip wireguard-linux-compat-"${ver}".zip -d "${kt_dir}"/wireguard
fi

mkdir -p "${wg_dir}"
cp -r "${kt_dir}"/wireguard/*/src/* "${wg_dir}"
rm -rf "${kt_dir}"/wireguard*
git add "${wg_dir}"
git commit -sm "net: ${wg_type} wireguard-linux-compat ${ver}"

rm -rf $kt_dir/wg

echo "done"
