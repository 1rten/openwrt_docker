#!/bin/bash

# 1. Update feeds first to make sure indexes are available
./scripts/feeds update -a

# 2. Add Argon Theme (Removed)
# ImmortalWrt 24.10 natively includes an optimized luci-theme-argon.
# Manually cloning Jerrykuku's repo overrides the native package and breaks compatibility in 24.10.

# 3. Install all feeds
./scripts/feeds install -a

# 4. Modify default settings
# Change default IP
sed -i 's/192.168.1.1/192.168.50.199/g' package/base-files/files/bin/config_generate
# Change default hostname
sed -i 's/ImmortalWrt/OpenWrt-Docker/g' package/base-files/files/bin/config_generate
# Change default timezone
sed -i "s/'UTC'/'CST-8'\n\t\tset system.@system[-1].zonename='Asia\/Shanghai'/g" package/base-files/files/bin/config_generate

# Fix DNS resolution for Docker environment
mkdir -p files/etc/uci-defaults
cat << "EOF" > files/etc/uci-defaults/99-fix-dns
#!/bin/sh
# Ignore Docker's /etc/resolv.conf
uci set dhcp.@dnsmasq[0].resolvfile='/tmp/resolv.conf.auto'
uci set dhcp.@dnsmasq[0].noresolv='1'
# Set a reliable upstream DNS
uci add_list dhcp.@dnsmasq[0].server='223.5.5.5'
uci add_list dhcp.@dnsmasq[0].server='114.114.114.114'
uci commit dhcp
/etc/init.d/dnsmasq restart
exit 0
EOF
chmod +x files/etc/uci-defaults/99-fix-dns
