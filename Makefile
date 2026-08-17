include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-pppoe-server
PKG_VERSION:=1.0.0
PKG_RELEASE:=1

PKG_MAINTAINER:=Khilma Ubaidilah
PKG_LICENSE:=MIT

include $(INCLUDE_DIR)/package.mk

define Package/luci-app-pppoe-server
  SECTION:=luci
  CATEGORY:=LuCI
  SUBMENU:=3. Applications
  TITLE:=MikroTik-style PPPoE Server with Bandwidth Limit & Isolir
  DEPENDS:=+rp-pppoe-server +ppp +tc-tiny +kmod-sched-core +kmod-sched-cake +nftables +uhttpd
  PKGARCH:=all
endef

define Package/luci-app-pppoe-server/description
  A LuCI management package for PPPoE Server on OpenWrt 24 with MikroTik-like features including rate-limiting and user isolation redirect.
endef

define Build/Compile
endef

define Package/luci-app-pppoe-server/install
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_DIR) $(1)/etc/ppp/ip-up.d
	$(INSTALL_DIR) $(1)/etc/ppp/ip-down.d
	$(INSTALL_DIR) $(1)/usr/share/luci/menu.d
	$(INSTALL_DIR) $(1)/usr/share/luci/resources/view/pppoe-server
	$(INSTALL_DIR) $(1)/www/luci-static/resources/view/pppoe-server
	$(INSTALL_DIR) $(1)/usr/share/rpcd/acl.d
	$(INSTALL_DIR) $(1)/www/isolir

	$(INSTALL_CONF) ./files/etc/config/pppoe-server $(1)/etc/config/pppoe-server
	$(INSTALL_BIN) ./files/etc/init.d/pppoe-server $(1)/etc/init.d/pppoe-server
	$(INSTALL_BIN) ./files/etc/ppp/ip-up.d/99-pppoe-limits $(1)/etc/ppp/ip-up.d/99-pppoe-limits
	$(INSTALL_BIN) ./files/etc/ppp/ip-down.d/99-pppoe-limits $(1)/etc/ppp/ip-down.d/99-pppoe-limits
	
	$(INSTALL_DATA) ./files/usr/share/luci/menu.d/luci-app-pppoe-server.json $(1)/usr/share/luci/menu.d/luci-app-pppoe-server.json
	$(INSTALL_DATA) ./files/usr/share/rpcd/acl.d/luci-app-pppoe-server.json $(1)/usr/share/rpcd/acl.d/luci-app-pppoe-server.json
	
	$(INSTALL_DATA) ./files/usr/share/luci/resources/view/pppoe-server/*.js $(1)/usr/share/luci/resources/view/pppoe-server/
	$(INSTALL_DATA) ./files/usr/share/luci/resources/view/pppoe-server/*.js $(1)/www/luci-static/resources/view/pppoe-server/
	
	$(INSTALL_DATA) ./files/www/isolir/index.html $(1)/www/isolir/index.html
endef

$(eval $(call BuildPackage,luci-app-pppoe-server))
