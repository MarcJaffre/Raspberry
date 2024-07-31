#!/usr/bin/bash

####################################################################################################
# Script OFFLINE #
##################

####################################################################################################
# ByPass
####################################################################################################
HOST_SERVEUR=""
HOST_DOMAINE=""
HOST_USERNAME=""
HOST_PASSWORD=""
HOST_SHARE=""
HOST_MOUNTPOINT=""

####################################################################################################
# CHECK #
#########
#if [ -z $HOST_SERVEUR     ];then echo "La Valeur Serveur NULL"; fi
#if [ -z $HOST_DOMAINE     ];then echo "La Valeur Serveur NULL"; fi
#if [ -z $HOST_DOMAINE     ];then echo "La Valeur DOMAINE NULL"; fi
#if [ -z $HOST_PASSWORD    ];then echo "La Valeur PASSWORD NULL"; fi
#if [ -z $HOST_USERNAME    ];then echo "La Valeur USERNAME NULL"; fi
#if [ -z $HOST_SHARE       ];then echo "La Valeur Partage NULL"; fi
#if [ -z $HOST_MOUNTPOINT  ];then echo "La Valeur Point de montage NULL"; fi
#if [ ! -s $HOME/rsync.txt ];then echo "Le fichier rsync.txt est vide"; fi

