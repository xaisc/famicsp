include $(TOPDIR)/rules.mk

PKG_NAME:=luci-theme-argon-config-21.02
PKG_VERSION:=0.9
PKG_RELEASE:=20220424

PKG_MAINTAINER:=jerrykuku <jerrykuku@qq.com>

LUCI_TITLE:=LuCI page for Argon Config for 21.02
LUCI_PKGARCH:=all
LUCI_DEPENDS:=+luci-compat +luci-theme-argon-21.02

define Package/$(PKG_NAME)/conffiles
/etc/config/argon
endef

include $(TOPDIR)/feeds/luci/luci.mk

# call BuildPackage - OpenWrt buildroot signature
