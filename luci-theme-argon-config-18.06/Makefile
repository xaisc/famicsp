include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-argonne-config-18.06
PKG_VERSION:=1.2
PKG_RELEASE:=2

PKG_MAINTAINER:=jerrykuku <jerrykuku@qq.com>

LUCI_TITLE:=LuCI page for Argonne Config-18.06
LUCI_PKGARCH:=all
LUCI_DEPENDS:=+luci-compat +luci-theme-argon-18.06

define Package/$(PKG_NAME)/conffiles
/etc/config/argonne
endef

include $(TOPDIR)/feeds/luci/luci.mk

# call BuildPackage - OpenWrt buildroot signature
