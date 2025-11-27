#!/bin/bash
# 本地设备树编译脚本
# 将 your.dts 编译为 rk3399-orangepi.dtb

set -e

echo "开始编译本地设备树文件..."

# 检查 dtc 是否可用
if ! command -v dtc &> /dev/null; then
    echo "错误: dtc (device-tree-compiler) 未安装"
    echo "请安装: sudo apt-get install device-tree-compiler"
    exit 1
fi

# 检查源文件是否存在
if [ ! -f "your.dts" ]; then
    echo "错误: your.dts 文件不存在"
    exit 1
fi

# 编译设备树
echo "正在编译 your.dts -> rk3399-orangepi.dtb"
dtc -I dts -O dtb -o rk3399-orangepi.dtb your.dts

# 检查编译是否成功
if [ $? -eq 0 ] && [ -f "rk3399-orangepi.dtb" ]; then
    echo "✅ 设备树编译成功: rk3399-orangepi.dtb"
    echo "文件大小: $(du -h rk3399-orangepi.dtb | cut -f1)"
else
    echo "❌ 设备树编译失败"
    exit 1
fi

# 将编译好的 dtb 文件复制到临时目录供构建系统使用
mkdir -p temp_dtb_files
cp rk3399-orangepi.dtb temp_dtb_files/

echo "✅ 本地设备树编译完成"
