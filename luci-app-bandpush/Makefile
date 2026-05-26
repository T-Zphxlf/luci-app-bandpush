include $(TOPDIR)/rules.mk
-include $(dir $(lastword $(MAKEFILE_LIST)))../version.mk

PKG_NAME:=luci-app-bandpush
PKG_VERSION:=1.0.0
PKG_RELEASE:=1
PKG_LICENSE:=Apache-2.0

LUCI_TITLE:=BandPush 流量推送插件
LUCI_DESCRIPTION:=基于 Bandwidthd 的流量统计与推送插件
LUCI_DEPENDS:=+luci-compat +curl +lua
LUCI_PKGARCH:=all

define Package/luci-app-bandpush/conffiles
/etc/config/bandpush
endef

include $(TOPDIR)/feeds/luci/luci.mk
