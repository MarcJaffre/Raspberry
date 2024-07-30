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
  address         192.168.20.2/24
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
apt install -y cockpit;
#apt install -y cockpit-machines;
#apt install -y cockpit-packagekit;
#apt install -y cockpit-podman;
apt install -y cockpit-storaged
apt install -y curl;
apt install -y git;
apt install -y gnupg;
apt install -y lvm2;
apt install -y make;
apt install -y ntfs-3g;
apt install -y nfs-common;
apt install -y qrencode;
apt install -y realmd;
apt install -y samba samba-common;
apt install -y smbclient;
apt install -y tunes;
apt install -y udisks2-lvm2;
apt install -y wget;
apt install -y wsdd;


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

sed -i -e "s/^root/#root/g" /etc/cockpit/disallowed-users;
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
USER_UID="1002"
USER_COMMENT="Drthrax74"
USER_NAME="drthrax74"
USER_PASS="admin"
USER_SHELL="/usr/bin/bash"

ENCRYPT=$(echo $USER_PASS | openssl passwd -6 -stdin)
/usr/sbin/userdel -rf ${USER_NAME};
/usr/sbin/useradd --base-dir /home/${USER_NAME} --comment "${USER_COMMENT}" --home-dir /home/${USER_NAME} --groups users  --create-home --password ${ENCRYPT} --shell ${USER_SHELL}  --uid ${USER_UID}  --no-user-group  ${USER_NAME};
```

#### X. Services
```bash
clear;
systemctl enable --now avahi-daemon.service;
systemctl enable --now cockpit;
systemctl enable --now wsdd;
```

#### X. Montage des disques-dur
```bash
clear;
mkdir /mnt/Media_{1,2,3,4,5};
echo '# ==================================================================================================
LABEL="Media_1"       /mnt/Media_1    ntfs-3g   rw,user,auto,uid=1000,gid=1000,nofail   0       0
LABEL="Media_2"       /mnt/Media_2    ntfs-3g   rw,user,auto,uid=1000,gid=1000,nofail   0       0
LABEL="Media_3"       /mnt/Media_3    ntfs-3g   rw,user,auto,uid=1000,gid=1000,nofail   0       0
LABEL="Media_4"       /mnt/Media_4    ntfs-3g   rw,user,auto,uid=1000,gid=1000,nofail   0       0
LABEL="Media_5"       /mnt/Media_5    ntfs-3g   rw,user,auto,uid=1000,gid=1000,nofail   0       0
# ==================================================================================================' >> /etc/fstab;
systemctl daemon-reload;
mount -a;
df -h | grep "Mounte\|/mnt/Media";
```


#### X. Check Codec 
```bash
clear;
for codec in H264 MPG2 WVC1 MPG4 MJPG WMV9 HEVC ; do echo -e "$codec:\t$(vcgencmd codec_enabled $codec)" ; done
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
comment                 = Acces au dossier Media 5
path                    = /var/lib/docker/volumes
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
[System]
comment                 = Acces au dossier root
path                    = /
browseable              = yes
writable                = yes
read only               = no
valid users             = @♣users
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
```
#### C. Validation de la configuration
```bash
clear;
testparm -s /etc/samba/smb.conf;
```

#### D. Création de l'utilisateur Samba
```bash
clear;
(echo "admin"; echo "admin") | smbpasswd -a $(id -u -n 1000)
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
### V. Mise en place d'un VPN
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


<br />

----------------------------------------------------------------------------------------------------------------------------------------------------------------
### VI. Docker, Docker-Compose et Docker volume Snapshot

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
install -m 0755 -d /etc/apt/keyrings;
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg;
chmod a+r /etc/apt/keyrings/docker.gpg;
echo "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
apt update 1>/dev/null;
apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin;
```

#### X. Déploiement Docker Volume Snapshot
```bash
clear;
SCRIPT="https://raw.githubusercontent.com/junedkhatri31/docker-volume-snapshot/main/docker-volume-snapshot"
curl -SL $SCRIPT -o /usr/local/bin/docker-volume-snapshot;
chmod +x /usr/local/bin/docker-volume-snapshot;
```

<br />

----------------------------------------------------------------------------------------------------------------------------------------------------------------
### VII. Scripts de migrartion

#### X.  Sauvegarde et restauration d'un serveur Docker
Le paramètre `create` permet de lancer la sauvegarde alors que le paramètre `restore` permet la restauration.

```bash
clear;
#/usr/bin/bash

##################################################################################################################################
# Nettoyage de la console #
###########################
clear;

if [ -f /usr/local/bin/docker-volume-snapshot ]; then
 apt install -y curl 1>/dev/null;
 curl -SL https://raw.githubusercontent.com/junedkhatri31/docker-volume-snapshot/main/docker-volume-snapshot -o /usr/local/bin/docker-volume-snapshot;
 chmod +x /usr/local/bin/docker-volume-snapshot;
