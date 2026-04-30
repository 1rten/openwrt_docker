FROM scratch

ADD openwrt-rootfs.tar.gz /

EXPOSE 80 443 22

USER root

ENTRYPOINT ["/sbin/init"]
