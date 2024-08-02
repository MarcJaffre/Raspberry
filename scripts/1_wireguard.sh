#!/usr/bin/bash

##########################################################################################################################################
# Auteur      : Marc Jaffre
# Date        : 30/07/2024 a 22h21
# Desctiption : Automatisation de la configuration de Wireguard (Installation, Configuration, afficher configuration, .....) 
##########################################################################################################################################

##########################################################################################################################################
# Amélioration:
# - Edition de la configuration 
# - Afficher la configuration en QrCode
# - Versionning des backups
# - Boucle infini
##########################################################################################################################################

##########################################################################################################################################
# Bug potentiel:
# - Pas de garde fou
# - Gestion du service qui fonctionne partiellement .
#
##########################################################################################################################################

##########################################################################################################################################
# Chargement du fichier config #
################################
source settings;

##########################################################################################################################################
# Nettoyage de la console #
###########################
clear;

##########################################################################################################################################
# Maintenance #
###############
#func_EDIT(){
# echo "Edition de la configuration";
#}

#func_QRCODE(){
# echo "Afficher la configuration des clients en QrCode";
# echo ""
# echo "------------------------------------------------------------------"
# qrencode -t ansiutf8 < $HOME/client-1.conf;
# echo ""
# echo "------------------------------------------------------------------"
# qrencode -t ansiutf8 < $HOME/client-2.conf;
# echo ""
# echo "------------------------------------------------------------------"
# qrencode -t ansiutf8 < $HOME/client-3.conf;
# echo ""
# echo "------------------------------------------------------------------"
# qrencode -t ansiutf8 < $HOME/client-4.conf;
# echo ""
# echo "------------------------------------------------------------------"
# qrencode -t ansiutf8 < $HOME/client-5.conf;
# echo ""
# echo "------------------------------------------------------------------"
#}

##########################################################################################################################################
# Installation des paquets #
############################
func_INSTALL(){
 echo "Installation de Wireguard";
 apt install -y iptables wireguard 1>/dev/null;
 mkdir -p /etc/wireguard  2>/dev/null;
}

##########################################################################################################################################
# Sauvegarde de la configuration de Wireguard #
###############################################
func_CREATE(){
 echo "Création d'une sauvegarde Wireguard";
 tar -czf $DOSSIER_BACKUP/$FICHIER /etc/wireguard /root/client-*.conf;
}

##########################################################################################################################################
# Restauration de la configuration de Wireguard #
#################################################
func_RESTORE(){
 echo "Restauration du serveur Wireguard";
 rm -r /etc/wireguard/* 2>/dev/null;
 rm -r /root/client-*   2>/dev/null;
 tar -xzf $DOSSIER_BACKUP/$FICHIER -C /
 chmod 600 /etc/wireguard/*:
}

##########################################################################################################################################
# Afficher la configuration des clients #
#########################################
func_SHOW(){
 echo "Afficher la configuration des clients Wireguard";
 echo "";
 echo "# -------------------------------------------------------------- #"
 echo "# Client 1";
 cat $HOME/client-1.conf;
 echo "";
 echo "# -------------------------------------------------------------- #"
 echo "# Client 2";
 cat $HOME/client-2.conf;
 echo "";
 echo "# -------------------------------------------------------------- #"
 echo "# Client 3";
 cat $HOME/client-3.conf;
 echo "";
 echo "# -------------------------------------------------------------- #"
 echo "# Client 4";
 cat $HOME/client-4.conf;
 echo "";
 echo "# -------------------------------------------------------------- #"
 echo "# Client 5";
 cat $HOME/client-5.conf;
 echo "";
}

##########################################################################################################################################
# Afficher le status du service Wireguard #
###########################################
func_STATUS() {
 echo "Status du service Wireguard";
 systemctl status wg-quick@wg0;
}

##########################################################################################################################################
# Demarrer le service Wireguard #
#################################
func_START() {
 echo "Démarrage du service Wireguard";
 systemctl start wg-quick@wg0;
}

##########################################################################################################################################
# Arreter le service Wireguard #
################################
func_STOP() {
 echo "Arrêt du service Wireguard";
systemctl stop wg-quick@wg0;
}

##########################################################################################################################################
# Activer le service Wireguard #
################################
func_ENABLE() {
 echo "Activation du service Wireguard";
systemctl enable wg-quick@wg0;
}

##########################################################################################################################################
# Desactiver le service Wireguard #
###################################
func_DISABLE() {
 echo "Désactivation du service Wireguard";
systemctl disable wg-quick@wg0;
}


##########################################################################################################################################
# Auto-configuration du serveur (5 clients / 1 server) #
########################################################
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



##########################################################################################################################################
# Menu de sélection #
#####################
case $1 in
   # =================================================================
   config)
    func_CONFIG;
   ;;
   # =================================================================
   create)
    func_CREATE;
   ;;
   # =================================================================
   edit)
    func_EDIT;
   ;;
   # =================================================================
   install)
    func_INSTALL;
   # =================================================================
   ;;
   restore)
    func_RESTORE;
   ;;
   # =================================================================
   qrcode)
    func_QRCODE;
   ;;
   # =================================================================
   show)
    func_SHOW;
   ;;
   # =================================================================
   disable)
    func_DISABLE;
   # =================================================================
   ;;
   enable)
    func_ENABLE;
   ;;
   # =================================================================
   start)
    func_START;
   ;;
   # =================================================================
   status)
    func_STATUS;
   ;;
   # =================================================================
   stop)
    func_STOP;
   ;;  
   # =================================================================
   *)
   echo "# ============================================================= #";
   echo "#                 Guide d'utilisation du script                 #";
   echo "# ============================================================= #";
   echo ""
   echo "# Utilisation: ./backup.sh [OPTION]"
   echo ""
   echo "Option:"
   echo "";
   echo "  install : Déploiement de Wireguard";
   echo "  show    : Afficher la configuration des clients";
   echo "  edit    : Edition de la configuration";
   echo "  create  : Creation d'une sauvegarde";
   echo "  restore : Restauration de Wireguard";
   echo "";
   echo "# ============================================================= #";
   echo "#                          Maintenance                          #";
   echo "# ============================================================= #";
   echo "  status  : Status du serveur Wireguard";
   echo "  start   : Arrête du serveur Wireguard";
   echo "  stop    : Arrête du serveur Wireguard";
   echo "  enable  : Désactive le serveur Wireguard";
   echo "  disable : Désactive le serveur Wireguard";
   #echo "  config  : Generation d'une configuration";
   #echo "  qrcode  :  Afficher la configuration des clients en QrCode";
   echo "";
   echo "# ============================================================= #";
   echo "";
   ;;
   # =================================================================
esac


##########################################################################################################################################
