#!/bin/bash
set -e

ROOT_DIR=`realpath $(dirname $0)`
cd $ROOT_DIR

GDB_FILE=/tmp/a.log

cat <<EOF>$GDB_FILE
set confirm off
set pagination off
set print pretty on
set breakpoint pending on
set logging overwrite on
set logging on
handle SIGUSR1 noprint nostop
set detach-on-fork on
set follow-fork-mode parent
set print inferior-events
set print inferior-events on
set print inferior-events off
set print thread-events off
r
EOF

LD_LIBRARY_PATH=$ROOT_DIR/lib64/accel-ppp

if [ x$1 == xg ]; then
    env \
    LD_LIBRARY_PATH=$LD_LIBRARY_PATH \
    gdb \
    -ex "set args -c $ROOT_DIR/accel-ppp.conf" \
    -x $GDB_FILE \
     $ROOT_DIR/sbin/accel-pppd
else
    env \
    LD_LIBRARY_PATH=$LD_LIBRARY_PATH \
    $ROOT_DIR/sbin/accel-pppd -c $ROOT_DIR/accel-ppp.conf
fi