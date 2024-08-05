#!/usr/bin/bash

#####################################################################################################################################################################################################################################################################
# A FAIRE: Rsync Serveur
# Docker Restore :  tar - can-t open /source/warez_Qbittorrent.tar : No such file or directory
#####################################################################################################################################################################################################################################################################

#####################################################################################################################################################################################################################################################################
# Date        : 28-07-2024
# Auteur      : Marc Jaffre
# Description : Automatisation de l-installation de la machine Raspberry. (Pi5 et pi7)
#
# Actions     :
# - Chargement du fichier de configuration
# - Vidage du MotD
# - Modification du mot de passe root
# - Autoriser la connexion SSH au compte Root
# - Configuration de la carte reseau ethernet (eth0)
# - Configuration du depot des sources des paquets
# - Mise a jour de la cle PGP
# - Mise a niveau du système
# - Misea jour de l-eeprom, noyau ...
# - Installation de logiciel Outils
# - Installation de Cockpit et de ses extensions
# - Installation de la decouverte reseau + Fix
# - Montage du stockage sur la machine (NTFS)
# - Installation de Docker et de ses composants
# - Installation et configuration du serveur de fichier
# - Creation du conteneur Portainer
#
# - [FIX] Boot Cgroup (A Checker dans DMESG)
#
#####################################################################################################################################################################################################################################################################

#####################################################################################################################################################################################################################################################################
# Nettoyage de la console #
###########################
clear;

#####################################################################################################################################################################################################################################################################
# Chargement du fichier de configuration #
##########################################
source settings;

#####################################################################################################################################################################################################################################################################
# Configuration de base #
#########################
echo "" > /etc/motd;

#############################0########################################################################################################################################################################################################################################
# Autoriser SSH en root #
#########################
sed -i -e "s/^#PermitRootLogin prohibit-password/PermitRootLogin yes/g" /etc/ssh/sshd_config;
systemctl restart ssh;

#####################################################################################################################################################################################################################################################################
# Nom de machine #
##################
read -p "Quel est le nom de la machine ? " PI_HOSTNAME; hostnamectl set-hostname $PI_HOSTNAME;

#####################################################################################################################################################################################################################################################################
# Configuration de la carte-reseau #
####################################
if [ $(hostname) = PI3 ]; then
echo "# =================================================
#auto $NET_IF
allow-hotplug $NET_IF
iface $NET_IF inet static
  address $NET_PI3_IP
  gateway $NET_PI3_GW
  dns-nameservers $NET_PI3_DNS1 $NET_PI3_DNS2
# =================================================" > /etc/network/interfaces.d/ethernet;
fi

if [ $(hostname) = PI5 ]; then
echo "# =================================================
#auto $NET_IF
allow-hotplug $NET_IF
iface $NET_IF inet static
  address $NET_PI5_IP
  gateway $NET_PI5_GW
  dns-nameservers $NET_PI5_DNS1 $NET_PI5_DNS2
# =================================================" > /etc/network/interfaces.d/ethernet;
fi
systemctl restart networking;

#####################################################################################################################################################################################################################################################################
# Dépôts des logiciels #
########################
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

#####################################################################################################################################################################################################################################################################
# Fix partiel #
###############
apt update 1>/dev/null;
apt install -y debian-archive-keyring;
apt install -f -y;
# apt update --allow-insecure-repositories 1>/dev/null;
# gpg --recv-keys <the-reported-key>
# gpg --export <the-reported-key> | apt-key add -

#####################################################################################################################################################################################################################################################################
# Mise à niveau #
#################
apt upgrade -y;

#####################################################################################################################################################################################################################################################################
# Noyau + EEPROM #
##################
rpi-update;
echo "yes" | rpi-eeprom-update -d -a;
echo "yes" | rpi-update rpi-6.6.y;

#####################################################################################################################################################################################################################################################################
# Installation de paquet #
##########################
apt install -y ca-certificates 1>/dev/null;
apt install -y btop            1>/dev/null;
apt install -y cifs-utils      1>/dev/null;
apt install -y curl            1>/dev/null;
apt install -y git             1>/dev/null;
apt install -y gnupg           1>/dev/null;
apt install -y make            1>/dev/null;
apt install -y ntfs-3g         1>/dev/null;
apt install -y nfs-common      1>/dev/null;
apt install -y qrencode        1>/dev/null;
apt install -y wget            1>/dev/null;
apt install -f -y;

