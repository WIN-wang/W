#!/bin/bash

cd /usr/src
rm -rf apr-1.7.0 apr-util-1.6.1 httpd-2.4.48
tar xf apr-1.7.0.tar.gz
tar xf apr-util-1.6.1.tar.gz
tar xf httpd-2.4.48.tar.gz

cd /usr/src/apr-1.7.0
sed -i "/$RM "$cfgfile"/d" configure/
./configure --prefix=/usr/local/apr && make && make install 
cd ../apr-util-1.6.1
./configure --prefix=/usr/local/apr-util --with-apr=/usr/local/apr && make && make install 
cd ../httpd-2.4.48
     ./configure --prefix=/usr/local/apache \
	    --enable-so \
	    --enable-ssl \
	    --enable-cgi \
	    --enable-rewrite \
	    --with-zlib \
	    --with-pcre \
	    --with-apr=/usr/local/apr \
	    --with-apr-util=/usr/local/apr-util/ \
	    --enable-modules=most \
	    --enable-mpms-shared=all \
	    --with-mpm=prefork && \
	    make && make install