####################################################################################################
# Menu 0  Adresse du Serveur de partage #
#########################################
func_SRV_ADRESS()  {
  read -p "Quel est l'adresse IP du serveur ? " HOST_SERVEUR
  HOST_SERVEUR=${HOST_SERVEUR:-192.168.20.3}
}
####################################################################################################
# Menu 1 - Nom du domaine #
###########################
func_SRV_DOMAINE()  {
  read -p "Quel est le nom de domaine ? " HOST_DOMAINE
  HOST_DOMAINE=${HOST_DOMAINE:-Local}
}
####################################################################################################
# Menu 2 - Nom d'utilisateur #
##############################
func_SRV_USERNAME() {
  read -p "Quel est le nom de compte utilisateur ? " HOST_USERNAME
  HOST_USERNAME=${HOST_USERNAME:-marc}
}
####################################################################################################
# Menu 3 - Mot de passe #
#########################
func_SRV_PASSWORD() {
  read -p "Quel est le mot de passe du compte utilisateur ? " HOST_PASSWORD
  HOST_PASSWORD=${HOST_PASSWORD:-admin}
}
####################################################################################################
# Menu 4 - Nom du partage #
###########################
func_SRV_PARTAGE()  {
  read -p "Quel est le nom de partage du serveur ? " HOST_SHARE
  HOST_SHARE=${HOST_SHARE:-marc}
}
####################################################################################################
# Menu 5 - Point de montage #
#############################
func_HOST_MOUNT1()   {
  read -p "Où souhaitez vous monter le partage sur la machine ? " HOST_MOUNTPOINT
  HOST_MOUNTPOINT=${HOST_MOUNTPOINT:-/mnt/backup}
}
####################################################################################################
# Menu 6 - Creation du dossier de montage #
###########################################
func_HOST_MKDIR()    {
# [Garde Fou] Si la variable est HOST_MOUNTPOINT est vide :
 if [ -z "${HOST_MOUNTPOINT}" ];then
  echo "> Merci d'aller dans le menu 5 : Point de montage";
 fi
# Si variable HOST_MOUNTPOINT n'est pas vide :
 if [ ! -z "${HOST_MOUNTPOINT}" ];then
 #======================================================
    # Si le point de montage n'existe pas
    if [ ! -d $HOST_MOUNTPOINT ];then
     mkdir -p $HOST_MOUNTPOINT;
     echo "> Le dossier de montage a ete cree.";
    fi
    # --------------------------------------------------
    # Si le point de montage existe deja
    if [ -d $HOST_MOUNTPOINT ];then
     echo "> Le dossier de montage existe déjà.";
    fi
 #======================================================
 fi
 # Pause
 read -p "";
}
####################################################################################################
# Menu 7 - Demontage du partage #
#################################
func_HOST_UMOUNT()   {
# [Garde Fou] Si la variable est HOST_MOUNTPOINT est vide :
 if [ -z "${HOST_MOUNTPOINT}" ];then
  echo "> Merci d'aller dans le menu 5 : Point de montage";
  echo
 fi
# [Garde Fou] Si la variable est HOST_SERVEUR est vide :
 if [ -z "${HOST_SERVEUR}" ];then
  echo "> Merci d'aller dans le menu 0 : Adresse du Serveur de partage";
  echo
 fi
 # Si variable HOST_MOUNTPOINT et HOST_SERVEUR ne sont pas vide :
 if [ ! -z "${HOST_MOUNTPOINT}" ] && [ ! -z "${HOST_SERVEUR}" ];then
 # ====================================================================
   # Verifier le montage
   CHECK=$(df -h $HOST_MOUNTPOINT | grep $HOST_SERVEUR)
   # ================================================================
   # Si le montage correspond pas a ce qu'on souhaite
   if [ -z "$CHECK" ];then
    echo "> Le point de montage n'est pas monté";
   fi
   # ================================================================
   if [ ! -z "$CHECK" ];then
    umount $HOST_MOUNTPOINT;
   fi
   # ================================================================
 # ====================================================================
 fi
 # Pause
 read -p "";
}
####################################################################################################
# Menu 8 - Montage du partage (Local) #
#######################################
func_HOST_MOUNT2()    {
# [Garde Fou] Si la variable est HOST_MOUNTPOINT est vide :
 if [ -z "${HOST_MOUNTPOINT}" ];then
  echo "> Merci d'aller dans le menu 5 : Point de montage";
 fi
 if [ -z "${HOST_SERVEUR}" ];then
  echo "> Merci d'aller dans le menu 0 : Adresse du Serveur de partage";
 fi
 # Si variable HOST_MOUNTPOINT et HOST_SERVEUR ne sont pas vide :
 if [ ! -z "${HOST_MOUNTPOINT}" ] && [ ! -z "${HOST_SERVEUR}" ];then
 # ====================================================================
  # ===================================================================
  systemctl daemon-reload;
  # ===================================================================
  mount -t cifs -o username=$HOST_USERNAME,password=$HOST_PASSWORD //$HOST_SERVEUR/$HOST_SHARE $HOST_MOUNTPOINT 2>/dev/null;
  # ===================================================================
  echo "> Montage du Lecteur réseau terminé";
 # ====================================================================
 fi
 # Pause
 read -p "";
}
####################################################################################################
# Menu 8 - Montage du partage (AD) #
####################################
func_HOST_MOUNT2_AD()  {
# [Garde Fou] Si la variable est HOST_MOUNTPOINT est vide :
 if [ -z "${HOST_MOUNTPOINT}" ];then
  echo "> Merci d'aller dans le menu 5 : Point de montage";
 fi
 if [ -z "${HOST_SERVEUR}" ];then
  echo "> Merci d'aller dans le menu 0 : Adresse du Serveur de partage";
 fi
 # Si variable HOST_MOUNTPOINT et HOST_SERVEUR ne sont pas vide :
 if [ ! -z "${HOST_MOUNTPOINT}" ] && [ ! -z "${HOST_SERVEUR}" ];then
 # ====================================================================
 systemctl daemon-reload;
 mount                       \
 -t cifs                     \
 -o                          \
 domain=$HOST_DOMAINE,       \
 username=$HOST_USERNAME,    \
 password=$HOST_PASSWORD     \
 //$HOST_SERVEUR/$HOST_SHARE \
 $HOST_MOUNTPOINT            \
 2>/dev/null;
 # ====================================================================
  echo "> Montage du Lecteur réseau terminé";
 # ====================================================================
 fi
 # Pause
 read -p "";
}
####################################################################################################
# Menu 9 - Verification du montage #
####################################
func_HOST_CHECKMOUNT(){
 df -h /$HOST_MOUNTPOINT;
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
 echo ""
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
 for i in $(cat $HOME/rsync.txt)
 do
  if [ -d $i ];then
   echo "[OK] Le répertoire existe : $i"
  fi
 done

 for i in $(cat $HOME/rsync.txt)
 do
  if [ ! -d $i ];then
   echo "[KO] Le répertoire n'existe pas : $i"
  fi
 done
 read -p "";
}

