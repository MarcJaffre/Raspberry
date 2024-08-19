----------------------------------------------------------------------------------------------------------------------------------------------------------------
## <p align='center'> Installation et configuration d'un Raspberry PI 5</p>

----------------------------------------------------------------------------------------------------------------------------------------------------------------
### I. Présentation
#### A. Information Système
```
Pour lire les médias sur PC, il faut Jellyfin Media Player pour avoir une charge machine faible.
```

<br />

----------------------------------------------------------------------------------------------------------------------------------------------------------------
### II. Installation du système d'exploitation
#### A. Télécharger Raspberry Pi imager
Aller sur le site de Raspberry ([ici](https://www.raspberrypi.com/software/)) puis télécharger la version de Raspberry Imager.

#### B. Raspberry Pi imager
Sélectionner  `Raspeberry PI 5` > `Raspberry PI OS Lite (64 Bit)` > `SD Card`.


<p align='center'> <img src='https://github.com/user-attachments/assets/2038da19-2744-4359-abc3-f29c5c1aeed5' /> </p>


#### X. Personnalisation de l'OS
Lors de l'écrasement du système d'exploitation, il existe le menu `Modifer Réglage` qui permet de pré-paramétrer l'OS.

Le raspberry sera connecter en câble RJ45, il ne sera pas donc nécessaire de le connecter au WIFI

```
[Général]
- Nom d'hôte      : PI5
- Utilisateur     : XXXXXXXX
- Mot de passe    : YYYYYYYY
- Nom du WIFI     : --------
- Clé SSID        : --------
- Pays WIFI       : FR
- Fuseau Horaire  : Europe/Paris
- Type de clavier : FR

[Services]
- Activer SSH     : Oui (Utiliser un mot de passe pour l'authentification)

[Options]
- Activer la télémétire : Non
```

<br />

----------------------------------------------------------------------------------------------------------------------------------------------------------------
### III. Configuration
#### X. Information
La configuration du Raspberry peut se faire dans la console du Rasbperry mais avec le protocole SSH on peut se connecter à distance et le configurer par la même occasion.

#### X. Obtenir l'adresse IP du Raspberry
```bash
clear;
 ip add show eth0 | grep "inet " | cut -d "/" -f 1 | cut -d "t" -f 2 | cut -c 2-50
```

#### X. Se connecter en SSH
La connexion se fait via l'utilisateur car l'accès SSH via le compte root est bloquer par défaut
```bash
ssh <USER>@<IP>
```

#### X. Se connecter en admin
```bash
clear;
sudo -i;
```

#### X. Mot de passe root
```bash
clear;
(echo "root:admin") | chpasswd
```

#### X. SSH (root)
```bash
clear;
sed -i -e "s/^#PermitRootLogin prohibit-password/PermitRootLogin yes/g" /etc/ssh/sshd_config;
systemctl restart ssh;
```

#### X. Configuration de la Carte-réseau (eth0)
```bash
clear;
echo "#############################################
# Configuration Eth0 #
######################
auto eth0
allow-hotplug eth0
iface eth0 inet static
  address         192.168.20.3/24
  gateway         192.168.20.1
  dns-nameservers 192.168.20.1 8.8.8.8
#############################################" > /etc/network/interfaces.d/eth0;
systemctl restart networking;
```

#### X. Gestion des dépôts linux 

```bash
clear;
source /etc/os-release;

if [ $VERSION_CODENAME = bookworm ]; then
echo "################################################################################################################
# Generique #
#############
deb      http://deb.debian.org/debian           $VERSION_CODENAME           main contrib non-free non-free-firmware
#deb-src http://deb.debian.org/debian           $VERSION_CODENAME           main contrib non-free non-free-firmware

################################################################################################################
# Security #
############
deb      http://deb.debian.org/debian-security/ $VERSION_CODENAME-security  main contrib non-free non-free-firmware
#deb-src http://deb.debian.org/debian-security/ $VERSION_CODENAME-security  main contrib non-free non-free-firmware

################################################################################################################
# Updates #
###########
deb      http://deb.debian.org/debian           $VERSION_CODENAME-updates   main contrib non-free non-free-firmware
#deb-src http://deb.debian.org/debian           $VERSION_CODENAME-updates   main contrib non-free non-free-firmware
################################################################################################################" > /etc/apt/sources.list;
fi

# Key GPG:
apt install -y debian-archive-keyring;
apt update 1>/dev/null;

# apt update --allow-insecure-repositories 1>/dev/null;
# gpg --recv-keys <the-reported-key>
# gpg --export <the-reported-key> | apt-key add -
```

#### X. Paquets
```bash
clear;
apt install -y avahi-daemon;
apt install -y ca-certificates;
apt install -y btop;
apt install -y cifs-utils;
apt install -y curl;
apt install -y git;
apt install -y gnupg;
apt install -y make;
apt install -y ntfs-3g;
apt install -y nfs-common;
apt install -y qrencode;
apt install -y samba;
apt install -y samba-common;
apt install -y smbclient;
apt install -y wget;
apt install -y wsdd;
```



#### X. Mise à jour des paquets du Raspberry
```bash
clear;
apt upgrade -y;
```

#### X. Mise à jour du Raspberry (Boot, [Noyau](https://github.com/raspberrypi/linux) ...)
```bash
clear;
rpi-update;
echo "yes" | rpi-eeprom-update -d -a;
echo "yes" | rpi-update rpi-6.6.y;
```

#### X. Création d'un utilisateur
L'utilisateur n'aura pas son propre groupe mais il appartiendra à `users`. On génére le mot de passe crypter puis on crée l'utilisateur
```bash
clear;
USER_UID="1001"
USER_COMMENT="Drthrax74"
USER_NAME="drthrax74"
USER_PASS="admin"
USER_SHELL="/usr/bin/bash"

ENCRYPT=$(echo $USER_PASS | openssl passwd -6 -stdin)
/usr/sbin/userdel -rf ${USER_NAME} 2>/dev/null;
/usr/sbin/useradd --base-dir /home/${USER_NAME} --comment "${USER_COMMENT}" --home-dir /home/${USER_NAME} --groups users  --create-home --password ${ENCRYPT} --shell ${USER_SHELL}  --uid ${USER_UID}  --no-user-group  ${USER_NAME};
```


#### X. WSDD
```bash
clear;
sed -i -e "s/WSDD_PARAMS\=\"\"/WSDD_PARAMS\=\"-i eth0 -4 -i wlan0 -4\"/g" /etc/default/wsdd;
```

#### X. Services
```bash
clear;
systemctl enable --now avahi-daemon.service;
systemctl enable --now wsdd;
```

#### X. Montage des disques-dur
Le FSTAB sera regénéré via ce script.
```bash
clear;
PART_FIRM=$(blkid | grep bootfs | xargs -n 1 | grep PART | cut -d "=" -f 2)
PART_ROOT=$(blkid | grep rootfs | xargs -n 1 | grep PART | cut -d "=" -f 2)

# ========================================================================================================================
cat /etc/fstab > /etc/fstab.old;
mkdir /mnt/Media_{1,2,3,4,5} 2>/dev/null;
# ========================================================================================================================
cat > /etc/fstab << EOF
####################################################################################################
# Raspberry #
#############
proc                  /proc           proc      defaults                                0       0
PARTUUID=$PART_FIRM  /boot/firmware  vfat      defaults                                0       2
PARTUUID=$PART_ROOT  /               ext4      defaults,noatime                        0       1

####################################################################################################
# Disques #
###########
LABEL="Media_1"       /mnt/Media_1    ntfs-3g   rw,user,auto,uid=1000,gid=1000,nofail   0       0
LABEL="Media_2"       /mnt/Media_2    ntfs-3g   rw,user,auto,uid=1000,gid=1000,nofail   0       0
LABEL="Media_3"       /mnt/Media_3    ntfs-3g   rw,user,auto,uid=1000,gid=1000,nofail   0       0
LABEL="Media_4"       /mnt/Media_4    ntfs-3g   rw,user,auto,uid=1000,gid=1000,nofail   0       0
LABEL="Media_5"       /mnt/Media_5    ntfs-3g   rw,user,auto,uid=1000,gid=1000,nofail   0       0

####################################################################################################
# SWAP #
########
# Aucune partition Swap est present dans le FSTAB
# La partition Swap est gere par les commandes : dphys-swapfile swap[on|off]
EOF

systemctl daemon-reload;
mount -a;

cat /etc/fstab;
echo "";
echo "";
echo "####################################################################################################";
echo "# Etat du montage #";
echo "###################";
df -h | grep "Mounte\|/mnt/Media\|p1\|p2";
```


#### X. Configuration du SWAP
La valeur du Swap par défaut est de 201. (Stocké: /var/swap)
```bash
clear;
SWAP_OLD=$(grep CONF_SWAPSIZE /etc/dphys-swapfile | cut -d "=" -f2)
SWAP_NEW=201

# Editer
sed -i -e "s/$SWAP_OLD/$SWAP_NEW/g" /etc/dphys-swapfile;

# Detruire le Swap
dphys-swapfile swapoff  1>/dev/null;

# Creation du Swap
dphys-swapfile setup 1>/dev/null;

# Activation du Swap
dphys-swapfile swapon 1>/dev/null;


if [ $SWAP_NEW = "0" ]; then
  echo "La valeur du Swap est de $SWAP_NEW Mo";
  systemctl disable --now dphys-swapfile.service 2>/dev/null;
fi

if [ "$SWAP_NEW" != "0" ]; then
  systemctl enable --now dphys-swapfile.service 2>/dev/null;
  echo "####################################################################################";
  free -h | grep -v "Mem";
  echo "";
  echo "####################################################################################";
  echo ""
fi
```


#### X. Check Codec 
```bash
clear;
for codec in H264 H265 HEVC MJPG MPG2 MPG4 WMV9 WVC1 ; do echo -e "$codec:\t$(vcgencmd codec_enabled $codec)" ; done
```

```
H264:   H264=disabled
H265:   H265=disabled
HEVC:   HEVC=disabled
MJPG:   MJPG=disabled
MPG2:   MPG2=disabled
MPG4:   MPG4=disabled
WMV9:   WMV9=disabled
WVC1:   WVC1=disabled
```


<br />

----------------------------------------------------------------------------------------------------------------------------------------------------------------
### IV. Samba
#### A. Sauvegarde du fichier original
```bash
clear;
mv /etc/samba/smb.conf /etc/samba/smb.conf.old;
```
#### B. Création des partages
```bash
clear;

cat > /etc/samba/smb.conf << EOF
[global]
## Browsing/Identification ###
   workgroup           = WORKGROUP
   client min protocol = SMB2
   client max protocol = SMB3

#### Networking ####

#### Debugging/Accounting ####
   log file = /var/log/samba/log.%m
   max log size = 1000
   logging      = file
   panic action = /usr/share/samba/panic-action %d

####### Authentication #######
   server role = standalone server
   obey pam restrictions = yes
   unix password sync    = yes
   passwd program        = /usr/bin/passwd %u
   passwd chat           = *Enter\snew\s*\spassword:* %n\n *Retype\snew\s*\spassword:* %n\n *password\supdated\ssuccessfully* .
   pam password change   = yes
   map to guest          = bad user

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
recycle:exclude         = *.TMP *.tmp *.temp ~$* *.log
recycle:exclude_dir     = Corbeille
recycle:keeptree        = true
recycle:repository      = ./Corbeille
recycle:versions        = true

# =================================================
[Docker]
comment                 = Acces au dossier Media 5
path                    = /var/lib/docker/volumes
browseable              = yes
writable                = yes
read only               = no
valid users             = @users
force user              = root
guest ok                = no
vfs object              = recycle
recycle:exclude         = *.TMP *.tmp *.temp ~$* *.log
recycle:exclude_dir     = Corbeille
recycle:keeptree        = true
recycle:repository      = ./Corbeille
recycle:versions        = true

# =================================================
[System]
comment                 = Acces au dossier root
path                    = /
browseable              = yes
writable                = yes
read only               = no
valid users             = @users
force user              = root
guest ok                = no
vfs object              = recycle
recycle:exclude         = *.TMP *.tmp *.temp ~$* *.log
recycle:exclude_dir     = Corbeille
recycle:keeptree        = true
recycle:repository      = ./Corbeille
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
recycle:exclude         = *.TMP *.tmp *.temp ~$* *.log
recycle:exclude_dir     = Corbeille
recycle:keeptree        = true
recycle:repository      = ./Corbeille
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
recycle:exclude         = *.TMP *.tmp *.temp ~$* *.log
recycle:exclude_dir     = Corbeille
recycle:keeptree        = true
recycle:repository      = ./Corbeille
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
recycle:exclude         = *.TMP *.tmp *.temp ~$* *.log
recycle:exclude_dir     = Corbeille
recycle:keeptree        = true
recycle:repository      = ./Corbeille
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
recycle:exclude         = *.TMP *.tmp *.temp ~$* *.log
recycle:exclude_dir     = Corbeille
recycle:keeptree        = true
recycle:repository      = ./Corbeille
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
recycle:exclude         = *.TMP *.tmp *.temp ~$* *.log
recycle:exclude_dir     = Corbeille
recycle:keeptree        = true
recycle:repository      = ./Corbeille
recycle:versions        = true

# ======================= END SAMBA ===============================
EOF
```
#### C. Validation de la configuration
```bash
clear;
testparm -s /etc/samba/smb.conf;
```

#### D. Création de l'utilisateur Samba
```bash
clear;
(echo "admin"; echo "admin") | smbpasswd -a $(id -u -n 1000);
```

#### E. Adctivation du compte
```bash
clear;
smbpasswd -e $(id -u -n 1000);
```

#### F. Relance du service
```bash
clear;
systemctl restart smbd;
```

<br />

----------------------------------------------------------------------------------------------------------------------------------------------------------------
### V. Docker, Docker-Compose et Docker volume Snapshot

#### X. Déploiement de Docker
```bash
clear;
install -m 0755 -d /etc/apt/keyrings;
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg;
chmod a+r /etc/apt/keyrings/docker.gpg;
echo "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
apt update 1>/dev/null;
apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin;
```

#### X. Déploiement de Docker-Compose
```bash
clear;
wget "https://github.com/docker/compose/releases/download/v2.28.1/docker-compose-$(uname -s)-$(uname -m)" -O /usr/local/bin/docker-compose 2>/dev/null;
chmod +x /usr/local/bin/docker-compose;
```

#### X. Déploiement Docker Volume Snapshot
```bash
clear;
SCRIPT="https://raw.githubusercontent.com/junedkhatri31/docker-volume-snapshot/main/docker-volume-snapshot"
curl -SL $SCRIPT -o /usr/local/bin/docker-volume-snapshot 2>/dev/null;
chmod +x /usr/local/bin/docker-volume-snapshot;
```

#### X. Retarder le service Docker
```bash
RETARD=$(systemctl list-unit-files --type=mount --state=generated | grep mnt-Media | cut -c 1-20 | xargs -n10)
sed -i -e "s/time-set.target/time-set.target $RETARD/g" /lib/systemd/system/docker.service;
sed -i -e "s/network-online.target containerd.service/network-online.target containerd.service $RETARD/g"  /lib/systemd/system/docker.service;
systemctl daemon-reload;
```

#### X. Afficher la consommation
La commande est `stats_docker`
```bash
clear;
cat > /usr/sbin/stats_docker << EOF
docker stats --format "table {{.Name}}\\t{{.MemUsage}}\\t{{.MemPerc}}\\t{{.CPUPerc}}\\t{{.NetIO}}\\t{{.BlockIO}}"
EOF
chmod +x /usr/sbin/stats_docker;
```

```bash
clear;
stats_docker;
```


#### X. Fonctionnalité
```bash
clear;
grep cgroup_memory /boot/firmware/cmdline.txt 1>/dev/null;

if [ $? = 1 ];then
 sed -i -e "s/rootwait/rootwait systemd.unified_cgroup_hierarchy=0 cgroup_enable=memory swapaccount=1 cgroup_memory=1 cgroup_enable=cpuset/g" /boot/firmware/cmdline.txt;
else
 echo "Le fichier de configuration est OK";
fi;
```

<br />
<br />

----------------------------------------------------------------------------------------------------------------------------------------------------------------

```bash
#clear;
#apt install -y cockpit;
#apt install -y cockpit-machines;
#apt install -y cockpit-packagekit;
#apt install -y cockpit-pcp;
#apt install -y cockpit-podman;
#apt install -y cockpit-storaged;
#apt install -y lvm2;
#apt install -y realmd;
#apt install -y tunes;
#apt install -y udisks2-lvm2;

# Cockpit - Explorateur de fichier
#git clone https://github.com/45Drives/cockpit-navigator.git /tmp/cockpit-navigator 2>/dev/null;
#cd /tmp/cockpit-navigator 1>/dev/null;
#make install;
#
# Cockpit - Partages
#wget https://github.com/45Drives/cockpit-file-sharing/releases/download/v3.2.9/cockpit-file-sharing_3.2.9-2focal_all.deb -O /tmp/cockpit-file-sharing.deb 2>/dev/null;
#dpkg -i /tmp/cockpit-file-sharing.deb 1>/dev/null;
#
# Cockpit - Identities
#wget https://github.com/45Drives/cockpit-identities/releases/download/v0.1.12/cockpit-identities_0.1.12-1focal_all.deb -O /tmp/cockpit-identities.deb 2>/dev/null;
#dpkg -i /tmp/cockpit-identities.deb 1>/dev/null;
#
# Allow Root authentication on Cockpit
#sed -i -e "s/^root/#root/g" /etc/cockpit/disallowed-users;
#
# Service
#systemctl enable --now cockpit;
```

<br />

----------------------------------------------------------------------------------------------------------------------------------------------------------------
### VI. Mise en place d'un VPN (Optionnel)
#### A. Déploiement de WIreguard (5 Clients)
```bash
#!/usr/bin/bash

######################################################################################################################
# Nettoyage console #
#####################
clear;

######################################################################################################################
# Interface Physique #
######################
NET="eth0"
IP_NET=$(ip add show $NET | grep "inet " | cut -d "t" -f2 | cut -d "/" -f 1 | cut -c 2-50)

######################################################################################################################
# Wireguard #
#############
WIREGUARD_NETWORK="192.168.100"
DNS="192.168.0.1"
MTU="1420"

######################################################################################################################
# Point de connexion #
######################
ENDPOINT="proxmox74.ddns.net"
PORT="51820"

######################################################################################################################
# Reseaux Autorises #
#####################
ALLOW_NETWORK_1=",192.168.0.0/24"
ALLOW_NETWORK_2=",192.168.1.0/24"
ALLOW_NETWORK_3=""

######################################################################################################################
# Purge Wireguard #
###################
apt autoremove --purge -y wireguard 1>/dev/null 2>/dev/null;
rm -r /etc/wireguard    2>/dev/null;
systemctl daemon-reload 2>/dev/null;

######################################################################################################################
# Installation IPTABLES #
#########################
apt install -y iptables 1>/dev/null;

######################################################################################################################
# Installation de Wireguard #
#############################
apt install -y wireguard 1>/dev/null;
mkdir -p /etc/wireguard  2>/dev/null;

######################################################################################################################
# Generer les Cles #
####################
# Serveur
wg genkey > /tmp/Private; cat /tmp/Private | wg pubkey > /tmp/Public
SERVER_PRIVATE=$(cat /tmp/Private)
SERVER_PUBLIC=$(cat /tmp/Public)

# Client 1
wg genkey > /tmp/Private; wg genpsk > /tmp/Preshared; cat /tmp/Private | wg pubkey > /tmp/Public
CLIENT_1_PRIVATE=$(cat /tmp/Private)
CLIENT_1_PUBLIC=$(cat /tmp/Public)
CLIENT_1_PRESHARED=$(cat /tmp/Preshared)

# Client 2
wg genkey > /tmp/Private; wg genpsk > /tmp/Preshared; cat /tmp/Private | wg pubkey > /tmp/Public
CLIENT_2_PRIVATE=$(cat /tmp/Private)
CLIENT_2_PUBLIC=$(cat /tmp/Public)
CLIENT_2_PRESHARED=$(cat /tmp/Preshared)

# Client 3
wg genkey > /tmp/Private; wg genpsk > /tmp/Preshared; cat /tmp/Private | wg pubkey > /tmp/Public
CLIENT_3_PRIVATE=$(cat /tmp/Private)
CLIENT_3_PUBLIC=$(cat /tmp/Public)
CLIENT_3_PRESHARED=$(cat /tmp/Preshared)

# Client 4
wg genkey > /tmp/Private; wg genpsk > /tmp/Preshared; cat /tmp/Private | wg pubkey > /tmp/Public
CLIENT_4_PRIVATE=$(cat /tmp/Private)
CLIENT_4_PUBLIC=$(cat /tmp/Public)
CLIENT_4_PRESHARED=$(cat /tmp/Preshared)

# Client 5
wg genkey > /tmp/Private; wg genpsk > /tmp/Preshared; cat /tmp/Private | wg pubkey > /tmp/Public
CLIENT_5_PRIVATE=$(cat /tmp/Private)
CLIENT_5_PUBLIC=$(cat /tmp/Public)
CLIENT_5_PRESHARED=$(cat /tmp/Preshared)

######################################################################################################################
# Autoriser le Forwarding #
###########################
sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g' /etc/sysctl.conf; /usr/sbin/sysctl -p 1>/dev/null;

######################################################################################################################
# Configuration de Wireguard #
##############################
echo "$SERVER_PUBLIC"  > /etc/wireguard/publickey;
echo "$SERVER_PRIVATE" > /etc/wireguard/privatekey;

echo "########################################################################################################
# Serveur #
###########
[Interface]
Address    = ${WIREGUARD_NETWORK}.1/24
ListenPort = ${PORT}
PrivateKey = ${SERVER_PRIVATE}

########################################################################################################
# Pare-Feu #
############
PostUp   = iptables -A FORWARD -i %i -j ACCEPT; iptables -t nat -A POSTROUTING -o ${NET} -j MASQUERADE
PostDown = iptables -D FORWARD -i %i -j ACCEPT; iptables -t nat -D POSTROUTING -o ${NET} -j MASQUERADE

########################################################################################################
# Client 1 #
############
[Peer]
PublicKey    = ${CLIENT_1_PUBLIC}
PresharedKey = ${CLIENT_1_PRESHARED}
AllowedIPs   = ${WIREGUARD_NETWORK}.2/32

########################################################################################################
# Client 2 #
############
[Peer]
PublicKey    = ${CLIENT_2_PUBLIC}
PresharedKey = ${CLIENT_2_PRESHARED}
AllowedIPs   = ${WIREGUARD_NETWORK}.3/32

########################################################################################################
# Client 3 #
############
[Peer]
PublicKey    = ${CLIENT_3_PUBLIC}
PresharedKey = ${CLIENT_3_PRESHARED}
AllowedIPs   = ${WIREGUARD_NETWORK}.4/32

########################################################################################################
# Client 3 #
############
[Peer]
PublicKey    = ${CLIENT_4_PUBLIC}
PresharedKey = ${CLIENT_4_PRESHARED}
AllowedIPs   = ${WIREGUARD_NETWORK}.5/32

########################################################################################################
# Client 3 #
############
[Peer]
PublicKey    = ${CLIENT_5_PUBLIC}
PresharedKey = ${CLIENT_5_PRESHARED}
AllowedIPs   = ${WIREGUARD_NETWORK}.6/32

########################################################################################################" > /etc/wireguard/wg0.conf;

######################################################################################################################
# Permissions #
###############
sudo chmod 600 -R /etc/wireguard/;

######################################################################################################################
# Lancement du service #
########################
systemctl start wg-quick@wg0 2>/dev/null;
systemctl restart wg-quick@wg0;
systemctl enable wg-quick@wg0;

######################################################################################################################
# Generation des configurations Clientes #
##########################################
# --------------------------------------------------------------------------------------
echo "[Interface]
PrivateKey   = ${CLIENT_1_PRIVATE}
Address      = ${WIREGUARD_NETWORK}.2/32
DNS          = ${DNS}
MTU          = ${MTU}
[Peer]
PublicKey    = ${SERVER_PUBLIC}
PresharedKey = ${CLIENT_1_PRESHARED}
AllowedIPs   = 0.0.0.0/0 ${ALLOW_NETWORK_1} ${ALLOW_NETWORK_2} ${ALLOW_NETWORK_3}
Endpoint     = ${ENDPOINT}:${PORT}" > $HOME/client-1.conf;
# --------------------------------------------------------------------------------------
echo "[Interface]
PrivateKey   = ${CLIENT_2_PRIVATE}
Address      = ${WIREGUARD_NETWORK}.3/32
DNS          = ${DNS}
MTU          = ${MTU}
[Peer]
PublicKey    = ${SERVER_PUBLIC}
PresharedKey = ${CLIENT_2_PRESHARED}
AllowedIPs   = 0.0.0.0/0 ${ALLOW_NETWORK_1} ${ALLOW_NETWORK_2} ${ALLOW_NETWORK_3}
Endpoint     = ${ENDPOINT}:${PORT}" > $HOME/client-2.conf;

# --------------------------------------------------------------------------------------
echo "[Interface]
PrivateKey   = ${CLIENT_3_PRIVATE}
Address      = ${WIREGUARD_NETWORK}.4/32
DNS          = ${DNS}
MTU          = ${MTU}
[Peer]
PublicKey    = ${SERVER_PUBLIC}
PresharedKey = ${CLIENT_3_PRESHARED}
AllowedIPs   = 0.0.0.0/0 ${ALLOW_NETWORK_1} ${ALLOW_NETWORK_2} ${ALLOW_NETWORK_3}
Endpoint     = ${ENDPOINT}:${PORT}" > $HOME/client-3.conf;

######################################################################################################################
# Purge #
#########
rm /tmp/Private   2>/dev/null;
rm /tmp/Public    2>/dev/null;
rm /tmp/Preshared 2>/dev/null;

######################################################################################################################
# Nettoyage #
#############
clear;

######################################################################################################################
# Afficher configuration des clients #
######################################
echo "######################################################################";
echo "# Client 1 #";
echo "############";
cat $HOME/client-1.conf;
qrencode -t ansiutf8 < $HOME/client-2.conf;
echo "";
echo "";
echo "######################################################################";
echo "# Client 2 #";
echo "############";
cat $HOME/client-2.conf;
qrencode -t ansiutf8 < $HOME/client-2.conf;
echo "";
echo "";
echo "######################################################################";
echo "# Client 3 #";
echo "############";
cat $HOME/client-3.conf;
qrencode -t ansiutf8 < $HOME/client-2.conf;
echo "";
echo "";
echo "######################################################################";
```
