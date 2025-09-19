#!/bin/bash
# 优化编译配置

echo "开始优化编译配置..."

# 1. 禁用调试信息
sed -i 's/CONFIG_DEBUG=y/CONFIG_DEBUG=n/' .config
sed -i 's/CONFIG_DEBUG_INFO=y/CONFIG_DEBUG_INFO=n/' .config

# 2. 移除不必要的语言包
sed -i '/CONFIG_PACKAGE_luci-i18n/d' .config

# 3. 优化编译flags
if ! grep -q "CONFIG_EXTRA_CFLAGS" .config; then
    echo 'CONFIG_EXTRA_CFLAGS="-O2 -pipe -mtune=cortex-a53"' >> .config
fi

if ! grep -q "CONFIG_EXTRA_CXXFLAGS" .config; then
    echo 'CONFIG_EXTRA_CXXFLAGS="-O2 -pipe -mtune=cortex-a53"' >> .config
fi

# 4. 使用预编译的工具链
if ! grep -q "CONFIG_USE_PRECOMPILED_TOOLCHAIN" .config; then
    echo "CONFIG_USE_PRECOMPILED_TOOLCHAIN=y" >> .config
fi

# 5. 启用ccache
if ! grep -q "CONFIG_CCACHE" .config; then
    echo "CONFIG_CCACHE=y" >> .config
fi

echo "编译优化配置完成"