####################################################################################################
# Menu C - Lancer la sauvegarde #
#################################
func_HOST_ARCHIVAGE_RSYNC(){



#
#CHECK=$(mount | grep "//$HOST_SERVEUR/$HOST_SHARE on $HOST_MOUNTPOINT" | xargs -n3 2>/dev/null | head -n1)
#if [ "$CHECK" == "//$HOST_SERVEUR/$HOST_SHARE on $HOST_MOUNTPOINT" ];then  echo "OK" fi
# Verifier si le fichier contient du contenu
# if [ -s $HOME/rsync.txt ];then
#   for i in $(cat $HOME/rsync.txt)
#   do
#    rsync -avz $i $HOST_MOUNTPOINT;
#   done
# else
#  echo "Le fichier contenant les chemins à sauvegarder est vide."
# fi
 read -p "";
}


####################################################################################################
# Menu D - Lancer la sauvegargde #
##################################

####################################################################################################
# Menu E - Tuer Rsync (Urgence) #
#################################

####################################################################################################
# Menu I - Information sur le script #
######################################



####################################################################################################
# Contenu du Menu #
####################
func_MENU()          {
echo "############################################################"
echo "#          Information pour le montage du partage          #"
echo "############################################################"
echo "Menu 0: Adresse du Serveur de partage ($HOST_SERVEUR)"
echo "Menu 1: Nom du domaine ($HOST_DOMAINE)"
echo "Menu 2: Nom d'utilisateur ($HOST_USERNAME)"
echo "Menu 3: Mot de passe ($HOST_PASSWORD)"
echo "Menu 4: Nom du partage ($HOST_SHARE)"
echo
echo "############################################################"
echo "#          Gestion du montage sur la machine HOTE          #"
echo "############################################################"
echo "Menu 5: Point de montage ($HOST_MOUNTPOINT)"
echo "Menu 6: Creation du dossier de montage"
echo "Menu 7: Demontage du partage"
echo "Menu 8: Montage du partage"
echo "Menu 9: Verification du montage"
echo
echo "############################################################"
echo "                     En Developpement                      #"
echo "############################################################"
echo "Menu A: Editer le fichier des chemins à sauvegarder"
echo "Menu B: Vérification des chemins"
echo "Menu C: Lancer la sauvegarde"
echo "Menu D: "
echo "Menu E: Tuer Rsync (Urgence)"
echo "Menu I: Information sur le script"
echo
echo "############################################################"
echo "#          Actions Spécial sur le système                  #"
echo "############################################################"
echo "Menu R: Résumer des actions"
echo "Menu Q: Quitter le menu"
echo "############################################################"
echo
read -p "Indiquer votre choix: " choix
echo
}
####################################################################################################
# Action du menu #
##################
func_CHOIX(){
case $choix in
 # ------------------------------------------------------------ #
 0)
  func_SRV_ADRESS;
  clear;
 ;;
 # ------------------------------------------------------------ #
 1)
  func_SRV_DOMAINE;
  clear;
 ;;
 # ------------------------------------------------------------ #
 2)
  func_SRV_USERNAME;
  clear;
 ;;
 # ------------------------------------------------------------ #
 3)
  func_SRV_PASSWORD;
  clear;
 ;;
 # ------------------------------------------------------------ #
 4)
  func_SRV_PARTAGE;
  clear;
 ;;
 # ------------------------------------------------------------ #
 5)
  func_HOST_MOUNT1;
  clear;
 ;;
 # ------------------------------------------------------------ #
 6)
  func_HOST_MKDIR;
  clear;
 ;;
 # ------------------------------------------------------------ #
 7)
  func_HOST_UMOUNT;
  clear;
 ;;
 # ------------------------------------------------------------ #
 8)
  func_HOST_MOUNT2;
  clear;
 ;;
 # ------------------------------------------------------------ #
 9)
  func_HOST_CHECKMOUNT;
  clear;
 ;;
 # ------------------------------------------------------------ #
 a|A)
  echo
  func_HOST_EDIT_RSYNC_FILE;
  clear;
 ;;
 # ------------------------------------------------------------ #
 b|B)
  func_HOST_CHECK_RSYNC_FOLDER;
  clear;
 ;;
 # ------------------------------------------------------------ #
 c|C)
  func_HOST_ARCHIVAGE_RSYNC;
  clear;
 ;;
 # ------------------------------------------------------------ #
 d|D)
  echo
  echo    "#-------------------------#"
  echo    "# Bienvenue sur le menu D #"
  echo    "#-------------------------#"
  read -p ""
  clear;
 ;;
 # ------------------------------------------------------------ #
 e|E)
  echo
  echo    "#-------------------------#"
  echo    "# Bienvenue sur le menu E #"
  echo    "#-------------------------#"
  read -p ""
  clear;
 ;;
 # ------------------------------------------------------------ #
 f|F)
  echo
  echo    "#-------------------------#"
  echo    "# Bienvenue sur le menu F #"
  echo    "#-------------------------#"
  read -p ""
  clear;
 ;;
 # ------------------------------------------------------------ #
 g|G)
  echo
  echo    "#-------------------------#"
  echo    "# Bienvenue sur le menu G #"
  echo    "#-------------------------#"
  read -p ""
  clear;
 ;;
 # ------------------------------------------------------------ #
 h|H)
  echo
  echo    "#-------------------------#"
  echo    "# Bienvenue sur le menu H #"
  echo    "#-------------------------#"
  read -p ""
  clear;
 ;;
 # ------------------------------------------------------------ #
 i|I)
  echo
  echo    "#-------------------------#"
  echo    "# Bienvenue sur le menu I #"
  echo    "#-------------------------#"
  read -p ""
  clear;
 ;;
 # ------------------------------------------------------------ #
 r|R)
  func_RECAP;
  echo
  echo    "#-------------------------#"
  echo    "# Bienvenue sur le menu R #"
  echo    "#-------------------------#"
  read -p ""
  clear;
 ;;
 # ------------------------------------------------------------ #
 q|Q)
  clear;
  exit;
 ;;
 # ------------------------------------------------------------ #
 *)
  echo
  echo    "#--------------------------------------------------#"
  echo    "# Merci d'indiquer un choix parmis ceux disponible #"
  read -p "#--------------------------------------------------#"
  clear;
 ;;
 # ------------------------------------------------------------ #
 esac
}

####################################################################################################
# Nettoyage de la console #
###########################
clear;

####################################################################################################
# Récupération de l'ID en cours #
#################################
#ID=$(id -u)

####################################################################################################
# Vérification Root #
#####################
#if [[ $ID = 0 ]];then
 # =============================================
 #MENU=0;
 # =============================================
#else
 # =============================================
 #echo "Veuiller lancer le script depuis root"
 #MENU=1;
 # =============================================
#fi
####################################################################################################
# Boucle Infinie #
##################
# Si le compte est root ($MENU) alors lancer la fonction.
#while [ $MENU = 0 ];
# do
#  func_MENU;
#  func_CHOIX;
# done
####################################################################################################
