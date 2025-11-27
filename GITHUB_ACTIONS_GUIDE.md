# GitHub Actions 构建指南

## 概述

本项目已配置为在GitHub Actions中自动编译本地设备树文件并构建Orange Pi RK3399的OpenWrt固件。

## 构建流程

当您在GitHub Actions中触发构建时，系统会自动：

1. **检测设备树文件**: 检查是否存在 `your.dts` 文件
2. **安装编译工具**: 自动安装 `device-tree-compiler`
3. **编译设备树**: 将 `your.dts` 编译为 `rk3399-orangepi.dtb`
4. **构建固件**: 使用编译好的设备树文件构建OpenWrt固件

## 使用方法

### 1. 准备文件
确保以下文件在仓库根目录：
- `your.dts` - Orange Pi RK3399设备树源文件

### 2. 触发构建
在GitHub仓库的Actions页面，选择"Make OpenWrt"工作流并运行。

### 3. 构建参数
可以使用以下参数自定义构建：

```yaml
- name: Make OpenWrt
  uses: ./
  with:
    openwrt_board: "orangepi-rk3399"  # 指定构建Orange Pi RK3399
    openwrt_kernel: "6.1.y_6.12.y"    # 内核版本
    openwrt_ip: "192.168.1.1"         # 默认IP地址
    builder_name: "YourName"          # 构建者签名
```

### 4. 完整示例工作流

```yaml
name: Build Orange Pi RK3399

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v4
    
    - name: Make OpenWrt for Orange Pi RK3399
      uses: ./
      with:
        openwrt_board: "orangepi-rk3399"
        openwrt_kernel: "6.1.y_6.12.y"
        openwrt_ip: "192.168.1.1"
        builder_name: "GitHub Actions"
```

## 构建输出

构建成功后，您将获得：
- Orange Pi RK3399专用的OpenWrt固件
- 包含本地编译设备树的完整系统镜像

## 故障排除

### 设备树编译失败
- 检查 `your.dts` 文件语法是否正确
- 确保设备树文件在仓库根目录

### 构建失败
- 检查GitHub Actions日志获取详细错误信息
- 确认所有依赖文件都存在

### 设备不启动
- 验证设备树是否与硬件兼容
- 检查串口输出获取启动信息

## 自动化构建

您可以将此配置用于：
- 每次代码推送时自动构建
- 发布新版本时生成固件
- 持续集成测试

## 相关文件

- `action.yml` - GitHub Actions配置
- `your.dts` - 设备树源文件
- `make-openwrt/openwrt-files/common-files/etc/model_database.conf` - 设备数据库配置
