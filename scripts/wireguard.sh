#!/usr/bin/bash

##########################################################################################################################################
# Auteur      : Marc Jaffre
# Desctiption : Sauvegarde de la configuration VPN
##########################################################################################################################################

##########################################################################################################################################
# Nettoyage de la console #
###########################
clear;

##########################################################################################################################################
# Configuration de la sauvegarde et Restauration #
##################################################
DOSSIER_BACKUP="/mnt/Media_5/Backup/Wireguard"
FICHIER="Wireguard_backup.tar"

##########################################################################################################################################
# Configuration du VPN #
########################

# Information Host:
NET="$(ip addr | grep "^2: " | cut -d ":" -f 2 | cut -c 2-20)"
IP_NET=$(ip add show $NET | grep "inet " | cut -d "t" -f2 | cut -d "/" -f 1 | cut -c 2-50)

# Wireguard
WIREGUARD_NETWORK="192.168.100"

# Client
ENDPOINT="proxmox74.ddns.net"
PORT="51820"
DNS="192.168.0.1"
MTU="1420"
ALLOW_NETWORK_1=",192.168.0.0/24"
ALLOW_NETWORK_2=",192.168.1.0/24"
ALLOW_NETWORK_3=""



##########################################################################################################################################
# Arrêt du service #
####################
systemctl stop wg-quick@wg0 2>/dev/null;


##########################################################################################################################################
func_INSTALL(){
 echo "Installation de Wireguard";
 apt install -y iptables wireguard 1>/dev/null;
 mkdir -p /etc/wireguard  2>/dev/null;
}

