#!/bin/bash

##install kernel module dependencies

sudo eopkg install make gcc g++ git cmake pkg-config linux-current-headers libelf-devel

##build kernel modules

cd /tmp
mkdir buildspace
cd buildspace
git clone --recursive https://github.com/anbox/anbox.git
##build/install binder
cd anbox/kernel/binder
make
sudo make install
##build/install ashmem
cd ../ashmem
make
sudo make install

#build/install gmock (required for dbus-cpp
cd /tmp/buildspace
mkdir gmock && cd gmock
wget https://github.com/google/googletest/archive/release-1.8.0.tar.gz
tar xvf release-1.8.0.tar.gz
cd googletest-release-1.8.0/googlemock
cmake .
make
sudo make install
# issue here is the gmock.pc (pkgconfig file) isn't generated

cd /tmp/buildspace
mkdir dbus-cpp && cd dbus-cpp
wget https://launchpad.net/ubuntu/+archive/primary/+files/dbus-cpp_5.0.0+18.04.20171031.orig.tar.gz
tar xvf dbus-cpp_5.0.0+18.04.20171031.orig.tar.gz
wget https://aur.archlinux.org/cgit/aur.git/plain/boost-asio-1-66.patch?h=dbus-cpp -O boost-asio-1-66.patch
patch -Np1 -i boost-asio-1-66.patch
cmake .

	#build and install kernel modules
	#apply kernel patches

##install anbox dependencies via eopkg

#sudo eopkg install lxc dbus dbus-devel protobuf protobuf-devel gtest-devel libboost libboost-devel libcap2-devel sdl2-devel sdl2-image-devel glib2-devel mesalib mesalib-devel

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

#cd /tmp/buildspace/anbox
#mkdir build
#cd build
#cmake ..
#make
#make install

## OR USE SNAP

sudo eopkg install snapd
snap install snapcraft
snap install lxd

lxd init #as root

#sudo does not work here
#sudo bash -c " " does not work here

cd /tmp/buildspace/anbox
snapcraft --cleanbuild

##get android image

cd /tmp/buildspace/
wget https://build.anbox.io/android-images/2017/07/13/android_3_amd64.img
mv android_3_amd64.img /usr/share/anbox/

##generate .desktop file if necessary
