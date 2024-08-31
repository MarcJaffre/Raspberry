#!/usr/bin/bash

########################################################################################################################
# Auteur   : Marc Jaffre
# Version  : 1.0
# Objectif : Automatisation de deploiement de l-environnement linux
########################################################################################################################

########################################################################################################################
# Nettoyage de la console #
###########################
clear;

########################################################################################################################
# Packages Upgrade #
####################
apt update 1>/dev/null;
apt upgrade -y;

########################################################################################################################
# Kernel Upgrade #
##################
rpi-update rpi-6.6.y;

########################################################################################################################
# User root Group #
###################
usermod -aG sudo $(id -n -u 1000);

########################################################################################################################
# Install Packages #
####################
apt install --no-install-recommends -y apt-file;
apt install --no-install-recommends -y apt-transport-https;
apt install --no-install-recommends -y autofs;
apt install --no-install-recommends -y btop;
apt install --no-install-recommends -y ca-certificates;
apt install --no-install-recommends -y bash-completion;
apt install --no-install-recommends -y build-essential;
apt install --no-install-recommends -y breeze-cursor-theme;
apt install --no-install-recommends -y chameleon-cursor-theme;
apt install --no-install-recommends -y cifs-utils;
apt install --no-install-recommends -y cinnamon;
apt install --no-install-recommends -y cinnamon-l10n;
apt install --no-install-recommends -y cinnamon-control-center-goa;
apt install --no-install-recommends -y cinnamon-core;
apt install --no-install-recommends -y cinnamon-desktop-environment;
apt install --no-install-recommends -y cinnamon-doc;
apt install --no-install-recommends -y cinnamon-settings-daemon-dev;
apt install --no-install-recommends -y curl;
apt install --no-install-recommends -y dmz-cursor-theme;
apt install --no-install-recommends -y file-roller;
apt install --no-install-recommends -y gdebi;
apt install --no-install-recommends -y git;
apt install --no-install-recommends -y gnome-disk-utility;
apt install --no-install-recommends -y gnome-calculator;
apt install --no-install-recommends -y gnome-calendar;
apt install --no-install-recommends -y gnome-software;
apt install --no-install-recommends -y gnome-system-monitor;
apt install --no-install-recommends -y gnome-text-editor;
apt install --no-install-recommends -y gnome-terminal;
apt install --no-install-recommends -y gnupg2;
apt install --no-install-recommends -y gparted;
apt install --no-install-recommends -y gtk2-engines;
apt install --no-install-recommends -y gtk2-engines-murrine;
apt install --no-install-recommends -y gvfs;
apt install --no-install-recommends -y gvfs-backends;
apt install --no-install-recommends -y gvfs-common;
apt install --no-install-recommends -y gvfs-daemons;
apt install --no-install-recommends -y gvfs-fuse;
apt install --no-install-recommends -y gvfs-libs;
apt install --no-install-recommends -y krita;
apt install --no-install-recommends -y krita-l10n;
apt install --no-install-recommends -y libcinnamon-desktop-dev;
apt install --no-install-recommends -y librsvg2-bin;
apt install --no-install-recommends -y lightdm;
apt install --no-install-recommends -y locales
apt install --no-install-recommends -y locales-all;
apt install --no-install-recommends -y lsb-release;
apt install --no-install-recommends -y mugshot;
apt install --no-install-recommends -y nemo-data;
apt install --no-install-recommends -y nemo-fileroller;
apt install --no-install-recommends -y nemo-font-manager;
apt install --no-install-recommends -y nemo-gtkhash;
apt install --no-install-recommends -y neofetch;
apt install --no-install-recommends -y man;
apt install --no-install-recommends -y mplayer;
apt install --no-install-recommends -y net-tools;
apt install --no-install-recommends -y network-manager;
apt install --no-install-recommends -y network-manager-dev;
apt install --no-install-recommends -y network-manager-gnome;
apt install --no-install-recommends -y network-manager-config-connectivity-debian;
apt install --no-install-recommends -y ntfs-3g;
apt install --no-install-recommends -y make;
apt install --no-install-recommends -y numlockx;
apt install --no-install-recommends -y openssh-server;
apt install --no-install-recommends -y pavucontrol;
apt install --no-install-recommends -y pulseaudio;
apt install --no-install-recommends -y qtbase5-dev-tools;
apt install --no-install-recommends -y rhythmbox;
apt install --no-install-recommends -y rhythmbox-plugins;
apt install --no-install-recommends -y ristretto;
apt install --no-install-recommends -y rpd-plym-splash;
apt install --no-install-recommends -y samba;
apt install --no-install-recommends -y samba-common;
apt install --no-install-recommends -y seahorse;
apt install --no-install-recommends -y smbclient;
apt install --no-install-recommends -y smplayer;
apt install --no-install-recommends -y smplayer-l10n;
apt install --no-install-recommends -y software-properties-common;
apt install --no-install-recommends -y sudo;
apt install --no-install-recommends -y task-cinnamon-desktop;
apt install --no-install-recommends -y timeshift;
apt install --no-install-recommends -y unzip;
apt install --no-install-recommends -y wget;
apt install --no-install-recommends -y xcursor-themes;
apt install --no-install-recommends -y xdg-user-dirs;

########################################################################################################################
# Display #
###########
apt install --no-install-recommends -y xorg;
apt install --no-install-recommends -y gldriver-test; # Installer Apres XORG

########################################################################################################################
# Fix Error #
#############
mkdir -p /var/lib/lightdm/data;
chown lightdm:lightdm /var/lib/lightdm/data;

########################################################################################################################
# Wallpaper #
#############
rm -r /tmp/wallpaper 2>/dev/null;
git clone https://github.com/dracula/wallpaper.git /tmp/wallpaper;
mkdir -p /home/$(id -n -u 1000)/Images/Dracula;
mv /tmp/wallpaper/* /home/$(id -n -u 1000)/Images/Dracula;
chown -R $(id -n -u 1000):$(id -n -g 1000) /home/$(id -n -u 1000)/Images;

########################################################################################################################
# Icons #
#########
apt install -y papirus-icon-theme;
wget https://github.com/dracula/gtk/files/5214870/Dracula.zip -O /tmp/Dracula_icon.zip;
unzip /tmp/Dracula_icon.zip -d /usr/share/icons;

########################################################################################################################
# Themes #
##########
wget https://github.com/dracula/gtk/archive/master.zip -O /tmp/Dracula_theme.zip;
unzip /tmp/Dracula_theme.zip -d /usr/share/themes;
mv /usr/share/themes/gtk-master /usr/share/themes/Dracula;

########################################################################################################################
# Theme for SMplayer #
######################
wget -qO- https://raw.githubusercontent.com/PapirusDevelopmentTeam/papirus-smplayer-theme/master/install.sh | sh

########################################################################################################################
# Root #
########
(echo "root:admin") | chpasswd

########################################################################################################################
# MotD #
########
echo "" > /etc /motd;

########################################################################################################################
# Configuration Environment #
#############################
dpkg-reconfigure keyboard-configuration;
dpkg-reconfigure locales;
dpkg-reconfigure tzdata;

########################################################################################################################
