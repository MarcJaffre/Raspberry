#!/usr/bin/bash

#######################################################################################################################################################################################
# Chargement du fichier de configuration #
##########################################
source ./settings

#######################################################################################################################################################################################
# Configuration de base #
#########################
echo "" > /etc/motd;


#######################################################################################################################################################################################
# Autoriser SSH en root #
#########################
sed -i -e "s/^#PermitRootLogin prohibit-password/PermitRootLogin yes/g" /etc/ssh/sshd_config;
systemctl restart ssh;

#######################################################################################################################################################################################
# Configuration de la machine #
###############################


#######################################################################################################################################################################################
# Configuration de la carte-reseau #
####################################
echo "# =================================================
auto eth0
allow-hotplug eth0
iface eth0 inet static
  address         192.168.20.3/24
  gateway         192.168.20.1
  dns-nameservers 192.168.20.1 8.8.8.8
# =================================================" > /etc/network/interfaces.d/eth0;
systemctl restart networking;

#######################################################################################################################################################################################
# Dépôts des logiciels #
########################
clear;
source /etc/os-release;
if [ $VERSION_CODENAME = bookworm ]; then
echo "# ===============================================================================================================================
deb      http://deb.debian.org/debian           $VERSION_CODENAME           main contrib non-free non-free-firmware
#deb-src http://deb.debian.org/debian           $VERSION_CODENAME           main contrib non-free non-free-firmware
deb      http://deb.debian.org/debian-security/ $VERSION_CODENAME-security  main contrib non-free non-free-firmware
#deb-src http://deb.debian.org/debian-security/ $VERSION_CODENAME-security  main contrib non-free non-free-firmware
deb      http://deb.debian.org/debian           $VERSION_CODENAME-updates   main contrib non-free non-free-firmware
#deb-src http://deb.debian.org/debian           $VERSION_CODENAME-updates   main contrib non-free non-free-firmware
# ===============================================================================================================================" > /etc/apt/sources.list;
fi

#######################################################################################################################################################################################
# Fix partiel #
###############
clear;
apt update 1>/dev/null;
apt install -y debian-archive-keyring;

# apt update --allow-insecure-repositories 1>/dev/null;
# gpg --recv-keys <the-reported-key>
# gpg --export <the-reported-key> | apt-key add -

#######################################################################################################################################################################################
# Mise à niveau #
#################
apt upgrade -y;

#######################################################################################################################################################################################
# Noyau + EEPROM #
##################
clear;
rpi-update;
echo "yes" | rpi-eeprom-update -d -a;
echo "yes" | rpi-update rpi-6.6.y;

#######################################################################################################################################################################################
# Installation de paquet #
##########################
clear;
apt install -y avahi-daemon;
apt install -y ca-certificates;
apt install -y btop;
apt install -y cifs-utils;
apt install -y curl;
apt install -y git;
apt install -y gnupg;
apt install -y lvm2;
apt install -y make;
apt install -y ntfs-3g;
apt install -y nfs-common;
apt install -y qrencode;
apt install -y realmd;
apt install -y samba;
apt install -y samba-common;
apt install -y smbclient;
apt install -y tunes;
apt install -y udisks2-lvm2;
apt install -y wget;
apt install -y wsdd;


#######################################################################################################################################################################################
# Installation Cockpit #
########################
apt install -y cockpit;
#apt install -y cockpit-machines;
#apt install -y cockpit-packagekit;
#apt install -y cockpit-podman;
apt install -y cockpit-storaged

# Cockpit - Explorateur de fichier
git clone https://github.com/45Drives/cockpit-navigator.git /tmp/cockpit-navigator 2>/dev/null;
cd /tmp/cockpit-navigator 1>/dev/null;
make install;

# Cockpit - Partages
wget https://github.com/45Drives/cockpit-file-sharing/releases/download/v3.2.9/cockpit-file-sharing_3.2.9-2focal_all.deb -O /tmp/cockpit-file-sharing.deb 2>/dev/null;
dpkg -i /tmp/cockpit-file-sharing.deb 1>/dev/null;

# Cockpit - Identities
wget https://github.com/45Drives/cockpit-identities/releases/download/v0.1.12/cockpit-identities_0.1.12-1focal_all.deb -O /tmp/cockpit-identities.deb 2>/dev/null;
dpkg -i /tmp/cockpit-identities.deb 1>/dev/null;

# Autoriser Root (Cockpit)
sed -i -e "s/^root/#root/g" /etc/cockpit/disallowed-users;


#######################################################################################################################################################################################
# Serveur de Fichier #
######################


#######################################################################################################################################################################################




#######################################################################################################################################################################################
#######################################################################################################################################################################################
#######################################################################################################################################################################################
#######################################################################################################################################################################################