fi

##################################################################################################################################
# create | restore #
####################
DESTINATION="/mnt/Media_5/Backup/Docker"
ACTION="$1"

##################################################################################################################################
# Nom des volumes #
###################
VOLUME001="database_mariadb"
VOLUME002="filebrowser_Data"
VOLUME003="jellyfin_Data"
VOLUME004="outils_adguardhome_conf"
VOLUME005="outils_adguardhome_work"
VOLUME006="outils_bitwarden"
VOLUME007="outils_nginx_certif"
VOLUME008="outils_nginx_config"
VOLUME009="outils_nginx_data"
VOLUME010="root_Data"
VOLUME011="warez_Jackett"
VOLUME012="warez_Jellyseerr"
VOLUME013="warez_Prowlarr"
VOLUME014="warez_Qbittorrent"
VOLUME015="warez_Qbittorrent_old"
VOLUME016="warez_Radarr"
VOLUME017="warez_Sonarr"
VOLUME018="zabbix-mysql_Data"
VOLUME019="zabbix-server_export"
VOLUME020="zabbix-server_snmptraps"
VOLUME021="zabbix-web_export"
VOLUME022="zabbix-web_snmptraps"

##################################################################################################################################
# Check Root #
##############
if [ $(id -g) = 0 ]; then
 RC=0
else
 echo "Veuiller lancer le script en root";
fi

##################################################################################################################################
# Verification de la variable ACTION #
######################################
if [ -z $ACTION ]; then
 echo "La valeur Action est NULL, fermeture du script"
 exit
fi

##################################################################################################################################
# Execution du script #
#######################

