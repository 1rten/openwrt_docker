# 示例：SuLingGG 风格的 Dockerfile 核心逻辑
FROM scratch
ADD openwrt-rootfs.tar.gz /

# 这两行非常关键，修复 Docker 运行时的动态库问题
COPY --from=builder /usr/lib/libgcc_s.so.1 /usr/lib/
COPY --from=builder /lib/ld-musl-aarch64.so.1 /lib/

# 处理权限和初始化
USER root
ENTRYPOINT ["/sbin/init"]