#####################################################################################################################################################################################################################################################################
# Installation Cockpit #
########################
if [ ! -Z $COCKPIT ]; then
  if [ $COCKPIT = 1 ]; then 
    apt install -y cockpit             1>/dev/null;
    #apt install -y cockpit-machines   1>/dev/null;
    #apt install -y cockpit-packagekit 1>/dev/null;
    apt install -y cockpit-pcp         1>/dev/null;
    #apt install -y cockpit-podman     1>/dev/null;
    apt install -y cockpit-storaged    1>/dev/null;
    apt install -y lvm2                1>/dev/null;
    apt install -y realmd              1>/dev/null;
    apt install -y tuned               1>/dev/null;
    apt install -y udisks2-lvm2        1>/dev/null;
    apt install -f -y;

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

    # Activation du service
    systemctl enable --now cockpit;
  fi
fi


#####################################################################################################################################################################################################################################################################
# Montage #
###########
if [ $(hostname) = PI5 ]; then
 # ==============================================================================================================================
  # Point de montage
  mkdir /mnt/Media_{1,2,3,4,5} 2>/dev/null;

  # Ajout de montage
  echo '# ==================================================================================================
LABEL="Media_1"       /mnt/Media_1    ntfs-3g   rw,user,auto,uid=1000,gid=1000,nofail   0       0
LABEL="Media_2"       /mnt/Media_2    ntfs-3g   rw,user,auto,uid=1000,gid=1000,nofail   0       0
LABEL="Media_3"       /mnt/Media_3    ntfs-3g   rw,user,auto,uid=1000,gid=1000,nofail   0       0
LABEL="Media_4"       /mnt/Media_4    ntfs-3g   rw,user,auto,uid=1000,gid=1000,nofail   0       0
LABEL="Media_5"       /mnt/Media_5    ntfs-3g   rw,user,auto,uid=1000,gid=1000,nofail   0       0
# ==================================================================================================' >> /etc/fstab;

  # Mise a jour SystemD
  systemctl daemon-reload;

  # Montage des partitions
  mount -a;
 # ==============================================================================================================================
fi


#####################################################################################################################################################################################################################################################################
# Activation du Control Group #
###############################
# Pour permettre la gestion des ressources, il faut activer les Cgroups (Docker)
if [ $(hostname) = PI5 ]; then
  sed -i -e "s/rootwait/rootwait systemd.unified_cgroup_hierarchy=0 cgroup_enable=memory swapaccount=1 cgroup_memory=1 cgroup_enable=cpuset/g" /boot/firmware/cmdline.txt;
  # cat /proc/cgroups
  # findmnt -lo source,target,fstype,options -t cgroup,cgroup2
  # docker info | grep WARNING;
fi

#####################################################################################################################################################################################################################################################################
# Docker #
##########
if [ $(hostname) = PI5 ]; then

  # =================================================================================================================================================================================================================================================================
  install -m 0755 -d /etc/apt/keyrings;
  curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg;

  # =================================================================================================================================================================================================================================================================
  chmod a+r /etc/apt/keyrings/docker.gpg;
  echo "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null;
  apt update 1>/dev/null;
  apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin;

  # =================================================================================================================================================================================================================================================================
  # Niveau de journalisation (ContainerD)
  sed -i -e "s/\#\[debug\]/\[debug\]/g" /etc/containerd/config.toml;
  sed -i -e "s/\#  level \= \"info\"/  level \= \"warn\"/g" /etc/containerd/config.toml;

  # =================================================================================================================================================================================================================================================================
  # Daemon.json
  cat > daemon.json << EOF
{
  "data-root":  "/var/lib/docker",
  "debug":      false,
  "log-level":  "warn"
}
EOF

  # =================================================================================================================================================================================================================================================================
  # Relance du service:
  systemctl restart docker.socket;
  systemctl restart docker.service;

  # =================================================================================================================================================================================================================================================================
fi

#####################################################################################################################################################################################################################################################################
# Docker-Compose #
##################
if [ $(hostname) = PI5 ]; then
  rm  /usr/local/bin/docker-compose /usr/bin/docker-compose 2>/dev/null;
  curl -L https://github.com/docker/compose/releases/download/v2.29.1/docker-compose-linux-armv7 -o /usr/local/bin/docker-compose 2>/dev/null;
  chmod +x /usr/local/bin/docker-compose;nan  i
  ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose;
