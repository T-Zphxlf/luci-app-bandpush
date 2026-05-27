include $(TOPDIR)/rules.mk
-include $(dir $(lastword $(MAKEFILE_LIST)))../version.mk

PKG_VERSION:=1.0.0
PKG_RELEASE:=1

LUCI_TITLE:=BandPush
LUCI_DEPENDS:=+luci-compat +curl +lua
LUCI_PKGARCH:=all

PKG_NAME:=luci-app-bandpush

include $(TOPDIR)/feeds/luci/luci.mk