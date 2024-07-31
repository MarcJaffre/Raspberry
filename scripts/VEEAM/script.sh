#!/usr/bin/bash

########################################################################################################################################################################################
# Avancement: Menu 7 en cours 
########################################################################################################################################################################################

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
  echo "Merci d'aller dans le menu 5 : Point de montage";
 fi

# Si variable HOST_MOUNTPOINT n'est pas vide :
 if [ ! -z "${HOST_MOUNTPOINT}" ];then
 #======================================================
    # Si le point de montage n'existe pas
    if [ ! -d $HOST_MOUNTPOINT ];then
     mkdir -p $HOST_MOUNTPOINT;
     echo "Le dossier de montage a ete cree.";
    fi
    # --------------------------------------------------
    # Si le point de montage existe deja
    if [ -d $HOST_MOUNTPOINT ];then
     echo "Le dossier de montage existe déjà.";
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
  echo "Merci d'aller dans le menu 5 : Point de montage";
 fi

 if [ -z "${HOST_SERVEUR}" ];then
  echo "Merci d'aller dans le menu 0 : Adresse du Serveur de partage";
 fi


 # Si variable HOST_MOUNTPOINT et HOST_SERVEUR ne sont pas vide :
 if [ ! -z "${HOST_MOUNTPOINT}" ] && [ ! -z "${HOST_SERVEUR}" ];then
# ====================================================================
    # Verifier le montage
    CHECK=$(df -h $HOST_MOUNTPOINT | grep $HOST_SERVEUR)
    # ================================================================
    # Si le montage correspond pas a ce qu'on souhaite
    if [ -z "$CHECK" ];then
     echo "Le point de montage n'est pas monté";
    fi
    # ================================================================
    if [ ! -z "$CHECK" ];then
     echo "Le point de montage va être démonté";
    fi
    # ================================================================
# ====================================================================
 fi
 
 # Pause
 read -p "";
}

####################################################################################################
# Menu 8 - Montage du partage #
###############################
func_HOST_MOUNT2()    {
 echo "TEST"

 # Pause
 read -p "";
}







####################################################################################################
# Menu 9 - Verification du montage #
####################################
func_HOST_CHECKMOUNT(){
 echo "TEST"
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
echo "Adresse IP     : $HOST_SERVEUR";
echo "Nom de domaine : $HOST_DOMAINE";
echo "Identifiant    : $HOST_USERNAME";
echo "Mot de passe   : $HOST_PASSWORD";
echo "Nom du partage : $HOST_SHARE";
echo "Chemin UNC     : //$HOST_SERVEUR/$HOST_SHARE";
echo "Chemin local   : $HOST_MOUNTPOINT"
#echo "Action         : $HOST_ACTION"
echo ""
}

####################################################################################################
# Contenu du Menu #
####################
func_MENU()          {
echo "################################################"
echo "Menu 0: Adresse du Serveur de partage ($HOST_SERVEUR)"
echo "Menu 1: Nom du domaine ($HOST_DOMAINE)"
echo "Menu 2: Nom d'utilisateur ($HOST_USERNAME)"
echo "Menu 3: Mot de passe ($HOST_PASSWORD)"
echo "Menu 4: Nom du partage ($HOST_SHARE)"
echo "Menu 5: Point de montage ($HOST_MOUNTPOINT)"
echo "Menu 6: Creation du dossier de montage "
echo "Menu 7: Demontage du partage"
echo "Menu 8: Montage du partage"
echo "Menu 9: Verification du montage"
echo "Menu R: Résumer des actions"
echo "Menu K: Tuer Rsync (Urgence)"
echo "Menu Q: Quitter le menu"
echo "################################################"
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
  echo
  func_SRV_ADRESS;
  clear;
 ;;
 # ------------------------------------------------------------ #
 1)
  echo
  func_SRV_DOMAINE;
  clear;
 ;;
 # ------------------------------------------------------------ #
 2)
  echo
  func_SRV_USERNAME;
  clear;
 ;;
 # ------------------------------------------------------------ #
 3)
  echo
  func_SRV_PASSWORD;
  clear;
 ;;
 # ------------------------------------------------------------ #
 4)
  echo
  func_SRV_PARTAGE;
  clear;
 ;;
 # ------------------------------------------------------------ #
 5)
  echo
  func_HOST_MOUNT1;
  clear;
 ;;
 # ------------------------------------------------------------ #
 6)
  echo
  func_HOST_MKDIR;
  clear;
 ;;
 # ------------------------------------------------------------ #
 7)
  echo
  func_HOST_UMOUNT;
  clear;
 ;;
 # ------------------------------------------------------------ #
 8)
  echo
  func_HOST_MOUNT2;
  clear;
 ;;
 # ------------------------------------------------------------ #
 9)
  echo
  func_HOST_CHECKMOUNT;
  clear;
 # echo    "#-------------------------#";
 # echo    "# Bienvenue sur le menu 9 #";
 # echo    "#-------------------------#";
 # read -p "";
 ;;
 # ------------------------------------------------------------ #
 k|K)
  echo
  func_RECAP;
  echo
  echo    "#-------------------------#"
  echo    "# Bienvenue sur le menu K #"
  echo    "#-------------------------#"
  read -p ""
  clear;
 ;;
 # ------------------------------------------------------------ #
 r|R)
  echo
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
ID=$(id -u)

####################################################################################################
# Vérification Root #
#####################
if [[ $ID = 0 ]];
 then
  MENU=0;
 else
  echo "Veuiller lancer le script depuis root"
  MENU=1;
fi



####################################################################################################
# Boucle Infinie #
##################

# Si le compte est root ($MENU) alors lancer la fonction.
while [ $MENU = 0 ];
 do
  func_MENU;
  func_CHOIX;
 done
