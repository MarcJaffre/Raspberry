#!/usr/bin/bash

########################################################################################################################################################################################
# Nettoyage de la console #
###########################
clear;

########################################################################################################################################################################################
func_HOST_SERVEUR()  {
  read -p "Quel est l'adresse IP du serveur ? " HOST_SERVEUR
}

########################################################################################################################################################################################
func_HOST_DOMAINE()  {
  read -p "Quel est le nom de domaine ? " HOST_DOMAINE
}

########################################################################################################################################################################################
func_HOST_USERNAME() {
  read -p "Quel est le nom de compte utilisateur ? " HOST_USERNAME
}

########################################################################################################################################################################################
func_HOST_PASSWORD() {
  read -p "Quel est le mot de passe du compte utilisateur ? " HOST_PASSWORD
}

########################################################################################################################################################################################
func_HOST_PARTAGE()  {
  read -p "Quel est le nom de partage du serveur ? " HOST_SHARE
}


########################################################################################################################################################################################
func_MKDIR()         {
  mkdir -p /mnt/backup 2>/dev/null
}
func_UMOUNT()        {
  umount /mnt/backup
}
func_MOUNT()         {
  mount -t cifs -o domain="$HOST_DOMAINE";username="$HOST_USERNAME",password="$HOST_PASSWORD"
}


func_HOST_SERVEUR
func_HOST_DOMAINE
func_HOST_USERNAME
func_HOST_PASSWORD
func_HOST_PARTAGE
########################################################################################################################################################################################
########################################################################################################################################################################################
########################################################################################################################################################################################
########################################################################################################################################################################################
########################################################################################################################################################################################
########################################################################################################################################################################################
########################################################################################################################################################################################
########################################################################################################################################################################################
