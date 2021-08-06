#!/bin/bash

set -e
set -x

# sync rom
repo init --depth=1 -u git://github.com/DotOS/manifest.git -b dot11
##git clone https://github.com/Apon77Lab/android_.repo_local_manifests.git --depth 1 -b aex .repo/local_manifests
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags --optimized-fetch --prune

# build rom
cd Project
source build/envsetup.sh
lunch dot_RMX2001-userdebug
make bacon -j$(nproc --all)

# upload rom
up(){
	curl --upload-file $1 https://transfer.sh/$(basename $1); echo
	# 14 days, 10 GB limit
}

up out/target/product/RMX2001/*.zip
