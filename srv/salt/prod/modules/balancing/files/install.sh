#!/bin/bash

cd $1/haproxy-2.4.0
make clean 
make -j $(grep 'processor' /proc/cpuinfo |wc -l)  \
	TARGET=linux-glibc  \
	USE_OPENSSL=1  \
	USE_ZLIB=1  \
	USE_PCRE=1  \
	USE_SYSTEMD=1

make install PREFIX=$1/haproxy





