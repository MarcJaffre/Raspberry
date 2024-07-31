#!/usr/bin/bash

#################################################################################################################################################
# Bypass #
##########
HOST_SERVEUR="192.168.20.3"
HOST_DOMAINE="Local"
HOST_USERNAME="marc"
HOST_PASSWORD="admin"
HOST_SHARE="Media_5/TEST"
HOST_MOUNTPOINT="/mnt/backup"

#################################################################################################################################################
# Verification #
################
#if [ -z $HOST_SERVEUR     ];then echo "La Valeur Serveur NULL"; fi
#if [ -z $HOST_DOMAINE     ];then echo "La Valeur DOMAINE NULL"; fi
#if [ -z $HOST_PASSWORD    ];then echo "La Valeur PASSWORD NULL"; fi
#if [ -z $HOST_USERNAME    ];then echo "La Valeur USERNAME NULL"; fi
#if [ -z $HOST_SHARE       ];then echo "La Valeur Partage NULL"; fi
#if [ -z $HOST_MOUNTPOINT  ];then echo "La Valeur Point de montage NULL"; fi
#if [ ! -s $HOME/rsync.txt ];then echo "Le fichier rsync.txt est vide"; fi


#################################################################################################################################################
# Menu 0  Adresse du Serveur de partage #
#########################################
func_SRV_ADRESS()  {
  read -p "Quel est l'adresse IP du serveur ? " HOST_SERVEUR HOST_SERVEUR=${HOST_SERVEUR:-192.168.20.3}
}
#################################################################################################################################################
# Menu 1 - Nom du domaine #
###########################
func_SRV_DOMAINE()  {
  read -p "Quel est le nom de domaine ? " HOST_DOMAINE HOST_DOMAINE=${HOST_DOMAINE:-Local}
}
#################################################################################################################################################
# Menu 2 - Nom d'utilisateur #
##############################
func_SRV_USERNAME() {
  read -p "Quel est le nom de compte utilisateur ? " HOST_USERNAME HOST_USERNAME=${HOST_USERNAME:-marc}
}
#################################################################################################################################################
# Menu 3 - Mot de passe #
#########################
func_SRV_PASSWORD() {
  read -p "Quel est le mot de passe du compte utilisateur ? " HOST_PASSWORD HOST_PASSWORD=${HOST_PASSWORD:-admin}
}
#################################################################################################################################################
# Menu 4 - Nom du partage #
###########################
func_SRV_PARTAGE()  {
  read -p "Quel est le nom de partage du serveur ? " HOST_SHARE HOST_SHARE=${HOST_SHARE:-marc}
}
#################################################################################################################################################
# Menu 5 - Point de montage #
#############################
func_HOST_MOUNT1()   {
  read -p "Où souhaitez vous monter le partage sur la machine ? " HOST_MOUNTPOINT HOST_MOUNTPOINT=${HOST_MOUNTPOINT:-/mnt/backup}
}
#################################################################################################################################################
# Menu 6 - Creation du dossier de montage #
###########################################
func_HOST_MKDIR()    {
 # Verification si la variable est NULL
 if [ -z $HOST_MOUNTPOINT   ];then echo  "La Valeur Point de montage NULL"; fi
 #
 # Si le point de montage existe deja
 if [ -d $HOST_MOUNTPOINT   ];then echo  "> Le dossier de montage existe déjà."; fi
 #
 # Si le point de montage n'existe pas
 if [ ! -d $HOST_MOUNTPOINT ];then mkdir -p $HOST_MOUNTPOINT; echo "> Le dossier de montage a ete cree."; fi
 #
 # Pause
 read -p "";
}
#################################################################################################################################################
# Menu 7 - Demontage du partage #
#################################
func_HOST_UMOUNT()   {
 # En cas de variable Vide , message retour
 if [ -z $HOST_SERVEUR     ];then echo "La Valeur Serveur NULL"; fi
 if [ -z $HOST_MOUNTPOINT  ];then echo "La Valeur Point de montage NULL"; fi
 #
 # Eviter des problemes de montage
 systemctl daemon-reload;
 #
 # Creation de Variable ponctuellement (Utile lors du montage
 OPTION="username=$HOST_USERNAME,password=$HOST_PASSWORD"
 SOURCE="//$HOST_SERVEUR/$HOST_SHARE"
 DESTINATION="$HOST_MOUNTPOINT"
 #
 # Si les variables HOST_MOUNTPOINT et HOST_SERVEUR sont pas nul alors, monter le partage
 if [ ! -z "${HOST_MOUNTPOINT}" ] && [ ! -z "${HOST_SERVEUR}" ];then
    mount -t cifs -o $OPTION $SOURCE $DESTINATION 2>/dev/null;
    echo "> Montage du Lecteur réseau terminé";
 fi
 #
 # Pause
 read -p "";
}
####################################################################################################
# Menu 8 - Montage du partage (AD) #
####################################
func_HOST_MOUNT2_AD()  {
 # En cas de variable Vide , message retour
 if [ -z $HOST_SERVEUR     ];then echo "La Valeur Serveur NULL"; fi
 if [ -z $HOST_MOUNTPOINT  ];then echo "La Valeur Point de montage NULL"; fi
 #
 # Eviter des problemes de montage
 systemctl daemon-reload;
 #
 # Creation de Variable ponctuellement (Utile lors du montage
 OPTION="domain=$HOST_DOMAINE,username=$HOST_USERNAME,password=$HOST_PASSWORD"
 SOURCE="//$HOST_SERVEUR/$HOST_SHARE"
 DESTINATION="$HOST_MOUNTPOINT"
 #
 # Si les variables HOST_MOUNTPOINT et HOST_SERVEUR sont pas nul alors, monter le partage
 if [ ! -z "${HOST_MOUNTPOINT}" ] && [ ! -z "${HOST_SERVEUR}" ];then
    mount -t cifs -o $OPTION $SOURCE $DESTINATION 2>/dev/null;
    echo "> Montage du Lecteur réseau terminé";
 fi
 #
 # Pause
 read -p "";
}
