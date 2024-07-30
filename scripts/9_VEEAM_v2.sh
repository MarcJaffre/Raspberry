#!/usr/bin/bash

########################################################################################################################################################################################
# Nettoyage de la console #
###########################
clear;

########################################################################################################################################################################################
func_HOST_SERVEUR()  {
  read -p "Quel est l'adresse IP du serveur ? " HOST_SERVEUR
  HOST_SERVEUR=${HOST_SERVEUR:-}
}

########################################################################################################################################################################################
func_HOST_DOMAINE()  {
  read -p "Quel est le nom de domaine ? " HOST_DOMAINE
  HOST_DOMAINE=${HOST_DOMAINE:-}
}

########################################################################################################################################################################################
func_HOST_USERNAME() {
  read -p "Quel est le nom de compte utilisateur ? " HOST_USERNAME
  HOST_USERNAME=${HOST_USERNAME:-}
}

########################################################################################################################################################################################
func_HOST_PASSWORD() {
  read -p "Quel est le mot de passe du compte utilisateur ? " HOST_PASSWORD
  HOST_PASSWORD=${HOST_PASSWORD:-}
}
########################################################################################################################################################################################
func_HOST_PARTAGE()  {
  read -p "Quel est le nom de partage du serveur ? " HOST_SHARE
  HOST_SHARE=${HOST_SHARE:-}
}
########################################################################################################################################################################################
func_MKDIR()         {
  mkdir -p /mnt/backup 2>/dev/null;
}
########################################################################################################################################################################################
func_UMOUNT()        {
 if [ ! -d /mnt/backup]; then
   umount /mnt/backup;
   echo "LE dossier de montage a été crée";
 else
   echo "Le dossier de montage existe deja";
 fi
}

########################################################################################################################################################################################
func_MOUNT()         {
  mount -t cifs -o username="$HOST_USERNAME",password="$HOST_PASSWORD" //$HOST_SERVEUR/$HOST_SHARE /mnt/backup;
}
########################################################################################################################################################################################
func_MOUNT_AD()      {
  mount -t cifs -o domain="$HOST_DOMAINE";username="$HOST_USERNAME",password="$HOST_PASSWORD" //$HOST_SERVEUR/$HOST_SHARE /mnt/backup;
}

########################################################################################################################################################################################
func_RECAP()         {
clear;
echo "# ====================================================== #";
echo "#              Resumer de la configuration               #";
echo "# ====================================================== #";
echo "Adresse IP     : $HOST_SERVEUR";
echo "Nom de domaine : $HOST_DOMAINE";
echo "Identifiant    : $HOST_USERNAME";
echo "Mot de passe   : $HOST_PASSWORD";
echo "Nom du partage : $HOST_SHARE";
echo "Chemin UNC     : //$HOST_SERVEUR/$HOST_SHARE";
echo "Chemin local   : /mnt/backup"
echo ""
}




########################################################################################################################################################################################
# Question #
############
func_HOST_SERVEUR;
func_HOST_DOMAINE;
func_HOST_USERNAME;
func_HOST_PASSWORD;
func_HOST_PARTAGE;
func_RECAP;



#func_MKDIR;
#func_UMOUNT;
#func_MOUNT;

########################################################################################################################################################################################
########################################################################################################################################################################################
########################################################################################################################################################################################
########################################################################################################################################################################################
########################################################################################################################################################################################
########################################################################################################################################################################################
########################################################################################################################################################################################
########################################################################################################################################################################################
# Note #
########
#echo "Chemin UNC     : \\\\$HOST_SERVEUR\\$HOST_SHARE   ";

