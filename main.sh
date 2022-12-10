
#!/bin/bash
function git_clone() {
  git clone --depth 1 $1 $2 || true
 }
function git_sparse_clone() {
  branch="$1" rurl="$2" localdir="$3" && shift 3
  git clone -b $branch --depth 1 --filter=blob:none --sparse $rurl $localdir
  cd $localdir
  git sparse-checkout init --cone
  git sparse-checkout set $@
  mv -n $@ ../
  cd ..
  rm -rf $localdir
  }
function mvdir() {
mv -n `find $1/* -maxdepth 0 -type d` ./
rm -rf $1
}

rm -rf `find ./* -maxdepth 0 -type d ! -name "diy"` >/dev/null 2>&1

##passwall's depends packages
git clone -b packages --depth 1 https://github.com/xiaorouji/openwrt-passwall
mv -n openwrt-passwall/* ./ ; rm -Rf openwrt-passwall
##passwall's luci-app
git clone --depth 1 -b luci https://github.com/xiaorouji/openwrt-passwall passwall1 && mv -n passwall1/luci-app-passwall  ./; rm -rf passwall1
##helloworld's extra depends packages 
#svn export https://github.com/fw876/helloworld/trunk/sagernet-core
svn export https://github.com/fw876/helloworld/trunk/lua-neturl
svn export https://github.com/fw876/helloworld/trunk/redsocks2
##helloworld's luci-app 
svn export https://github.com/fw876/helloworld/trunk/luci-app-ssr-plus
##jerrykuku's helloworld luci-app
git clone --depth 1 -b 18.06 https://github.com/jerrykuku/luci-theme-argon luci-theme-argon-18.06
sed -i 's/LUCI_TITLE:=Argon Theme/LUCI_TITLE:=Argon Theme for Lede or openwrt 18.06/g' luci-theme-argon-18.06/Makefile
sed -i 's/Package\/luci-theme-argon\/postinst/Package\/luci-theme-argon-18.06\/postinst/g' luci-theme-argon-18.06/Makefile
git clone --depth 1 https://github.com/jerrykuku/luci-app-argon-config luci-theme-argon-config-18.06
sed -i 's/luci-app-argon-config/luci-theme-argon-config-18.06/g' luci-theme-argon-config-18.06/Makefile
sed -i 's/+luci-compat/+luci-compat +luci-theme-argon-18.06/g' luci-theme-argon-config-18.06/Makefile
git clone --depth 1 https://github.com/jerrykuku/luci-app-vssr
git clone --depth 1 https://github.com/jerrykuku/lua-maxminddb
#bypass plug-in
svn export https://github.com/tianiue/luci-app-bypass/trunk/luci-app-bypass
cp -r luci-app-bypass/po/zh-cn luci-app-bypass/po/zh_Hans
##luci-app-netdate full Chinese edition
git clone --depth 1 https://github.com/Jason6111/luci-app-netdata luci-app-netdata-cn && sed -i 's/luci-app-netdata/luci-app-netdata-cn/g' luci-app-netdata-cn/Makefile
cp -r luci-app-netdata-cn/po/zh-cn luci-app-netdata-cn/po/zh_Hans
mv -n luci-app-netdata-cn/root/etc/netdata/netdata.conf luci-app-netdata-cn/root/etc/netdata/netdata.conf.backup
##immortalwrt's luci-app-adbyby-plus,this app plus wget-ssl better then lede's
svn export https://github.com/immortalwrt/luci/trunk/applications/luci-app-adbyby-plus luci-app-adbyby-plus-wgets-ssl && sed -i 's/luci-app-adbyby-plus/luci-app-adbyby-plus-wgets-ssl/g' luci-app-adbyby-plus-wgets-ssl/Makefile
cp -r luci-app-adbyby-plus-wgets-ssl/po/zh_Hans luci-app-adbyby-plus-wgets-ssl/po/zh-cn
svn export https://github.com/immortalwrt/luci/trunk/applications/luci-app-iptvhelper
cp -r luci-app-iptvhelper/po/zh_Hans luci-app-iptvhelper/po/zh-cn
svn export https://github.com/immortalwrt/packages/trunk/net/iptvhelper
##Lienol's luci-app
svn export https://github.com/Lienol/openwrt-package/trunk/luci-app-control-timewol luci-app-control-timewol-byLienol && sed -i 's/luci-app-control-timewol/luci-app-control-timewol-byLienol/g' luci-app-control-timewol-byLienol/Makefile
svn export https://github.com/Lienol/openwrt-package/trunk/luci-app-control-webrestriction luci-app-control-webrestriction-byLienol && sed -i 's/luci-app-control-webrestriction/luci-app-control-webrestriction-byLienol/g' luci-app-control-webrestriction-byLienol/Makefile
svn export https://github.com/Lienol/openwrt-package/trunk/luci-app-control-weburl luci-app-control-weburl-byLienol && sed -i 's/luci-app-control-weburl/luci-app-control-weburl-byLienol/g' luci-app-control-weburl-byLienol/Makefile
svn export https://github.com/Lienol/openwrt-package/trunk/luci-app-timecontrol luci-app-timecontrol-byLienol && sed -i 's/luci-app-timecontrol/luci-app-timecontrol-byLienol/g' luci-app-timecontrol-byLienol/Makefile
git clone --depth 1 https://github.com/kongfl888/luci-app-adguardhome
##ddns-go's luci-app and main package
git clone https://github.com/sirpdboy/luci-app-ddns-go.git ddns-go
mv -n ddns-go/* ./ ; rm -Rf ddns-go ; rm README.md
##serverchan's new app
git clone --depth 1 https://github.com/zzsj0928/luci-app-pushbot
##Chinadns_ng's main packages and luci-app web ui
#git clone https://github.com/zfl9/chinadns-ng
git clone -b luci https://github.com/pexcn/openwrt-chinadns-ng.git luci-app-chinadns-ng
##poweroff for device 
git clone --depth 1 https://github.com/esirplayground/luci-app-poweroff
cp -r luci-app-poweroff/po/zh-cn luci-app-poweroff/po/zh_Hans
##onliner's luci-app need +luci-app-wrtbwmon
git clone --depth 1 https://github.com/ElvenP/luci-app-onliner && sed -i 's/+luci-app-wrtbwmon/+luci-app-wrtbwmon-brv/g' luci-app-onliner/Makefile
cp -r luci-app-onliner/po/zh-cn luci-app-onliner/po/zh_Hans
#wrtbwmon's main packages and luci-app
svn export https://github.com/brvphoenix/luci-app-wrtbwmon/trunk/luci-app-wrtbwmon luci-app-wrtbwmon-brv && sed -i 's/luci-app-wrtbwmon/luci-app-wrtbwmon-brv/g' luci-app-wrtbwmon-brv/Makefile
cp -r luci-app-wrtbwmon-brv/po/zh_Hans luci-app-wrtbwmon-brv/po/zh-cn
svn export https://github.com/brvphoenix/wrtbwmon/trunk/wrtbwmon
##appfilter's main packages and luci-app
git clone --depth 1 https://github.com/destan19/OpenAppFilter && mvdir OpenAppFilter

#svn export https://github.com/kuoruan/openwrt-upx/trunk/upx
#svn export https://github.com/kuoruan/openwrt-upx/trunk/ucl
svn export https://github.com/vernesong/OpenClash/trunk/luci-app-openclash
svn export https://github.com/sundaqiang/openwrt-packages/trunk/luci-app-wolplus

git clone --depth 1 https://github.com/kiddin9/luci-app-wizard
cp -r luci-app-wizard/po/zh_Hans luci-app-wizard/po/zh-cn

git clone --depth 1 https://github.com/sirpdboy/luci-app-advanced

git clone --depth 1 -b lede https://github.com/pymumu/luci-app-smartdns

git clone --depth 1 https://github.com/Huangjoe123/luci-app-eqos
cp -r luci-app-eqos/po/zh_Hans luci-app-eqos/po/zh-cn

#svn export https://github.com/kiddin9/openwrt-packages/trunk/luci-app-fileassistant
#svn export https://github.com/immortalwrt/luci/trunk/applications/luci-app-filebrowser
#svn export https://github.com/immortalwrt/luci/trunk/applications/luci-app-aliddns
#svn export https://github.com/immortalwrt/packages/trunk/net/smartdns
#svn export https://github.com/Tencent-Cloud-Plugins/tencentcloud-openwrt-plugin-ddns/trunk/tencentcloud_ddns luci-app-tencentddns
#svn export https://github.com/Tencent-Cloud-Plugins/tencentcloud-openwrt-plugin-cos/trunk/tencentcloud_cos luci-app-tencentcloud-cos
#svn export https://github.com/kiddin9/openwrt-packages/trunk/luci-app-adguardhome
#svn export https://github.com/kiddin9/openwrt-packages/trunk/adguardhome
#svn export https://github.com/kenzok8/litte/trunk/luci-theme-atmaterial_new
#svn export https://github.com/kenzok8/litte/trunk/luci-theme-mcat
#svn export https://github.com/kenzok8/litte/trunk/luci-theme-tomato
#svn export https://github.com/x-wrt/packages/trunk/net/nft-qos
#svn export https://github.com/x-wrt/luci/trunk/applications/luci-app-nft-qos
#svn export https://github.com/kiddin9/openwrt-packages/trunk/luci-app-diskman
#svn export https://github.com/kiddin9/openwrt-packages/trunk/vsftpd-alt
#svn export https://github.com/messense/aliyundrive-fuse/trunk/openwrt && mvdir openwrt
#svn export https://github.com/messense/openwrt-wiretrustee/trunk/wiretrustee
#svn export https://github.com/messense/aliyundrive-webdav/trunk/openwrt aliyundrive && mvdir aliyundrive

#svn export https://github.com/Lienol/openwrt-package/branches/other/lean/luci-app-autoreboot

#svn export https://github.com/openwrt/packages/trunk/net/shadowsocks-libev

#svn export https://github.com/haiibo/openwrt-packages/trunk/homebox
#svn export https://github.com/haiibo/openwrt-packages/trunk/luci-app-homebox

#svn export https://github.com/haiibo/openwrt-packages/trunk/luci-theme-atmaterial
#svn export https://github.com/haiibo/openwrt-packages/trunk/luci-theme-infinityfreedom
#svn export https://github.com/haiibo/openwrt-packages/trunk/luci-theme-netgear
#svn export https://github.com/haiibo/openwrt-packages/trunk/luci-theme-opentomato
#svn export https://github.com/haiibo/openwrt-packages/trunk/luci-theme-opentomcat
#svn export https://github.com/haiibo/openwrt-packages/trunk/luci-theme-rosy
#svn export https://github.com/haiibo/openwrt-packages/trunk/mentohust
#svn export https://github.com/haiibo/openwrt-packages/trunk/udp2raw

#svn export https://github.com/immortalwrt/packages/trunk/libs/libcryptopp
#svn export https://github.com/immortalwrt/packages/trunk/devel/go-rice

git_sparse_clone master "https://github.com/x-wrt/com.x-wrt" "x-wrt" natflow lua-ipops luci-app-macvlan

#git_sparse_clone openwrt-21.02 "https://github.com/openwrt/openwrt" "21openwrt" package/libs/mbedtls \
#git_sparse_clone openwrt-21.02 "https://github.com/openwrt/packages" "21packages" \
#net/openvpn utils/cgroupfs-mount utils/coremark net/xray-core net/nginx net/uwsgi net/ddns-scripts admin/netdata
#git_sparse_clone openwrt-21.02 "https://github.com/openwrt/openwrt" "21openwrt" package/libs/mbedtls \

#mv -n openwrt-passwall/* ./ ; rm -Rf openwrt-passwall
#mv -n openwrt-package/* ./ ; rm -Rf openwrt-package

rm -rf ./*/.git & rm -f ./*/.gitattributes
rm -rf ./*/.svn & rm -rf ./*/.github & rm -rf ./*/.gitignore

