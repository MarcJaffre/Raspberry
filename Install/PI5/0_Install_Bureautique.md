------------------------------------------------------------------------------------------------------------------------------------
## <p align='center'> Installation d'un environnement bureautique sous Raspberry PI 5</p>

------------------------------------------------------------------------------------------------------------------------------------
### I. Installation de l'environnement Bureautique
#### X. Mettre à jour le Raspberry
##### 1. Recherche les mises à jour
```bash
clear;
apt update;
```
##### 2. Mise à Niveau des paquets
```bash
clear;
apt upgrade -y;
```

##### 3. Mise à jour du Noyau
```bash
clear;
rpi-update rpi-6.6.y;
```


#### X. Pilote Vidéo
Ce pilote permet d'avoir l'affichage graphique
```bash
clear;
apt install -y gldriver-test;
```

#### X. Xorg
```bash
clear;
apt install -y xorg;
```

#### X. Gestionnaire de Connexion
```bash
clear
apt install --no-install-recommends -y lightdm;
mkdir -p /var/lib/lightdm/data;
chown lightdm:lightdm /var/lib/lightdm/data;
```

#### X. Cinnamon
```bash
clear;
apt install --no-install-recommends -y cinnamon;
apt install --no-install-recommends -y cinnamon-l10n;
apt install --no-install-recommends -y cinnamon-control-center-goa;
apt install --no-install-recommends -y cinnamon-core;
apt install --no-install-recommends -y cinnamon-desktop-environment;
apt install --no-install-recommends -y cinnamon-doc;
apt install --no-install-recommends -y cinnamon-settings-daemon-dev;
apt install --no-install-recommends -y libcinnamon-desktop-dev;
apt install --no-install-recommends -y task-cinnamon-desktop;
```

#### X. XRDP
##### 1. Installation
```bash
clear;
apt install -y xrdp;
adduser xrdp ssl-cert;
```
##### 2. Cinnamon
```bash
clear;
runuser -l marc -c "cat > .Xclients<< EOF
cinnamon
EOF"
runuser -l marc -c "chmod +x .Xclients";
runuser -l marc -c "cat .Xclients";
```

#### X. Raspi-Config
```bash
clear;
raspi-config;
```


<br />

------------------------------------------------------------------------------------------------------------------------------------
### II. Installation des logiciels
#### X.
```bash
clear;
# ========================================================================================
apt install --no-install-recommends -y apt-file;
apt install --no-install-recommends -y apt-transport-https;
# ========================================================================================
apt install --no-install-recommends -y autofs;
# ========================================================================================
apt install --no-install-recommends -y btop;
apt install --no-install-recommends -y ca-certificates;
apt install --no-install-recommends -y bash-completion;
apt install --no-install-recommends -y build-essential;
apt install --no-install-recommends -y cifs-utils;
# ========================================================================================
apt install --no-install-recommends -y curl;
apt install --no-install-recommends -y file-roller;
apt install --no-install-recommends -y gdebi;
apt install --no-install-recommends -y git;
# ========================================================================================
apt install --no-install-recommends -y gnome-disk-utility;
apt install --no-install-recommends -y gnome-calculator;
apt install --no-install-recommends -y gnome-calendar;
apt install --no-install-recommends -y gnome-software;
apt install --no-install-recommends -y gnome-system-monitor;
apt install --no-install-recommends -y gnome-text-editor;
apt install --no-install-recommends -y gnome-terminal;
# ========================================================================================
apt install --no-install-recommends -y gnupg2;
apt install --no-install-recommends -y gparted;
# ========================================================================================
apt install --no-install-recommends -y gvfs;
apt install --no-install-recommends -y gvfs-common;
apt install --no-install-recommends -y gvfs-daemons;
apt install --no-install-recommends -y gvfs-fuse;
# ========================================================================================
apt install --no-install-recommends -y gvfs-libs;
apt install --no-install-recommends -y krita krita-l10n;
# ========================================================================================
apt install --no-install-recommends -y locales
apt install --no-install-recommends -y locales-all;
# ========================================================================================
apt install --no-install-recommends -y lsb-release;
apt install --no-install-recommends -y mugshot;
# ========================================================================================
apt install --no-install-recommends -y nemo-data;
apt install --no-install-recommends -y nemo-fileroller;
apt install --no-install-recommends -y nemo-font-manager;
apt install --no-install-recommends -y nemo-gtkhash;
# ========================================================================================
apt install --no-install-recommends -y neofetch;
apt install --no-install-recommends -y man;
apt install --no-install-recommends -y mplayer;
apt install --no-install-recommends -y net-tools;
# ========================================================================================
apt install --no-install-recommends -y network-manager;
apt install --no-install-recommends -y network-manager-dev;
apt install --no-install-recommends -y network-manager-gnome;
apt install --no-install-recommends -y network-manager-config-connectivity-debian;
# ========================================================================================
apt install --no-install-recommends -y ntfs-3g;
apt install --no-install-recommends -y numlockx;
apt install --no-install-recommends -y openssh-server;
apt install --no-install-recommends -y pavucontrol;
apt install --no-install-recommends -y pulseaudio;
# ========================================================================================
apt install --no-install-recommends -y rhythmbox;
apt install --no-install-recommends -y rhythmbox-plugins;
# ========================================================================================
apt install --no-install-recommends -y ristretto;
# ========================================================================================
apt install --no-install-recommends -y samba;
apt install --no-install-recommends -y samba-common;
# ========================================================================================
apt install --no-install-recommends -y seahorse;
apt install --no-install-recommends -y smbclient;
# ========================================================================================
apt install --no-install-recommends -y smplayer;
apt install --no-install-recommends -y smplayer-l10n;
# ========================================================================================
apt install --no-install-recommends -y software-properties-common;
apt install --no-install-recommends -y sudo;
apt install --no-install-recommends -y timeshift;
apt install --no-install-recommends -y unzip;
apt install --no-install-recommends -y wget;
apt install --no-install-recommends -y xdg-user-dirs;
# ========================================================================================
```

#### X.
```bash
clear;
usermod -aG sudo $(id -n -u 1000);
dpkg-reconfigure keyboard-configuration;
dpkg-reconfigure tzdata;
dpkg-reconfigure locales;
```

#### X.
```bash
clear;
apt install --no-install-recommends -y gtk2-engines;
apt install --no-install-recommends -y gtk2-engines-murrine;
```

#### X.
```bash
clear;
```

#### X.
```bash
clear;
```

#### X.
```bash
clear;
```

#### X.
```bash
clear;
```

#### X.
```bash
clear;
```

#### X.
```bash
clear;
```

#### X.
```bash
clear;
```

#### X.
```bash
clear;
```

#### X.
```bash
clear;
```

#### X.
```bash
clear;
```

#### X.
```bash
clear;
```