if [ $RC = 0 ]; then
   # ==============================================================================================
   if   [ $ACTION = create ]; then
    echo "------------------------------------------------------------------------------";
    echo "Arret des conteneurs";
    docker stop $(docker ps -a -q) 2>/dev/null;
    echo "------------------------------------------------------------------------------";
    echo "Sauvegardes des volumes";
    rm $DESTINATION/* 2>/dev/null;
    docker-volume-snapshot  create  $VOLUME001  $DESTINATION/$VOLUME001.tar 1>/dev/null;
    docker-volume-snapshot  create  $VOLUME002  $DESTINATION/$VOLUME002.tar 1>/dev/null;
    docker-volume-snapshot  create  $VOLUME003  $DESTINATION/$VOLUME003.tar 1>/dev/null;
    docker-volume-snapshot  create  $VOLUME004  $DESTINATION/$VOLUME004.tar 1>/dev/null;
    docker-volume-snapshot  create  $VOLUME005  $DESTINATION/$VOLUME005.tar 1>/dev/null;
    docker-volume-snapshot  create  $VOLUME006  $DESTINATION/$VOLUME006.tar 1>/dev/null;
    docker-volume-snapshot  create  $VOLUME007  $DESTINATION/$VOLUME007.tar 1>/dev/null;
    docker-volume-snapshot  create  $VOLUME008  $DESTINATION/$VOLUME008.tar 1>/dev/null;
    docker-volume-snapshot  create  $VOLUME009  $DESTINATION/$VOLUME009.tar 1>/dev/null;
    docker-volume-snapshot  create  $VOLUME010  $DESTINATION/$VOLUME010.tar 1>/dev/null;
    docker-volume-snapshot  create  $VOLUME011  $DESTINATION/$VOLUME011.tar 1>/dev/null;
    docker-volume-snapshot  create  $VOLUME012  $DESTINATION/$VOLUME012.tar 1>/dev/null;
    docker-volume-snapshot  create  $VOLUME013  $DESTINATION/$VOLUME013.tar 1>/dev/null;
    docker-volume-snapshot  create  $VOLUME014  $DESTINATION/$VOLUME014.tar 1>/dev/null;
    docker-volume-snapshot  create  $VOLUME015  $DESTINATION/$VOLUME015.tar 1>/dev/null;
    docker-volume-snapshot  create  $VOLUME016  $DESTINATION/$VOLUME016.tar 1>/dev/null;
    docker-volume-snapshot  create  $VOLUME017  $DESTINATION/$VOLUME017.tar 1>/dev/null;
    docker-volume-snapshot  create  $VOLUME018  $DESTINATION/$VOLUME018.tar 1>/dev/null;
    docker-volume-snapshot  create  $VOLUME019  $DESTINATION/$VOLUME019.tar 1>/dev/null;
    docker-volume-snapshot  create  $VOLUME020  $DESTINATION/$VOLUME020.tar 1>/dev/null;
    docker-volume-snapshot  create  $VOLUME021  $DESTINATION/$VOLUME021.tar 1>/dev/null;
    docker-volume-snapshot  create  $VOLUME022  $DESTINATION/$VOLUME022.tar 1>/dev/null;
    echo "Sauvegarde terminé";
    echo "------------------------------------------------------------------------------";
    echo "Démarrage de Portainer";
    docker start Portainer;
    echo "------------------------------------------------------------------------------";
   # ==============================================================================================
   elif [ $ACTION = restore ]; then
    echo "------------------------------------------------------------------------------";
    echo "Arret des conteneurs";
    docker stop $(docker ps -a -q) 2>/dev/null;
    echo "------------------------------------------------------------------------------";
    echo "Restauration des volumes";
    docker-volume-snapshot  restore  $DESTINATION/$VOLUME001.tar  $VOLUME001 1>/dev/null;
    docker-volume-snapshot  restore  $DESTINATION/$VOLUME002.tar  $VOLUME002 1>/dev/null;
    docker-volume-snapshot  restore  $DESTINATION/$VOLUME003.tar  $VOLUME003 1>/dev/null;
    docker-volume-snapshot  restore  $DESTINATION/$VOLUME004.tar  $VOLUME004 1>/dev/null;
    docker-volume-snapshot  restore  $DESTINATION/$VOLUME005.tar  $VOLUME005 1>/dev/null;
    docker-volume-snapshot  restore  $DESTINATION/$VOLUME006.tar  $VOLUME006 1>/dev/null;
    docker-volume-snapshot  restore  $DESTINATION/$VOLUME007.tar  $VOLUME007 1>/dev/null;
    docker-volume-snapshot  restore  $DESTINATION/$VOLUME008.tar  $VOLUME008 1>/dev/null;
    docker-volume-snapshot  restore  $DESTINATION/$VOLUME009.tar  $VOLUME009 1>/dev/null;
    docker-volume-snapshot  restore  $DESTINATION/$VOLUME010.tar  $VOLUME010 1>/dev/null;
    docker-volume-snapshot  restore  $DESTINATION/$VOLUME011.tar  $VOLUME011 1>/dev/null;
    docker-volume-snapshot  restore  $DESTINATION/$VOLUME012.tar  $VOLUME012 1>/dev/null;
    docker-volume-snapshot  restore  $DESTINATION/$VOLUME013.tar  $VOLUME013 1>/dev/null;
    docker-volume-snapshot  restore  $DESTINATION/$VOLUME014.tar  $VOLUME014 1>/dev/null;
    docker-volume-snapshot  restore  $DESTINATION/$VOLUME015.tar  $VOLUME015 1>/dev/null;
    docker-volume-snapshot  restore  $DESTINATION/$VOLUME016.tar  $VOLUME016 1>/dev/null;
    docker-volume-snapshot  restore  $DESTINATION/$VOLUME017.tar  $VOLUME017 1>/dev/null;
    docker-volume-snapshot  restore  $DESTINATION/$VOLUME018.tar  $VOLUME018 1>/dev/null;
    docker-volume-snapshot  restore  $DESTINATION/$VOLUME019.tar  $VOLUME019 1>/dev/null;
    docker-volume-snapshot  restore  $DESTINATION/$VOLUME020.tar  $VOLUME020 1>/dev/null;
    docker-volume-snapshot  restore  $DESTINATION/$VOLUME021.tar  $VOLUME021 1>/dev/null;
    docker-volume-snapshot  restore  $DESTINATION/$VOLUME022.tar  $VOLUME022 1>/dev/null;
    echo "Restauration terminé";
    echo "------------------------------------------------------------------------------";
    echo "Démarrage de Portainer";
    docker start Portainer;
    echo "------------------------------------------------------------------------------";
   else
    echo "Script en anomalie";
   fi
   # ==============================================================================================
fi
```

#### X. Sauvegarde et restauration d'un serveur VPN Wireguard
```bash
#/usr/bin/bash

################################################################################################################
# Description: Sauvegarde et restauration de configuration de Wireguard                                        #
################################################################################################################

################################################################################################################
# Action #
##########
# backup | restore
ACTION="$1"

################################################################################################################
# Configuration du Script #
###########################
DOSSIER="/mnt/Media_5/Backup/Wireguard"
FICHIER="backup.tar.gz"
BACKUP1="/etc/wireguard/"
BACKUP2="/root/client*"


################################################################################################################
# Sauvegarde #
##############
clear;

################################################################################################################
# Restauration #
################

if [ ! -z $ACTION ]; then
# ================================================================================


  if [ $ACTION = backup ]; then
  # ==============================================================================
   echo "Sauvegarde de Wireguard : $DOSSIER/$FICHIER"
   rm $DOSSIER/$FICHIER 2>/dev/null;
   tar -czvf $DOSSIER/$FICHIER $BACKUP1 $BACKUP2 1>/dev/null;

  # ==============================================================================
  elif [ $ACTION = restore ]; then
   echo "Restore de Wireguard     : $DOSSIER/$FICHIER";
   systemctl stop  wg-quick@wg0.service;
   rm /etc/wireguard/*;
   rm /root/client-*;
   tar -xvf /mnt/Media_5/Backup/Wireguard/backup.tar.gz -C /;
   chmod 700 /etc/wireguard/*
   systemctl start  wg-quick@wg0.service;
   systemctl is-enabled  wg-quick@wg0.service;
   wg;
  # ==============================================================================
  else
   echo "Le script est mal configuré";

  # ==============================================================================
  fi

# ================================================================================
fi
```

#### X. Ajouter des volumes CIFS à docker 
```bash
clear;
#!/bin/bash
####################################################################################################################################
# Information:
# Script qui ajout des volumes Docker
# Ces volumes sert a acceder au partage
# Parametres :
# - ,vers=3.0
# - ,file_mode=0777
# - ,dir_mode=0777
####################################################################################################################################
#
#
####################################################################################################################################
# Variables d_environnements #
##############################
# Connexion au serveur de partage
SERVEUR=192.168.20.2
UTILISATEUR=marc
MOTDEPASSE=admin
#
# Nom des partages Samba
PARTAGE_1=Media_1
PARTAGE_2=Media_2
PARTAGE_3=Media_3
PARTAGE_4=Media_4
PARTAGE_5=Media_5
#
# Nom des volumes Docker
NAME_1=Media_1
NAME_2=Media_2
NAME_3=Media_3
NAME_4=Media_4
NAME_5=Media_5

#
####################################################################################################################################
# Suppression des volumes #
###########################
docker volume rm -f ${NAME_1};
docker volume rm -f ${NAME_2};
docker volume rm -f ${NAME_3};
docker volume rm -f ${NAME_4};
docker volume rm -f ${NAME_5};
#
####################################################################################################################################
# Ajout des volumes #
#####################
#
# Partage 1
docker volume create --driver local \
        --opt type=cifs \
        --opt device=//${SERVEUR}/${PARTAGE_1} \
        --opt o=username=${UTILISATEUR},password=${MOTDEPASSE} \
        --name ${NAME_1};

# Partage 2
docker volume create --driver local \
        --opt type=cifs \
        --opt device=//${SERVEUR}/${PARTAGE_2} \
        --opt o=username=${UTILISATEUR},password=${MOTDEPASSE} \
        --name ${NAME_2};
#
# Partage 3
docker volume create --driver local \
        --opt type=cifs \
        --opt device=//${SERVEUR}/${PARTAGE_3} \
        --opt o=username=${UTILISATEUR},password=${MOTDEPASSE} \
        --name ${NAME_3};
#
# Partage 4
docker volume create --driver local \
        --opt type=cifs \
        --opt device=//${SERVEUR}/${PARTAGE_4} \
        --opt o=username=${UTILISATEUR},password=${MOTDEPASSE} \
        --name ${NAME_4};

# Partage 5
docker volume create --driver local \
        --opt type=cifs \
        --opt device=//${SERVEUR}/${PARTAGE_5} \
        --opt o=username=${UTILISATEUR},password=${MOTDEPASSE} \
        --name ${NAME_5};
####################################################################################################################################
```


<br />

----------------------------------------------------------------------------------------------------------------------------------------------------------------
### VIII. Problème et solution
#### X. Docker
##### 1. Jellyfin
The configured user limit (XXXXX) on the number of inotify watches has been reached, or the operating system failed to allocate a required resource.

```bash
clear;
LAST_LINE=$(tail -n 1 /etc/sysctl.conf)

if [ $LAST_LINE = "#kernel.sysrq=438" 2>/dev/null ];then
 echo "fs.inotify.max_user_watches = 524288" >> /etc/sysctl.conf;
 sysctl -p 1>/dev/null;
else
 sysctl -p 1>/dev/null;
 echo "OK"
fi

# sysctl fs.inotify.max_user_watches=524288;
# sysctl -p
```

##### 2a. Available hwaccel types
```
- drm
- opencl
- rkmpp
```

##### 2b. Available decoders
```
 - aac
 - ac3
 - av1
 - av1_rkmp
 - dca
 - flac
 - h264
 - h264_rkmpp
 - hevc
 - hevc_rkmpp
 - libdav1d
 - libvpx
 - libvpx-vp9
 - mp3
 - mpeg1_rkmpp
 - mpeg2video
 - mpeg2_rkmpp
 - mpeg4
 - mpeg4_rkmpp
 - msmpeg4
 - truehd
 - vp8
 - vp8_rkmpp
 - vp9
 - vp9_rkmpp
```

##### 2c. Available filters
```
- alphasrc
- overlay_opencl
- overlay_rkrga
- scale_opencl
- scale_rkrga
- tonemap_opencl
- vpp_rkrga
- zscale
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
