#!/bin/bash

# 1. Add Argon Theme source
rm -rf package/luci-theme-argon
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
git clone https://github.com/jerrykuku/luci-app-argon-config.git package/luci-app-argon-config

# 2. Update and install feeds
./scripts/feeds update -a
./scripts/feeds install -a

# 3. Modify default IP (Optional, since we use files/ folder, but good as fallback)
sed -i 's/192.168.1.1/192.168.50.199/g' package/base-files/files/bin/config_generate

# 4. Modify default hostname
sed -i 's/ImmortalWrt/OpenWrt-Docker/g' package/base-files/files/bin/config_generate

# 5. Set default timezone to Asia/Shanghai
sed -i "s/'UTC'/'CST-8'\n\t\tset system.@system[-1].zonename='Asia\/Shanghai'/g" package/base-files/files/bin/config_generate
