#!/bin/bash

svn_export() {
	# 参数1是分支名, 参数2是子目录, 参数3是目标目录, 参数4仓库地址
	trap 'rm -rf "$TMP_DIR"' 0 1 2 3
	TMP_DIR="$(mktemp -d)" || exit 1
	[ -d "$3" ] || mkdir -p "$3"
	TGT_DIR="$(cd "$3"; pwd)"
	cd "$TMP_DIR" && \
	git init >/dev/null 2>&1 && \
	git remote add -f origin "$4" >/dev/null 2>&1 && \
	git checkout "remotes/origin/$1" -- "$2" && \
	cd "$2" && cp -a . "$TGT_DIR/"
}

# svn_export "master" "target/linux/x86" "route" "https://github.com/coolsnowwolf/lede"

# 修改默认IP
sed -i 's/192.168.1.1/192.168.31.1/g' package/base-files/files/bin/config_generate

# git clone --depth=1 -b master https://github.com/kenzok8/openwrt-packages package/openwrt-package
# git clone --depth=1 -b master https://github.com/kenzok8/small package/small

# 添加MosDNS
rm -rf feeds/packages/net/v2ray-geodata
git clone https://github.com/sbwml/luci-app-mosdns -b v5 package/mosdns
git clone https://github.com/sbwml/v2ray-geodata package/v2ray-geodata

# 添加Passwall
# git clone https://github.com/xiaorouji/openwrt-passwall package/passwall

./scripts/feeds update -a
./scripts/feeds install -a