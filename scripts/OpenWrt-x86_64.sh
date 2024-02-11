#!/bin/bash

# 修改默认IP
sed -i 's/192.168.1.1/192.168.31.1/g' package/base-files/files/bin/config_generate

# 添加插件包
# merge_package() {
	# 参数1是分支名, 参数2是子目录, 参数3是目标目录, 参数4仓库地址
	# trap 'rm -rf "$TMP_DIR"' 0 1 2 3
	# TMP_DIR="$(mktemp -d)" || exit 1
 	# ORI_DIR="$PWD"
	# [ -d "$3" ] || mkdir -p "$3"
	# TGT_DIR="$(cd "$3"; pwd)"
	# cd "$TMP_DIR" && \
	# git init >/dev/null 2>&1 && \
	# git remote add -f origin "$4" >/dev/null 2>&1 && \
	# git checkout "remotes/origin/$1" -- "$2" && \
	# cd "$2" && cp -a . "$TGT_DIR/" && cd "$ORI_DIR"
# }
# merge_package "master" "luci-app-openclash" "package/openwrt-packages/luci-app-openclash" "https://github.com/WYC-2020/openwrt-packages"

git clone --depth=1 -b master https://github.com/kenzok8/openwrt-packages package/openwrt-package
git clone --depth=1 -b master https://github.com/kenzok8/small package/small


./scripts/feeds update -a
./scripts/feeds install -a