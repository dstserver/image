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
    nodejs \
    wget \
    curl

wget https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz
mkdir -p $HOME/steamcmd
tar -xvzf steamcmd_linux.tar.gz -C $HOME/steamcmd
rm steamcmd_linux.tar.gz

$HOME/steamcmd/steamcmd.sh\
    +force_install_dir $HOME/dst\
    +login anonymous\
    +app_update 343050 validate\
    +quit

curl -L --output cloudflared.deb https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb
sudo dpkg -i cloudflared.deb
rm cloudflared.deb