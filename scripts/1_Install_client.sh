#!/usr/bin/bash

########################################################################################################################
# Auteur      : Marc Jaffre
# Version     : 1.0
# Objectif    : Automatisation de deploiement de l-environnement linux
# Observation : Decouverte Reseau fonctionnelle
# Source      : https://dustinpfister.github.io/2020/03/27/linux-raspbian-lite-xserver-xorg/
########################################################################################################################



########################################################################################################################
# Nettoyage de la console #
###########################
clear;

########################################################################################################################
# Root #
########
(echo "root:admin") | chpasswd

########################################################################################################################
# SSH #
#######
sed -i -e "s/^#PermitRootLogin prohibit-password/PermitRootLogin yes/g" /etc/ssh/sshd_config;
systemctl restart ssh;

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
# Display #
###########
apt install -y xserver-xorg;
apt install -y xinit;
apt install -y x11-xserver-utils;
apt install -y lightdm;

########################################################################################################################
# Fix - Lightdm #
#################
mkdir -p /var/lib/lightdm/data;
chown lightdm:lightdm /var/lib/lightdm/data;
# - sed -i -e "s/^greeter-session/\#greeter-session/g" /etc/lightdm/lightdm.conf;
# - sed -i -e "s/^user-session/\#user-session/g"       /etc/lightdm/lightdm.conf;


########################################################################################################################
# Software #
############
apt install --no-install-recommends -y apt-file;
apt install --no-install-recommends -y apt-transport-https;
apt install --no-install-recommends -y autofs;
apt install --no-install-recommends -y btop;
apt install --no-install-recommends -y ca-certificates;
#apt install --no-install-recommends -y console-data;
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
# Fix - keymap #
################
wget https://mirrors.edge.kernel.org/pub/linux/utils/kbd/kbd-2.6.4.tar.gz -O /tmp/kbd-2.6.4.tar.gz;
tar xzf /tmp/kbd-2.6.4.tar.gz;
cp -Rp /tmp/kbd-*/data/keymaps/* /usr/share/keymaps/;

########################################################################################################################
# User root Group #
###################
usermod -aG sudo $(id -n -u 1000);

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
# Langue #
##########
# nano /etc/default/keyboard; udevadm trigger --subsystem-match=input --action=change
localectl set-locale LANG=fr_FR.UTF-8
localectl set-keymap fr 
localectl set-x11-keymap --no-convert fr pc105 terminate:ctrl_alt_bksp
localectl status


# Insérer à la ligne 5
sed -i '5i include "mswindows-capslock"' /usr/share/X11/xkb/symbols/fr

# Génération du fichier
echo "// Replicate a \"feature\" of MS Windows on AZERTY keyboards
// where Caps Lock also acts as a Shift Lock on number keys.
// Include keys <AE01> to <AE10> in the FOUR_LEVEL_ALPHABETIC key type.

partial alphanumeric_keys
xkb_symbols \"basic\" {
    key <AE01>	{ type= \"FOUR_LEVEL_ALPHABETIC\", [ ampersand,          1,          bar,   exclamdown ]	};
    key <AE02>	{ type= \"FOUR_LEVEL_ALPHABETIC\", [    eacute,          2,           at,    oneeighth ]	};
    key <AE03>	{ type= \"FOUR_LEVEL_ALPHABETIC\", [  quotedbl,          3,   numbersign,     sterling ]	};
    key <AE04>	{ type= \"FOUR_LEVEL_ALPHABETIC\", [apostrophe,          4,   onequarter,       dollar ]	};
    key <AE05>	{ type= \"FOUR_LEVEL_ALPHABETIC\", [ parenleft,          5,      onehalf, threeeighths ]	};
    key <AE06>	{ type= \"FOUR_LEVEL_ALPHABETIC\", [   section,          6,  asciicircum,  fiveeighths ]	};
    key <AE07>	{ type= \"FOUR_LEVEL_ALPHABETIC\", [    egrave,          7,    braceleft, seveneighths ]	};
    key <AE08>	{ type= \"FOUR_LEVEL_ALPHABETIC\", [    exclam,          8,  bracketleft,    trademark ]	};
    key <AE09>	{ type= \"FOUR_LEVEL_ALPHABETIC\", [  ccedilla,          9,    braceleft,    plusminus ]	};
    key <AE10>	{ type= \"FOUR_LEVEL_ALPHABETIC\", [    agrave,          0,   braceright,       degree ]	};
};"  >  /usr/share/X11/xkb/symbols/mswindows-capslock;
 
#System Locale: LANG=fr_FR.UTF-8
#    VC Keymap: (unset)                
#   X11 Layout: fr
#    X11 Model: pc105
#  X11 Options: terminate:ctrl_alt_bksp

# Verrouillage majuscule :  localectl list-x11-keymap-options

########################################################################################################################
# MotD #
########
echo "" > /etc/motd;


########################################################################################################################
# Complementaire #
##################

# Potentiellement problematique:
# - apt install --no-install-recommends -y xorg;
# - apt install --no-install-recommends -y gldriver-test


########################################################################################################################
