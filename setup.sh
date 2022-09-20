#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
dpkg --add-architecture i386

curl -fsSL https://deb.nodesource.com/setup_18.x | bash -

apt-get update
apt-get upgrade -y
apt-get autoremove -f -y

apt-get install -y \
    lib32gcc-s1 \
    lib32stdc++6 \
    libcurl3-gnutls \
    libcurl4-gnutls-dev:i386 \
    nodejs

wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz
mkdir -p ../steamcmd
tar -xvzf steamcmd_linux.tar.gz -C ../steamcmd

# ./steamcmd.sh \
#     +login anonymous
#     +force_install_dir /home/chientrm/steamapps/DST
#     +app_update 343050 validate
#     +quit