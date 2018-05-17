#!/bin/bash

##install kernel module dependencies

sudo eopkg install make gcc g++ git cmake pkg-config linux-headers

##build kernel modules

cd /tmp
mkdir buildspace
cd buildspace
git clone --recursive https://github.com/anbox/anbox.git
cd anbox/kernel

	#build and install kernel modules
	#apply kernel patches

##install anbox dependencies via eopkg

sudo eopkg install lxc dbus dbus-devel protobuf protobuf-devel gtest-devel libboost libboost-devel libcap2-devel sdl2-devel sdl2-image-devel glib2-devel mesalib mesalib-devel

##build and install anbox dependencies that are not in eopkg

	#libproperties-cpp-dev

		#get source
		#build

	#libglm-dev

		#get source
		#build

	#gmock-devel

		#get source
		#build

##build anbox

cd /tmp/buildspace/anbox
mkdir build
cd build
cmake ..
make
make install

##get android image

cd /tmp/buildspace/
wget https://build.anbox.io/android-images/2017/07/13/android_3_amd64.img
mv android_3_amd64.img /usr/share/anbox/

##generate .desktop file if necessary
