#!/bin/bash

sudo apt-get install git lib32z1 openssh-server

if [ ! -e /etc/udev/rules.d/01-xdk.rules ]; then
  sudo cat >/etc/udev/rules.d/01-xdk.rules <<EOF
# Aarvark I2C/SPI Host Adapter
ACTION=="add", SUBSYSTEM=="usb_device", SYSFS{idVendor}=="0403", SYSFS{idProduct}=="e0d0", MODE="0666"
ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="0403", ATTR{idProduct}=="e0d0", MODE="0666"

# Beagle Protocol Analyzers
ACTION=="add", SUBSYSTEM=="usb_device", SYSFS{idVendor}=="1679", SYSFS{idProduct}=="2001", MODE="0666"
ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="1679", ATTR{idProduct}=="2001", MODE="0666"

# Cheetah SPI Host Adapter
ACTION=="add", SUBSYSTEM=="usb_device", SYSFS{idVendor}=="1679", SYSFS{idProduct}=="2002", MODE="0666"
ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="1679", ATTR{idProduct}=="2002", MODE="0666"

# Komodo CAN Duo Interface
ACTION=="add", SUBSYSTEM=="usb_device", SYSFS{idVendor}=="1679", SYSFS{idProduct}=="3001", MODE="0666"
ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="1679", ATTR{idProduct}=="3001", MODE="0666"

# Power Delivery Analyzers
ACTION=="add", SUBSYSTEM=="usb_device", SYSFS{idVendor}=="1679", SYSFS{idProduct}=="6003", MODE="0666"
ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="1679", ATTR{idProduct}=="6003", MODE="0666"

# Power Delivery Analyzers (Console)
SUBSYSTEM=="tty", ATTRS{idVendor}=="1679", ATTRS{idProduct}=="6003", SYMLINK+="pdaconsole", MODE="0666"

# Power Delivery Analyzers (Update mode)
ACTION=="add",SUBSYSTEM=="usb",ATTR{idVendor}=="0483",ATTR{idProduct}=="df11",MODE="0666"

# Android Devices
SUBSYSTEM=="usb", ATTR{idVendor}=="18d1", ATTR{idProduct}=="d00d", MODE="0660", GROUP="plugdev" 
SUBSYSTEM=="usb", ATTR{idVendor}=="05c6", MODE="0660", GROUP="plugdev" 
SUBSYSTEM=="usb", ATTR{idVendor}=="18d1", ATTR{idProduct}=="4ee7", MODE="0774", GROUP="plugdev" 
SUBSYSTEM=="usb", ATTR{idVendor}=="05c6", ATTR{idProduct}=="901d", MODE="0774", GROUP="plugdev" 

# Olimex
SUBSYSTEM=="usb", ATTRS{idProduct}=="002a", ATTRS{idVendor}=="15ba", GROUP="plugdev", MODE="0666"

# USBboot
SUBSYSTEM=="usb", ATTRS{idProduct}=="2150", ATTRS{idVendor}=="03e7",MODE="0666", ENV{ID_MM_DEVICE_IGNORE}="1" 
SUBSYSTEM=="tty", ATTRS{idProduct}=="2150", ATTRS{idVendor}=="03e7",GROUP="plugdev" ,MODE="0666", ENV{ID_MM_DEVICE_IGNORE}="1"
EOF
fi
sudo udevadm control -R

[ ! -e ~/10imaging ] && mkdir -p ~/10imaging

if [ ! -e ~/10imaging/xdk ]; then
  pushd ~/10imaging
  git clone https://github.com/10imaging/xdk.git
  popd
fi
source ~/10imaging/xdk/xdk.sh