fi

#####################################################################################################################################################################################################################################################################
# Docker Volume SnapShot #
##########################
if [ $(hostname) = PI5 ]; then
  SCRIPT="https://raw.githubusercontent.com/junedkhatri31/docker-volume-snapshot/main/docker-volume-snapshot"
  curl -SL $SCRIPT -o /usr/local/bin/docker-volume-snapshot;
  chmod +x /usr/local/bin/docker-volume-snapshot;
fi

#####################################################################################################################################################################################################################################################################
# Retarder Docker #
###################
if [ $(hostname) = PI5 ]; then
 # =============================================================================================================================================================================
  RETARD=$(systemctl list-unit-files --type=mount --state=generated | grep mnt-Media | cut -c 1-20 | xargs -n10)
 # =============================================================================================================================================================================
  sed -i -e "s/time-set.target/time-set.target $RETARD/g" /lib/systemd/system/docker.service;
  sed -i -e "s/network-online.target containerd.service/network-online.target containerd.service $RETARD/g"  /lib/systemd/system/docker.service;
  systemctl daemon-reload;
 # =============================================================================================================================================================================
fi
#After=network-online.target docker.socket firewalld.service containerd.service time-set.target mnt-Media_1.mount mnt-Media_2.mount mnt-Media_3.mount mnt-Media_4.mount mnt-Media_5.mount
#Wants=network-online.target containerd.service                                                 mnt-Media_1.mount mnt-Media_2.mount mnt-Media_3.mount mnt-Media_4.mount mnt-Media_5.mount

#####################################################################################################################################################################################################################################################################
# Serveur de Fichier #
######################
if [ $(hostname) = PI5 ]; then
  # =======================================================================================================================================
  apt install -y samba;
  apt install -y samba-common;
  apt install -y smbclient;
  # Sauvegarde du fichier de base
  mv /etc/samba/smb.conf /etc/samba/smb.conf.old;
  # Partage
  cat > /etc/samba/smb.conf << EOF
[global]
## Browsing/Identification ###
   workgroup = WORKGROUP
   client min protocol = SMB2
   client max protocol = SMB3

#### Networking ####

#### Debugging/Accounting ####
   log file = /var/log/samba/log.%m
   max log size = 1000
   logging = file
   panic action = /usr/share/samba/panic-action %d

####### Authentication #######
   server role = standalone server
   obey pam restrictions = yes
   unix password sync = yes
   passwd program = /usr/bin/passwd %u
   passwd chat = *Enter\snew\s*\spassword:* %n\n *Retype\snew\s*\spassword:* %n\n *password\supdated\ssuccessfully* .
   pam password change = yes
   map to guest = bad user

# ======================= Share Definitions =======================

# =================================================
[homes]
comment                 = Dossier Utilisateurs
browseable              = no
read only               = no
writable                = yes
create mask             = 0700
directory mask          = 0700
guest ok                = no
valid users             = %S
vfs object              = recycle
recycle:repository      = ./Corbeille/%U
recycle:exclude_dir     = Corbeille
recycle:keeptree        = true
recycle:versions        = true

# =================================================
[Docker]
comment                 = Acces au dossier Docker
path                    = /var/lib/docker/volumes
browseable              = no
writable                = yes
read only               = no
valid users             = @users
force user              = root
guest ok                = no
vfs object              = recycle
recycle:repository      = ./Corbeille
recycle:exclude_dir     = Corbeille
recycle:keeptree        = true
recycle:versions        = true

# =================================================
[System]
comment                 = Acces au dossier root
path                    = /
browseable              = yes
writable                = yes
read only               = no
valid users             = marc
force user              = root
guest ok                = no
vfs object              = recycle
recycle:repository      = ./Corbeille
recycle:exclude_dir     = Corbeille
recycle:keeptree        = true
recycle:versions        = true

# =================================================
[Media_1]
comment                 = Acces au dossier Media 1
path                    = /mnt/Media_1
browseable              = yes
writable                = yes
read only               = no
valid users             = @users
force user              = root
guest ok                = no
vfs object              = recycle
recycle:repository      = ./Corbeille
recycle:exclude_dir     = Corbeille
recycle:keeptree        = true
recycle:versions        = true

