#!/bin/bash
set -e

ROOT_DIR=`realpath $(dirname $0)`
cd $ROOT_DIR

DEPLOY_DIR=/tmp/dist

rm -rf $ROOT_DIR/build

mkdir $ROOT_DIR/build
cd $ROOT_DIR/build
cmake \
    -DBUILD_IPOE_DRIVER=FALSE \
    -DBUILD_VLAN_MON_DRIVER=FALSE \
    -DCMAKE_INSTALL_PREFIX=$DEPLOY_DIR \
    -DKDIR=/usr/src/kernels/3.10.0-1160.66.1.el7.x86_64.debug \
    -DCMAKE_VERBOSE_MAKEFILE=on \
    -DCMAKE_BUILD_TYPE=Debug \
    ..

make -j10
make install

install \
    /lib64/libssl.so.1.1 \
    /lib64/libcrypto.so.1.1 \
    $DEPLOY_DIR/lib64/accel-ppp

cp -rf $ROOT_DIR/start.sh $DEPLOY_DIR
cp -rf $ROOT_DIR/accel-ppp.conf $DEPLOY_DIR
cp -rf $ROOT_DIR/chap-secrets $DEPLOY_DIR