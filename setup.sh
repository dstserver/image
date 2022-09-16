#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
dpkg --add-architecture i386
apt-get update
apt-get upgrade -y
apt-get autoremove -f -y

apt-get install -y \
    lib32gcc-s1 \
    lib32stdc++6 \
    libcurl3-gnutls \
    libcurl4-gnutls-dev:i386

useradd -m steam
chmod a+rw `tty`
su - steam
mkdir ~/steamcmd
cd ~/steamcmd
wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz
tar -xvzf steamcmd_linux.tar.gz
# ./steamcmd.sh \
#     +login anonymous
#     +force_install_dir /home/steam/steamapps/DST
#     +app_update 343050 validate
#     +quit