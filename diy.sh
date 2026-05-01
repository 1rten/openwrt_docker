#!/bin/bash

# 1. Update feeds first to make sure indexes are available
./scripts/feeds update -a

# 3. Install all feeds
./scripts/feeds install -a

# 4. Modify default settings
# Change default IP
sed -i 's/192.168.1.1/192.168.50.199/g' package/base-files/files/bin/config_generate
# Change default hostname
sed -i 's/ImmortalWrt/OpenWrt-Docker/g' package/base-files/files/bin/config_generate
# Change default timezone
sed -i "s/'UTC'/'CST-8'\n\t\tset system.@system[-1].zonename='Asia\/Shanghai'/g" package/base-files/files/bin/config_generate
