#!/bin/bash

PACKAGE_NAME="luci-app-pppoe-server"
VERSION="1.0.0-1"
ARCH="all"
BUILD_DIR="build_tmp"

rm -rf $BUILD_DIR ${PACKAGE_NAME}_${VERSION}_${ARCH}.ipk

mkdir -p $BUILD_DIR/CONTROL
cat <<EOF > $BUILD_DIR/CONTROL/control
Package: $PACKAGE_NAME
Version: $VERSION
Architecture: $ARCH
Maintainer: Khilma Ubaidilah
Depends: rp-pppoe-server, ppp, tc-tiny, kmod-sched-core, kmod-sched-cake, nftables, uhttpd
Section: luci
Category: LuCI
Title: MikroTik-style PPPoE Server with Bandwidth Limit & Isolir
Description: A LuCI management package for PPPoE Server on OpenWrt 24.
EOF

mkdir -p $BUILD_DIR/etc/config
mkdir -p $BUILD_DIR/etc/init.d
mkdir -p $BUILD_DIR/etc/ppp/ip-up.d
mkdir -p $BUILD_DIR/etc/ppp/ip-down.d
mkdir -p $BUILD_DIR/usr/share/luci/menu.d
mkdir -p $BUILD_DIR/usr/share/luci/resources/view/pppoe-server
mkdir -p $BUILD_DIR/www/isolir

cp files/etc/config/pppoe-server $BUILD_DIR/etc/config/
cp files/etc/init.d/pppoe-server $BUILD_DIR/etc/init.d/
cp files/etc/ppp/ip-up.d/99-pppoe-limits $BUILD_DIR/etc/ppp/ip-up.d/
cp files/etc/ppp/ip-down.d/99-pppoe-limits $BUILD_DIR/etc/ppp/ip-down.d/
cp files/usr/share/luci/menu.d/luci-app-pppoe-server.json $BUILD_DIR/usr/share/luci/menu.d/
cp files/usr/share/luci/resources/view/pppoe-server/*.js $BUILD_DIR/usr/share/luci/resources/view/pppoe-server/
cp files/www/isolir/index.html $BUILD_DIR/www/isolir/

chmod +x $BUILD_DIR/etc/init.d/pppoe-server
chmod +x $BUILD_DIR/etc/ppp/ip-up.d/99-pppoe-limits
chmod +x $BUILD_DIR/etc/ppp/ip-down.d/99-pppoe-limits

cd $BUILD_DIR
tar --numeric-owner --owner=0 --group=0 -czf ../control.tar.gz -C CONTROL .
rm -rf CONTROL
tar --numeric-owner --owner=0 --group=0 -czf ../data.tar.gz .
cd ..

echo "2.0" > debian-binary
tar -czf ${PACKAGE_NAME}_${VERSION}_${ARCH}.ipk debian-binary control.tar.gz data.tar.gz

rm -rf debian-binary control.tar.gz data.tar.gz $BUILD_DIR

echo "Selesai! File IPK dibuat: ${PACKAGE_NAME}_${VERSION}_${ARCH}.ipk"