# =================================================
[Media_2]
comment                 = Acces au dossier Media 2
path                    = /mnt/Media_2
browseable              = yes
writable                = yes
read only               = no
valid users             = @users
force user              = root
guest ok                = no
vfs object              = recycle
recycle:repository      = ./Corbeille
recycle:exclude_dir     = Corbeille
recycle:keeptree        = true
recycle:versions        = true

# =================================================
[Media_3]
comment                 = Acces au dossier Media 3
path                    = /mnt/Media_3/MyArchive
browseable              = yes
writable                = yes
read only               = no
valid users             = @users
force user              = root
guest ok                = no
vfs object              = recycle
recycle:repository      = ./Corbeille
recycle:exclude_dir     = Corbeille
recycle:keeptree        = true
recycle:versions        = true

# =================================================
[Media_4]
comment                 = Acces au dossier Media 4
path                    = /mnt/Media_4
browseable              = yes
writable                = yes
read only               = no
valid users             = @users
force user              = root
guest ok                = no
vfs object              = recycle
recycle:repository      = ./Corbeille
recycle:exclude_dir     = Corbeille
recycle:keeptree        = true
recycle:versions        = true

# =================================================
[Media_5]
comment                 = Acces au dossier Media 5
path                    = /mnt/Media_5
browseable              = yes
writable                = yes
read only               = no
valid users             = @users
force user              = root
guest ok                = no
vfs object              = recycle
recycle:repository      = ./Corbeille
recycle:exclude_dir     = Corbeille
recycle:keeptree        = true
recycle:versions        = true

# ======================= END SAMBA ===============================
EOF

  # Verification
  testparm -s /etc/samba/smb.conf;

  # Creation de l-access Samba
  (echo "admin"; echo "admin") | smbpasswd -a $(id -u -n 1000)

  # Action du compte Samba
  smbpasswd -e $(id -u -n 1000);

  # Relance du service
  systemctl restart smbd;
  # =======================================================================================================================================
fi

#####################################################################################################################################################################################################################################################################
# Decouverte Reseau #
#####################
apt install -y avahi-daemon;
apt install -y wsdd;

# Ecouter que sur eth0 et wlan0 en ipv4 uniquement 
sed -i -e "s/WSDD_PARAMS\=\"\"/WSDD_PARAMS\=\"-i eth0 -4 -i wlan0 -4\"/g" /etc/default/wsdd;


#####################################################################################################################################################################################################################################################################
# Docker - Creation de Portainer #
##################################
if [ $(hostname) = PI5 ]; then
# Portainer.yml
cat > /root/portainer.yml << EOL
################
version: '3.7' #
services:      #
################
#
########################################################
 Portainer:                                            #
  # -------------------------------------------------- #
  image: 'portainer/portainer-ce'                      #
  container_name: 'Portainer'                          #
  network_mode: 'bridge'                               #
  restart: 'always'                                    #
  # -------------------------------------------------- #
  hostname: 'Portainer'                                #
  # -------------------------------------------------- #
  volumes:                                             #
   - '/var/run/docker.sock:/var/run/docker.sock'       #
   - '/etc/localtime:/etc/localtime:ro'                #
   - 'Data:/data'                                      #
  # -------------------------------------------------- #
  ports:                                               #
   - '8000:8000'                                       #
   - '9000:9000'                                       #
   - '9443:9443'                                       #
  # -------------------------------------------------- #
  labels:                                              #
   Cacher: 'Oui'                                       #
########################################################
#
#
########################################################
volumes:                                               #
 Data:                                                 #
  external: false                                      #
########################################################
EOL

# Lancement
docker-compose -f /root/portainer.yml up -d;
fi

#####################################################################################################################################################################################################################################################################
# Portainer #
#############
if [ $(hostname) = PI5 ]; then
  docker-compose -f /root/portainer.yml up -d;
fi

#####################################################################################################################################################################################################################################################################
# Portainer - Fix #
###################
#docker-compose -f /root/portainer.yml down 2>/dev/null;
#sed -i -e "s/192.168.20.2/192.168.20.3/g" /var/lib/docker/volumes/root_Data/_data/portainer.db;
#docker-compose -f /root/portainer.yml up -d;s
