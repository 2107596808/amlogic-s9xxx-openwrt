# Windows 环境设备树编译指南

## 概述

由于Windows环境中没有预装设备树编译器(dtc)，您需要在Linux环境中编译设备树文件。

## 编译方法

### 方法1: 使用WSL (推荐)
1. 安装WSL (Windows Subsystem for Linux)
2. 在WSL中安装设备树编译器:
   ```bash
   sudo apt-get update
   sudo apt-get install device-tree-compiler
   ```
3. 在WSL中编译设备树:
   ```bash
   dtc -I dts -O dtb -o rk3399-orangepi.dtb your.dts
   ```

### 方法2: 使用Linux虚拟机
1. 在虚拟机中安装Linux系统
2. 安装设备树编译器
3. 编译设备树文件

### 方法3: 使用Docker
```bash
# 运行包含dtc的Docker容器
docker run --rm -v $(pwd):/workdir ubuntu:20.04 bash -c "
  apt-get update && apt-get install -y device-tree-compiler &&
  cd /workdir &&
  dtc -I dts -O dtb -o rk3399-orangepi.dtb your.dts
"
```

## 构建流程

1. **编译设备树**: 在Linux环境中编译 `your.dts` 为 `rk3399-orangepi.dtb`
2. **复制文件**: 将编译好的dtb文件放回Windows项目目录
3. **构建OpenWrt**: 在Windows中使用项目构建脚本

```bash
# 构建Orange Pi RK3399固件
sudo ./remake orangepi-rk3399
```

## 验证编译

编译成功后，您应该看到:
- `rk3399-orangepi.dtb` 文件 (设备树二进制文件)
- 文件大小通常在几十KB到几百KB之间

## 注意事项

- 确保 `your.dts` 语法正确
- 编译后的dtb文件需要与项目构建脚本配合使用
- 项目已配置好Orange Pi RK3399的支持，只需提供正确的dtb文件即可
