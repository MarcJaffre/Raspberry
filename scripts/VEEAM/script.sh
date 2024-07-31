#!/usr/bin/bash

########################################################################################################################################################################################
func_HOST_SERVEUR()  {
  read -p "Quel est l'adresse IP du serveur ? " HOST_SERVEUR
  HOST_SERVEUR=${HOST_SERVEUR:-192.168.20.3}
}

########################################################################################################################################################################################
func_HOST_DOMAINE()  {
  read -p "Quel est le nom de domaine ? " HOST_DOMAINE
  HOST_DOMAINE=${HOST_DOMAINE:-Local}
}

########################################################################################################################################################################################
func_HOST_USERNAME() {
  read -p "Quel est le nom de compte utilisateur ? " HOST_USERNAME
  HOST_USERNAME=${HOST_USERNAME:-marc}
}

########################################################################################################################################################################################
func_HOST_PASSWORD() {
  read -p "Quel est le mot de passe du compte utilisateur ? " HOST_PASSWORD
  HOST_PASSWORD=${HOST_PASSWORD:-admin}
}
########################################################################################################################################################################################
func_HOST_PARTAGE()  {
  read -p "Quel est le nom de partage du serveur ? " HOST_SHARE
  HOST_SHARE=${HOST_SHARE:-marc}
}




########################################################################################################################################################################################
#func_MKDIR()         {
# if [ ! -d /mnt/backup ]; then
#  mkdir -p /mnt/backup 2>/dev/null;
#  echo "Le creation du dossier a ete fait."
#  echo "";
#  else
#  echo "Le dossier existe deja"
#  echo "";
# fi
#}

########################################################################################################################################################################################
func_UMOUNT()        {
 if [ -d /mnt/backup ]; then
  umount /mnt/backup;
  echo "Le dossier a été démonté";
  echo "";
 fi
 }

########################################################################################################################################################################################
func_MOUNT()         {
  mount -t cifs -o username="$HOST_USERNAME",password="$HOST_PASSWORD" //$HOST_SERVEUR/$HOST_SHARE /mnt/backup;
  echo "Le dossier a été monté";
  echo "";
}

########################################################################################################################################################################################
func_MOUNT_AD()      {
  mount -t cifs -o domain="$HOST_DOMAINE";username="$HOST_USERNAME",password="$HOST_PASSWORD" //$HOST_SERVEUR/$HOST_SHARE /mnt/backup;
}

########################################################################################################################################################################################
func_ACTION()        {
  read -p "Quel action souhaitez-vous faire ? (archivage, restauration) " HOST_ACTION
  HOST_ACTION=${HOST_ACTION:-archivage}
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
echo "Action         : $HOST_ACTION"
echo ""
}

########################################################################################################################################################################################
# Contenu du Menu #
####################
func_MENU()          {
echo "################################################"
echo "Menu 0: Serveur de partage"
echo "Menu 1: Nom du domaine"
echo "Menu 2: Nom d'utilisateur"
echo "Menu 3: Mot de passe"
echo "Menu 4: Nom du partage"
#echo "Menu 5: Point de montage"
#echo "Menu 6: Creation du dossier de montage"
#echo "Menu 7: Demontage du partage"
#echo "Menu 8: Montage du partage"
#echo "Menu 9: Verification du montage"
echo "Menu R: Résumer des actions"
echo "Menu Q: Quitter le menu"
echo "################################################"
echo
read -p "Indiquer votre choix: " choix
echo
}



#func_MOUNT_AD;
#func_ACTION;
#func_MKDIR;
#func_UMOUNT;
#func_MOUNT;


########################################################################################################################################################################################
# Action du menu #
##################
func_CHOIX(){
case $choix in
 # ------------------------------------------------------------ #
 0)
  echo
  func_HOST_SERVEUR;
  echo    "#-------------------------#"
  echo    "# Bienvenue sur le menu 0 #"
  echo    "#-------------------------#"
  read -p ""
  clear;
 ;;
 # ------------------------------------------------------------ #
 1)
  echo
  func_HOST_DOMAINE;
  echo    "#-------------------------#"
  echo    "# Bienvenue sur le menu 1 #"
  echo    "#-------------------------#"
  read -p ""
  clear;
 ;;
 # ------------------------------------------------------------ #
 2)
  echo
  func_HOST_USERNAME;
  echo    "#-------------------------#"
  echo    "# Bienvenue sur le menu 2 #"
  echo    "#-------------------------#"
  read -p ""
  clear;
 ;;
 # ------------------------------------------------------------ #
 3)
  echo
  func_HOST_PASSWORD;
  echo    "#-------------------------#"
  echo    "# Bienvenue sur le menu 3 #"
  echo    "#-------------------------#"
  read -p ""
  clear;
 ;;
 # ------------------------------------------------------------ #
 4)
  echo
  func_HOST_PARTAGE;
  echo    "#-------------------------#"
  echo    "# Bienvenue sur le menu 4 #"
  echo    "#-------------------------#"
  read -p ""
  clear;
 ;;
 # ------------------------------------------------------------ #
 5)
 # echo
 # echo    "#-------------------------#"
 # echo    "# Bienvenue sur le menu 5 #"
 # echo    "#-------------------------#"
 # read -p ""
  clear;
 ;;
 # ------------------------------------------------------------ #
 6)
 # echo
 # echo    "#-------------------------#"
 # echo    "# Bienvenue sur le menu 6 #"
 # echo    "#-------------------------#"
 # read -p ""
  clear;
 ;;
 # ------------------------------------------------------------ #
 7)
 # echo
 # echo    "#-------------------------#"
 # echo    "# Bienvenue sur le menu 7 #"
 # echo    "#-------------------------#"
 # read -p ""
  clear;
 ;;
 # ------------------------------------------------------------ #
 8)
 # echo
 # echo    "#-------------------------#"
 # echo    "# Bienvenue sur le menu 8 #"
 # echo    "#-------------------------#"
 # read -p ""
  clear;
 ;;
 # ------------------------------------------------------------ #
 9)
 # echo
 # echo    "#-------------------------#"
 # echo    "# Bienvenue sur le menu 9 #"
 # echo    "#-------------------------#"
 # read -p ""
  clear;
 ;;
 # ------------------------------------------------------------ #
 r|R)
  echo
  func_RECAP;
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


########################################################################################################################################################################################
# Nettoyage de la console #
###########################
clear;

########################################################################################################################################################################################
# Récupération de l'ID en cours #
#################################
ID=$(id -u)

########################################################################################################################################################################################
# Vérification Root #
#####################
if [[ $ID = 0 ]];
 then
  MENU=0;
 else
  echo "Veuiller lancer le script depuis root"
  MENU=1;
fi

########################################################################################################################################################################################
# Boucle Infinie #
##################
# Si le compte est root ($MENU) alors lancer la fonction.
while [ $MENU = 0 ];
 do
  func_MENU;
  func_CHOIX;
 done
