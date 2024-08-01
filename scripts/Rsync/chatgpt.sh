#!/usr/bin/bash

# echo "" > backup.sh; nano backup.sh; bash backup.sh

####################################################################################################################################################################################################################
# Nettoyage de la console #
###########################
clear;

####################################################################################################################################################################################################################
# Vérification que le script est lancé en tant que root #
#########################################################
# 
if [ "$EUID" -ne 0 ]; then echo "Ce script doit être exécuté en tant que root."; exit 1; fi

####################################################################################################################################################################################################################
# Bypass - Variables par défaut #
#################################
BYPASS="ON"
if [ $BYPASS = "ON" ];then
 IP="192.168.1.101"
 DOMAIN="marc.local"
 LOGIN="Demonstration"
 PASSWORD="Demonstration74@"
 SHARE_NAME="home"
 MOUNT_POINT="/mnt/backup"
fi

####################################################################################################################################################################################################################
# Menu principal #
##################
show_menu() {
 clear
 echo "=== Menu Principal ==="
 echo "1) Configurer IP ($IP)"
 echo "2) Configurer Domaine ($DOMAIN)"
 echo "3) Configurer Login ($LOGIN)"
 echo "4) Configurer Password"
 echo "5) Configurer Nom du Partage ($SHARE_NAME)"
 echo "6) Configurer Point de Montage ($MOUNT_POINT)"
 echo "7) Monter/Démonter le partage CIFS"
 echo "8) Vérifier le point de montage"
 echo "9) Éditer le fichier rsync.txt"
 echo "10) Vérifier le contenu de rsync.txt"
 echo "11) Quitter"
}

####################################################################################################################################################################################################################
# Fonction pour configurer une variable #
#########################################
configure_variable() {
 local var_name="$1"
 local var_value="$2"
 read -p "Entrez la nouvelle valeur pour $var_name ($var_value): " new_value
 if [ -n "$new_value" ]; then eval "$var_name=\"$new_value\"";  fi
}

####################################################################################################################################################################################################################
# Fonction pour monter/démonter le partage CIFS #
#################################################
mount_share() {
 systemctl daemon-reload
 read -p "Voulez-vous monter (m) ou démonter (d) le partage? " action
 if [ "$action" == "m" ]; then  mount -t cifs -o username=$LOGIN,password=$PASSWORD //$IP/$SHARE_NAME $MOUNT_POINT; echo "Partage monté."
 elif [ "$action" == "d" ]; then umount $MOUNT_POINT; echo "Partage démonté."
 else echo "Action non reconnue."
 fi
}


####################################################################################################################################################################################################################
# Fonction pour vérifier le point de montage #
##############################################
check_mount_point() {
 if mountpoint -q "$MOUNT_POINT"; then echo "Le point de montage $MOUNT_POINT est actif."
 else echo "Le point de montage $MOUNT_POINT n'est pas actif."
 fi
}

####################################################################################################################################################################################################################
# Fonction pour éditer le fichier rsync.txt #
#############################################
edit_rsync_file() {
 local file="rsync.txt"
 if [ ! -f "$file" ]; then touch "$file"; fi
  nano "$file"
}

####################################################################################################################################################################################################################
# Fonction pour vérifier le contenu de rsync.txt #
##################################################
check_rsync_content() {
 # ================================================================================================
 local file="rsync.txt"
 local rc=0
 # ================================================================================================
 if [ -f "$file" ]; then while IFS= read -r line; do
   # ==============================================================================================
   # Ignorer les lignes commentées
   if [[ ! "$line" =~ ^# ]]; then
      if [ ! -d "$line" ]; then echo "Erreur: Le chemin '$line' n'existe pas."; rc=1 ; fi
   fi
   done < "$file"
   # ==============================================================================================
 else echo "Le fichier $file n'existe pas."; rc=1 ; fi
 # ================================================================================================
  return $rc
}


####################################################################################################################################################################################################################
# Boucle principale du menu #
#############################
main() {
 check_root
 while true; do
 # ======================================================================================
   show_menu
   read -p "Choisissez une option: " choice
   # =========================================================
   case $choice in
        1) configure_variable "IP" "$IP" ;;
        2) configure_variable "DOMAIN" "$DOMAIN" ;;
        3) configure_variable "LOGIN" "$LOGIN" ;;
        4) configure_variable "PASSWORD" "$PASSWORD" ;;
        5) configure_variable "SHARE_NAME" "$SHARE_NAME" ;;
        6) configure_variable "MOUNT_POINT" "$MOUNT_POINT" ;;
        7) mount_share ;;
        8) check_mount_point ;;
        9) edit_rsync_file ;;
        10) check_rsync_content ;;
        11) exit 0 ;;
        *) echo "Choix invalide." ;;
   esac
   # =========================================================   
   read -p "Appuyez sur Entrée pour continuer..."
# ======================================================================================
done
}

####################################################################################################################################################################################################################
# Lancer le script #
####################
main

####################################################################################################################################################################################################################
# Prompt:
# Pourrais tu m'écrire un script bash sous forme de menu interactif en utilisant des fonctions.
# Etape 0: Vérifier que le script est lancer en root
# Etape 1: A chaque choix le menu sélectionner, un clear doit être fait
# Etape 2: Un choix disponible par question dans le menu avec récupération de la question dans une variable (IP, Domaine, login, password, nom du partage, point de montage)
# Dans le menu on doit voir la valeur actuel de la variable entre parenthèse après le menu (Exemple: Identifiant ($MONUSER))
# Chaque variable des question auras une valeur prédéfinie sur A.
# 
# Etape 3: Un choix qui permet de monter / démonter le partage CIFS utilisant la version 3. La commande systemctl daemon-reload doit être lancer avant chaque action.
# Etape 4: Un choix qui permet de vérifier en comparant le point de montage actuel avec le montage qu'on veut.
# Etape 5: Un choix pour éditer un fichier nommer rsync.txt avec vérification de contenu et s'il existe, de plus il doit ignorer les lignes commentaires "#".
# Etape 6: Un choix qui met à zéro la valeur RC, vérifie le chemin de chaque ligne et un indique un code RC=1 en cas d'erreur
#
#
#
#
#
#
#
####################################################################################################################################################################################################################


