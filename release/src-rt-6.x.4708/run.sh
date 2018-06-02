#!/bin/sh
#SRC=`pwd`/release/src-rt-6.x.4708

#
# TOOLCHAIN:
#

export PATH=$PATH:/root/advancedtomat/release/src-rt-6.x.4708/toolchains/hndtools-arm-linux-2.6.36-uclibc-4.5.3/bin/
export PATH="$PATH:/sbin"
#echo PATH ???111  $?
# SuSE x64 32bit libs for toolchain
# sudo zypper install libelf1-32bit
# sudo ln -sf /usr/lib/libmpc.so.3 /usr/lib/libmpc.so.2

# Ubuntu 14.04 LTS x64 32bit libs for toolchain

echo CLEAN
make clean

#
# TARGETS:
#

# make V1=$VER- V2=$EXTENDNO r1do	# Custom
make V1=AT-ARM- V2=3.5-140 ea6700z	# Extended

echo "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
echo "NOTE! Max fw size is 15990384 bytes"
echo "Double check it before actual flash"
echo "or you can break the router and you"
echo "will need to reprogram it's flash."

