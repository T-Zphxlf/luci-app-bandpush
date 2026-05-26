include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-bandpush
PKG_VERSION:=1.0.0
PKG_RELEASE:=1
PKG_LICENSE:=Apache-2.0

include $(INCLUDE_DIR)/package.mk

define Package/luci-app-bandpush
  SECTION:=luci
  CATEGORY:=LuCI
  SUBMENU:=BandPush
  TITLE:=BandPush 流量推送插件
  PKGARCH:=all
  DEPENDS:=+luci-compat +curl +lua
endef

define Package/luci-app-bandpush/description
  基于 Bandwidthd 的流量统计与推送插件
endef

define Package/luci-app-bandpush/conffiles
/etc/config/bandpush
endef

define Build/Prepare
	mkdir -p $(PKG_BUILD_DIR)
endef

define Build/Compile
endef

define Package/luci-app-bandpush/install
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/../root/etc/config/bandpush $(1)/etc/config/bandpush
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/../root/usr/bin/bandpush-task $(1)/usr/bin/bandpush-task
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/controller
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/luasrc/controller/bandpush.lua $(1)/usr/lib/lua/luci/controller/bandpush.lua
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/model/cbi/bandpush
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/luasrc/model/cbi/bandpush/*.lua $(1)/usr/lib/lua/luci/model/cbi/bandpush/
	$(INSTALL_DIR) $(1)/usr/lib/lua/luci/lib
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/luasrc/lib/*.lua $(1)/usr/lib/lua/luci/lib/
endef

$(eval $(call BuildPackage,luci-app-bandpush))
