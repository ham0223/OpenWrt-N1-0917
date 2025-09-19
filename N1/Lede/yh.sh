- name: 优化编译配置
  run: |
    [ -e $OPTIMIZE_SH ] && cp $OPTIMIZE_SH openwrt/
    chmod +x openwrt/yh.sh
    cd openwrt && ./yh.sh