# 本地设备树编译说明

## 概述

本项目支持使用本地设备树文件 (`your.dts`) 编译生成 `rk3399-orangepi.dtb`，用于构建 Orange Pi RK3399 的 OpenWrt 固件。

## 使用方法

### 1. 编译本地设备树

```bash
# 给脚本执行权限
chmod +x compile_local_dtb.sh

# 编译设备树
./compile_local_dtb.sh
```

### 2. 构建 OpenWrt 固件

在编译设备树后，使用以下命令构建 Orange Pi RK3399 的 OpenWrt 固件：

```bash
# 使用 remake 脚本构建
sudo ./remake orangepi-rk3399

# 或者使用 make-openwrt 脚本
sudo ./make-openwrt orangepi-rk3399
```

## 配置说明

### 设备数据库配置

在 `make-openwrt/openwrt-files/common-files/etc/model_database.conf` 中已经配置了 Orange Pi RK3399：

```
r428    :Orange-Pi-RK3399                              :rk3399   :rk3399-orangepi.dtb                      :NA                           :u-boot.itb                          :idbloader.img                   :4GB-LPDDR4,1Gb-Nic,BT,wifi                 :stable/6.1.y          :rockchip    :rk3399       :armbianEnv.txt  :unifreq                                              :orangepi-rk3399     :yes
```

### 差异化文件

已创建 Orange Pi RK3399 的差异化文件目录：
- `make-openwrt/openwrt-files/different-files/orangepi-rk3399/`

## 注意事项

1. **设备树文件**: 确保 `your.dts` 文件在项目根目录
2. **依赖**: 需要安装 `device-tree-compiler` (dtc)
3. **构建顺序**: 先编译设备树，再构建 OpenWrt 固件
4. **临时文件**: 编译后的 dtb 文件会保存在 `temp_dtb_files/` 目录

## 故障排除

### 设备树编译失败
- 检查 `your.dts` 语法是否正确
- 确认 dtc 已安装: `dtc --version`

### 构建失败
- 检查设备树文件是否已正确编译
- 确认 model_database.conf 配置正确
- 查看构建日志获取详细错误信息

## 支持的设备

- **Orange Pi RK3399**: 使用 `your.dts` 编译的设备树
- **其他设备**: 参考现有配置添加新设备支持

## 相关文件

- `your.dts` - 设备树源文件
- `compile_local_dtb.sh` - 设备树编译脚本
- `make-openwrt/openwrt-files/common-files/etc/model_database.conf` - 设备数据库