sed -i \
-e 's?include \.\./\.\./\(lang\|devel\)?include $(TOPDIR)/feeds/packages/\1?' \
-e 's?2. Clash For OpenWRT?3. Applications?' \
-e 's?\.\./\.\./luci.mk?$(TOPDIR)/feeds/luci/luci.mk?' \
-e 's/ca-certificates/ca-bundle/' \
*/Makefile

#sed -i 's/luci-lib-ipkg/luci-base/g' luci-app-store/Makefile
#sed -i "/minisign:minisign/d" luci-app-dnscrypt-proxy2/Makefile
#sed -i 's/+dockerd/+dockerd +cgroupfs-mount/' luci-app-docker*/Makefile
#sed -i '$i /etc/init.d/dockerd restart &' luci-app-docker*/root/etc/uci-defaults/*
sed -i 's/+libcap /+libcap +libcap-bin /' luci-app-openclash/Makefile
#sed -i 's/\(+luci-compat\)/\1 +luci-theme-argon/' luci-app-argon-config/Makefile
#sed -i 's/\(+luci-compat\)/\1 +luci-theme-argonne/' luci-app-argonne-config/Makefile
#sed -i 's/ +uhttpd-mod-ubus//' luci-app-packet-capture/Makefile
#sed -i 's/	ip.neighbors/	luci.ip.neighbors/' luci-app-wifidog/luasrc/model/cbi/wifidog/wifidog_cfg.lua
#sed -i "s/nas/services/g" `grep nas -rl luci-app-fileassistant`
#sed -i "s/NAS/Services/g" `grep NAS -rl luci-app-fileassistant`
#find -type f -name Makefile -exec sed -ri  's#mosdns[-_]neo#mosdns#g' {} \;

bash diy/create_acl_for_luci.sh -a >/dev/null 2>&1
bash diy/convert_translation.sh -a >/dev/null 2>&1

rm -rf create_acl_for_luci.err & rm -rf create_acl_for_luci.ok
rm -rf create_acl_for_luci.warn

exit 0


