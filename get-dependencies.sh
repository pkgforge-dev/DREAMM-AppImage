#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm \
    libdecor 	   \
    sdl2
#	fluidsynth \
#	pipewire-audio \
#	pipewire-alsa  \
echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano

# Comment this out if you need an AUR package
#make-aur-package PACKAGENAME

# If the application needs to be manually built that has to be done down here
echo "Getting app..."
echo "---------------------------------------------------------------"
case "$ARCH" in # they use AMD64 and ARM64 for the deb links
	x86_64)  deb_arch=x64;;
	aarch64) deb_arch=arm64;;
esac
VERSION=4.0
echo "$VERSION" > ~/version
wget https://dreamm.aarongiles.com/releases/dreamm-$VERSION-linux-$deb_arch.tgz
bsdtar -xvf dreamm-$VERSION-linux-$deb_arch.tgz

mkdir -p ./AppDir/bin
mv -v dreamm ./AppDir/bin
