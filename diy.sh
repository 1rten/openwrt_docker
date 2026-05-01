#!/bin/bash

# 1. Add helloworld feed for SSR Plus
echo 'src-git helloworld https://github.com/fw876/helloworld.git' >> feeds.conf.default

# 2. Update feeds first to make sure indexes are available
./scripts/feeds update -a

# 3. Add Argon Theme (Switch to master branch for 24.10 compatibility)
rm -rf package/luci-theme-argon
rm -rf package/luci-app-argon-config
git clone https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
git clone https://github.com/jerrykuku/luci-app-argon-config.git package/luci-app-argon-config

# 4. Install all feeds
./scripts/feeds install -a

# 4. Modify default settings
# Change default IP
sed -i 's/192.168.1.1/192.168.50.199/g' package/base-files/files/bin/config_generate
# Change default hostname
sed -i 's/ImmortalWrt/OpenWrt-Docker/g' package/base-files/files/bin/config_generate
# Change default timezone
sed -i "s/'UTC'/'CST-8'\n\t\tset system.@system[-1].zonename='Asia\/Shanghai'/g" package/base-files/files/bin/config_generate
