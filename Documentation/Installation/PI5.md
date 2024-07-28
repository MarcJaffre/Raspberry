------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## <p align='center'> Installation et configuration d'un Raspberry PI 5</p>

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
### I. Présentation
#### A. Information Système
```
```

<br />

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
### II. Installation du système d'exploitation
#### A. Télécharger Raspberry Pi imager
Aller sur le site de Raspberry ([ici](https://www.raspberrypi.com/software/)) puis télécharger la version de Raspberry Imager.

#### B. Raspberry Pi imager
Sélectionner  `Raspeberry PI 5` > `Raspberry PI OS Lite (64 Bit)` > `SD Card`.

![image](https://github.com/user-attachments/assets/2038da19-2744-4359-abc3-f29c5c1aeed5)

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

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
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

#### X. Nommage de la machine
```bash
clear;
hostnamectl hostname marc;
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
```
 
#### X. Mise à jour du Raspberry (Boot, [Noyau](https://github.com/raspberrypi/linux) ...)
```bash
clear;
rpi-update;
echo "yes" | rpi-eeprom-update -d -a;
rpi-update rpi-6.6.y;
```

#### X. Mise à jour des paquets du Raspberry
```bash
clear;
apt upgrade -y;
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

#### X. Autoriser le SSH (root)
Modifier la valeur PermitRootLogin. (CTRL + X puis Y puis Entrer)
```bash
clear;
nano /etc/ssh/sshd_config;
```
```
PermitRootLogin yes
```

```bash
clear;
systemctl restart ssh;
```

#### X. Check
```bash
clear;
for codec in H264 MPG2 WVC1 MPG4 MJPG WMV9 HEVC ; do echo -e "$codec:\t$(vcgencmd codec_enabled $codec)" ; done
```
