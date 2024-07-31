#!/usr/bin/bash

#################################################################################################################################################
# Nettoyage Console #
#####################
clear;

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
#if [ ! -f $HOME/rsync.txt ];then echo "Le fichier rsync.txt est absent"; fi
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
 # Verification si la variable est NULL,un message est envoyé
 if [ -z $HOST_MOUNTPOINT   ];then echo  "La Valeur Point de montage NULL"; fi
 #
 # Si le point de montage existe deja,un message est envoyé
 if [ -d $HOST_MOUNTPOINT   ];then echo  "> Le dossier de montage existe déjà."; fi
 #
 # Si le point de montage n'existe pas,un message est envoyé
 if [ ! -d $HOST_MOUNTPOINT ];then mkdir -p $HOST_MOUNTPOINT; echo "> Le dossier de montage a ete cree."; fi
 #
 # Pause
 read -p "";
}
#################################################################################################################################################
# Menu 7 - Demontage du partage #
#################################
func_HOST_UMOUNT()   {
 # En cas de variable Vide, un message est envoyé
 if [ -z $HOST_SERVEUR     ];then echo "La Valeur Serveur NULL"; fi
 if [ -z $HOST_MOUNTPOINT  ];then echo "La Valeur Point de montage NULL"; fi
 #
 # Creation de Variable ponctuellement (Utile lors du montage)
 OPTION="username=$HOST_USERNAME,password=$HOST_PASSWORD"
 SOURCE="//$HOST_SERVEUR/$HOST_SHARE"
 DESTINATION="$HOST_MOUNTPOINT"
 #
 # Si les variables HOST_MOUNTPOINT et HOST_SERVEUR sont pas nul alors, monter le partage
 if [ ! -z "${HOST_MOUNTPOINT}" ] && [ ! -z "${HOST_SERVEUR}" ];then
    systemctl daemon-reload;
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
 # En cas de variable Vide, un message est envoyé
 if [ -z $HOST_SERVEUR     ];then echo "La Valeur Serveur NULL"; fi
 if [ -z $HOST_MOUNTPOINT  ];then echo "La Valeur Point de montage NULL"; fi
 #
 # Creation de Variable ponctuellement (Utile lors du montage
 OPTION="domain=$HOST_DOMAINE,username=$HOST_USERNAME,password=$HOST_PASSWORD"
 SOURCE="//$HOST_SERVEUR/$HOST_SHARE"
 DESTINATION="$HOST_MOUNTPOINT"
 #
 # Si les variables HOST_MOUNTPOINT et HOST_SERVEUR sont pas nul alors, monter le partage
 if [ ! -z "${HOST_MOUNTPOINT}" ] && [ ! -z "${HOST_SERVEUR}" ];then
    systemctl daemon-reload;
    mount -t cifs -o $OPTION $SOURCE $DESTINATION 2>/dev/null;
    echo "> Montage du Lecteur réseau terminé";
 fi
 #
 # Pause
 read -p "";
}

####################################################################################################
# Menu 9 - Verification du montage #
####################################
func_HOST_CHECKMOUNT(){
 # En cas de variable Vide, un message est envoyé
 if [ -z $HOST_MOUNTPOINT  ];then echo "La Valeur Point de montage NULL"; fi
 #
 # Si la variable est pas null, verification du montage
 if [ ! -z "${HOST_MOUNTPOINT}" ]; then df -h /$HOST_MOUNTPOINT; fi
 # Pause
 read -p "";
}

####################################################################################################
# Menu R #
##########
func_RECAP()         {
 clear;
 echo "# ====================================================== #";
 echo "#              Resumer de la configuration               #";
 echo "# ====================================================== #";
 echo "> Adresse IP     : $HOST_SERVEUR";
 echo "> Nom de domaine : $HOST_DOMAINE";
 echo "> Identifiant    : $HOST_USERNAME";
 echo "> Mot de passe   : $HOST_PASSWORD";
 echo "> Nom du partage : $HOST_SHARE";
 echo "> Chemin UNC     : //$HOST_SERVEUR/$HOST_SHARE";
 echo "> Chemin local   : $HOST_MOUNTPOINT"
 #echo "> Action         : $HOST_ACTION"
 echo "# ====================================================== #";
}

####################################################################################################
# Menu A - Editer le fichier des chemins à sauvegarder #
########################################################
func_HOST_EDIT_RSYNC_FILE(){
 nano $HOME/rsync.txt;
}

####################################################################################################
# Menu B - Vérification des chemins #
#####################################
func_HOST_CHECK_RSYNC_FOLDER(){
 #
 # Verifier si le fichier n'existe pas, un message est envoyé
 if [ ! -f $HOME/rsync.txt ];then echo "Le fichier rsync.txt est absent"; fi
 #
 # Verifier si le fichier est pas vide
 if [ ! -s $HOME/rsync.txt ];then echo "Le fichier rsync.txt est vide"; fi
 #
 # Lecture du fichier rsync, verification de repertoire. (Lecteur ligne par ligne)
 for i in $(cat $HOME/rsync.txt);do if [ -d $i   ];then echo "[OK] Le répertoire existe : $i"; fi done
 for i in $(cat $HOME/rsync.txt);do if [ ! -d $i ];then echo "[KO] Le répertoire n'existe pas : $i"; fi done
 #
 # Pause
 read -p "";
}