func_CONFIG(){
 # =======================================================================================================================
 echo "Generation d'une configuration"

 # =======================================================================================================================
 # Serveur
 wg genkey > /tmp/Private 2>/dev/null;
 cat /tmp/Private | wg pubkey > /tmp/Public 2>/dev/null;
 SERVER_PRIVATE=$(cat /tmp/Private)
 SERVER_PUBLIC=$(cat /tmp/Public)

 # =======================================================================================================================
 # Client 1
 wg genkey > /tmp/Private                   2>/dev/null;
 wg genpsk > /tmp/Preshared                 2>/dev/null;
 cat /tmp/Private | wg pubkey > /tmp/Public 2>/dev/null;
 CLIENT_1_PRIVATE=$(cat /tmp/Private)
 CLIENT_1_PUBLIC=$(cat /tmp/Public)
 CLIENT_1_PRESHARED=$(cat /tmp/Preshared)

 # =======================================================================================================================
 # Client 2
 wg genkey > /tmp/Private                   2>/dev/null;
 wg genpsk > /tmp/Preshared                 2>/dev/null;
 cat /tmp/Private | wg pubkey > /tmp/Public 2>/dev/null;
 CLIENT_2_PRIVATE=$(cat /tmp/Private)
 CLIENT_2_PUBLIC=$(cat /tmp/Public)
 CLIENT_2_PRESHARED=$(cat /tmp/Preshared)

 # =======================================================================================================================
 # Client 3
 wg genkey > /tmp/Private                   2>/dev/null;
 wg genpsk > /tmp/Preshared                 2>/dev/null;
 cat /tmp/Private | wg pubkey > /tmp/Public 2>/dev/null;
 CLIENT_3_PRIVATE=$(cat /tmp/Private)
 CLIENT_3_PUBLIC=$(cat /tmp/Public)
 CLIENT_3_PRESHARED=$(cat /tmp/Preshared)

 # =======================================================================================================================
 # Client 4
 wg genkey > /tmp/Private                   2>/dev/null;
 wg genpsk > /tmp/Preshared                 2>/dev/null;
 cat /tmp/Private | wg pubkey > /tmp/Public 2>/dev/null;
 CLIENT_4_PRIVATE=$(cat /tmp/Private)
 CLIENT_4_PUBLIC=$(cat /tmp/Public)
 CLIENT_4_PRESHARED=$(cat /tmp/Preshared)

 # =======================================================================================================================
 # Client 5
 wg genkey > /tmp/Private                   2>/dev/null;
 wg genpsk > /tmp/Preshared                 2>/dev/null;
 cat /tmp/Private | wg pubkey > /tmp/Public 2>/dev/null;
 CLIENT_5_PRIVATE=$(cat /tmp/Private)
 CLIENT_5_PUBLIC=$(cat /tmp/Public)
 CLIENT_5_PRESHARED=$(cat /tmp/Preshared)

 # =======================================================================================================================
 # Autorisation Forwarding:
 sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g' /etc/sysctl.conf; /usr/sbin/sysctl -p 1>/dev/null;

 # =======================================================================================================================
 # Configuration de Wireguard
 echo "$SERVER_PUBLIC"  > /etc/wireguard/publickey;
 echo "$SERVER_PRIVATE" > /etc/wireguard/privatekey;

 # =======================================================================================================================
 cat > /etc/wireguard/wg0.conf << EOF
####################################################################################################################
# Serveur #
###########
[Interface]
Address    = ${WIREGUARD_NETWORK}.1/24
ListenPort = ${PORT}
PrivateKey = ${SERVER_PRIVATE}

####################################################################################################################
# Pare-Feu #
############
PostUp   = iptables -A FORWARD -i %i -j ACCEPT; iptables -t nat -A POSTROUTING -o ${NET} -j MASQUERADE
PostDown = iptables -D FORWARD -i %i -j ACCEPT; iptables -t nat -D POSTROUTING -o ${NET} -j MASQUERADE

####################################################################################################################
# Client 1 #
############
[Peer]
PublicKey    = ${CLIENT_1_PUBLIC}
PresharedKey = ${CLIENT_1_PRESHARED}
AllowedIPs   = ${WIREGUARD_NETWORK}.2/32

####################################################################################################################
# Client 2 #
############
[Peer]
PublicKey    = ${CLIENT_2_PUBLIC}
PresharedKey = ${CLIENT_2_PRESHARED}
AllowedIPs   = ${WIREGUARD_NETWORK}.3/32

####################################################################################################################
# Client 3 #
############
[Peer]
PublicKey    = ${CLIENT_3_PUBLIC}
PresharedKey = ${CLIENT_3_PRESHARED}
AllowedIPs   = ${WIREGUARD_NETWORK}.4/32

####################################################################################################################
# Client 4 #
############
[Peer]
PublicKey    = ${CLIENT_4_PUBLIC}
PresharedKey = ${CLIENT_4_PRESHARED}
AllowedIPs   = ${WIREGUARD_NETWORK}.5/32

####################################################################################################################
# Client 5 #
############
[Peer]
PublicKey    = ${CLIENT_5_PUBLIC}
PresharedKey = ${CLIENT_5_PRESHARED}
AllowedIPs   = ${WIREGUARD_NETWORK}.6/32

####################################################################################################################
EOF

 # =======================================================================================================================
 # Permission
 chmod 600 -R /etc/wireguard/;

 # =======================================================================================================================
 # Generation des fichiers de configuration clientes
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

# --------------------------------------------------------------------------------------
echo "[Interface]
PrivateKey   = ${CLIENT_4_PRIVATE}
Address      = ${WIREGUARD_NETWORK}.4/32
DNS          = ${DNS}
MTU          = ${MTU}
[Peer]
PublicKey    = ${SERVER_PUBLIC}
PresharedKey = ${CLIENT_4_PRESHARED}
AllowedIPs   = 0.0.0.0/0 ${ALLOW_NETWORK_1} ${ALLOW_NETWORK_2} ${ALLOW_NETWORK_3}
Endpoint     = ${ENDPOINT}:${PORT}" > $HOME/client-4.conf;

# --------------------------------------------------------------------------------------
echo "[Interface]
PrivateKey   = ${CLIENT_5_PRIVATE}
Address      = ${WIREGUARD_NETWORK}.4/32
DNS          = ${DNS}
MTU          = ${MTU}
[Peer]
PublicKey    = ${SERVER_PUBLIC}
PresharedKey = ${CLIENT_5_PRESHARED}
AllowedIPs   = 0.0.0.0/0 ${ALLOW_NETWORK_1} ${ALLOW_NETWORK_2} ${ALLOW_NETWORK_3}
Endpoint     = ${ENDPOINT}:${PORT}" > $HOME/client-5.conf;

 # =======================================================================================================================
 # Nettoyage des fichiers
 rm /tmp/Private   2>/dev/null;
 rm /tmp/Public    2>/dev/null;
 rm /tmp/Preshared 2>/dev/null;
}


func_EDIT(){
 echo "Edition de la configuration";
}

func_CREATE(){
 echo "Création d'une sauvegarde Wireguard";
 tar -czf $DOSSIER_BACKUP/$FICHIER /etc/wireguard /root/client-*.conf;
}

func_RESTORE(){
 echo "Restauration du serveur Wireguard";
  tar -xzf $DOSSIER_BACKUP/$FICHIER -C /
}

case $1 in
   install)
    func_INSTALL;
   ;;
   config)
    func_CONFIG;
   ;;
   edit)
    func_EDIT;
   ;;
   create)
    func_CREATE;
   ;;
   restore)
    func_RESTORE;
   ;;
   *)
   echo "# =================================================== #";
   echo "#           Guide d'utilisation du script             #";
   echo "# =================================================== #";
   echo ""
   echo "# Utilisation: ./backup.sh [OPTION]"
   echo ""
   echo "Option:"
   echo "";
   echo "  install : Déploiement de Wireguard"
   echo "  config  : Generation d'une configuration";
   echo "  edit    : Edition de la configuration";
   echo "  create  : Creation d'une sauvegarde";
   echo "  restore : Restauration de Wireguard"
   echo "";
   echo "# =================================================== #";
   echo "";
   ;;
esac

##########################################################################################################################################
# Lancement du service #
########################
systemctl start wg-quick@wg0 2>/dev/null;

##########################################################################################################################################
