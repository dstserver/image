#!/bin/bash

export DEBIAN_FRONTEND=noninteractive
sudo dpkg --add-architecture i386

curl -fsSL https://deb.nodesource.com/setup_18.x | bash -

sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get autoremove -f -y

sudo apt-get install -y \
    lib32gcc-s1 \
    lib32stdc++6 \
    libcurl3-gnutls \
    libcurl4-gnutls-dev:i386 \
    nodejs

wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz -P $HOME
mkdir -p $HOME/steamcmd
tar -xvzf $HOME/steamcmd_linux.tar.gz -C $HOME/steamcmd
rm $HOME/steamcmd_linux.tar.gz

# ./steamcmd.sh \
#     +login anonymous
#     +force_install_dir /home/chientrm/steamapps/DST
#     +app_update 343050 validate
#     +quit