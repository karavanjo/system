#!/bin/bash
set -e

# tested for
# Debian 8.3
# mapserver 7.0.1

# for libapache2-mod-fastcgi
# need to add these lines to
# /etc/apt/sources.list
#
# deb http://ftp.by.debian.org/debian/ jessie non-free
# deb-src http://ftp.by.debian.org/debian/ jessie non-free
#
# for postgresql 9.4 and postgis 2.1
# aptitude install postgresql-9.4 postgresql-9.4-postgis-2.1

aptitude install cmake libjpeg62 libjpeg62-turbo libcurl4-dev libcurl4-dbg libpcre3 libpcre3-dev libpixman-1-0 libpixman-1-dev libsqlite3-dev libtiff5 libtiff5-dev libjpeg62-turbo-dev libpng12-0 libpng12-dev binutils libxslt1.1 libxslt1-dev libproj-dev libfribidi-bin libcairo2-dev libfcgi swig libfcgi-dev gdal-bin gdal-contrib libgdal-dev libfribidi-bin libfribidi0 libfribidi-dev apache2 apache2-dev apache2-bin libapr1 libapr1-dev libaprutil1 libaprutil1-dev memcached libapache2-mod-fastcgi libapache2-mod-fcgid libfcgi

build_apps {
	mkdir -p /building
	cd /building/

	#geos
	wget http://download.osgeo.org/geos/geos-3.4.2.tar.bz2
	tar xjf geos-3.4.2.tar.bz2
	cd geos-3.4.2
	./configure
	make
	make install
	cd ..

	# proj.4
	wget http://download.osgeo.org/proj/proj-4.9.1.tar.gz
	wget http://download.osgeo.org/proj/proj-datumgrid-1.5.tar.gz
	tar xzf proj-4.9.1.tar.gz
	cd proj-4.9.1/nad
	tar xzf ../../proj-datumgrid-1.5.tar.gz
	cd ..
	./configure
	make
	make install
	cd ..

	# harfbuzz
	wget http://www.freedesktop.org/software/harfbuzz/release/harfbuzz-0.9.26.tar.bz2
	tar xf harfbuzz-0.9.26.tar.bz2
	cd harfbuzz-0.9.26
	./configure
	make
	make install
	ldconfig
	cd ../

	# mapserver
	wget https://github.com/mapserver/mapserver/archive/rel-7-0-1.zip
	unzip rel-7-0-1.zip
	cd mapserver-rel-7-0-1
	mkdir build
	cd build

	cmake .. -DCMAKE_PREFIX_PATH="/usr/share/;/usr/local/lib/;/usr/lib/;/usr/lib/x86_64-linux-gnu/;/usr/bin/;/usr/include/gdal/" \
	-DWITH_PERL=ON \
	-DWITH_PYTHON=ON \
	-DWITH_PROJ=ON \
	-DWITH_HARFBUZZ=ON \
	-DWITH_CLIENT_WFS=ON \
	-DWITH_CLIENT_WMS=ON \
	-DWITH_CURL=ON \
	-DWITH_PYTHON=ON \
	-DWITH_ICONV=ON \
	-DWITH_CAIRO=ON \
	-DWITH_FCGI=ON \
	-DWITH_GEOS=ON \
	-DWITH_POSTGIS=ON \
	-DWITH_GDAL=ON \
	-DWITH_OGR=ON \
	-DWITH_WFS=ON \
	-DWITH_LIBXML2=ON \
	-DWITH_GIF=ON \
	-DWITH_XMLMAPFILE=ON

	make
	make install
	cd ../..

	#mapcache
	wget https://github.com/mapserver/mapcache/archive/rel-1-4-1.zip
	unzip rel-1-4-1.zip
	cd mapcache-rel-1-4-1
	mkdir build
	cd build
	cmake ..
	make
	make install
	cd ../..

	ldconfig

	a2enmod fastcgi
	a2enmod cgi
}

build_apps