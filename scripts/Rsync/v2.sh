#!/usr/bin/bash

##################################################################################################################################################################################
# Nettoyage Console #
#####################
clear;

##################################################################################################################################################################################
# La fonction "func_HOST_MOUNT2" utilise un compte local. Pour une machine utilisant un domaine remplacer par func_HOST_MOUNT2_AD
# Menu A: Code retour à revoir (Cosmétique)
#
# Amélioration:
# Menu D: Lancer le processus en arrière plan
#
# A Implémenter:
# Menu E: A crée (Verifier si un backup est actif)
# Menu F: A crée (Tuer Rsync en urgence)
# Menu I: Information sur l'auteur
#
# Autre : DIFF REPERTOIRE pour connaitre le nombre de dossier parent à backupper
#       : Demonter volume a la fin de la sauvegarde
#       : Purge de la log https://www.nas-forum.com/forum/topic/68267-script-linux-configuration-de-check-de-r%C3%A9tention-de-fichiers-de-backups/
##################################################################################################################################################################################

##################################################################################################################################################################################
# Journalisation : En cours
# - Traper un fuseau horaire avec une mises en forme (JJMMAA_HHMMSS)
# - Forcer une date
# - Journaliser les sauvegarde
##################################################################################################################################################################################

##################################################################################################################################################################################
# Mail:
# - Mail de rapport à émettte
# - Liste de diffusion
# - Journal des événements
##################################################################################################################################################################################

DATE=$(date +"%d%m%y_%H%M%S")
AD="0"

##################################################################################################################################################################################
# Chargement Configuration #
############################
# Si le fichier existe, le script relance la derniere configuration
if [ -f settings ]; then source settings; fi

##################################################################################################################################################################################
# Bypass #
##########
#HOST_SERVEUR="192.168.20.3"
#HOST_DOMAINE="Local"
#HOST_USERNAME="marc"
#HOST_PASSWORD="admin"
#HOST_SHARE="Media_5/TEST"
#HOST_MOUNTPOINT="/mnt/backup"
#HOST_RSYNC_SIM="oui"
#RC=""

##################################################################################################################################################################################
# Menu 0  Adresse du Serveur de partage #
#########################################
func_SRV_ADRESS()  {
 read -p "Quel est l'adresse IP du serveur ? " HOST_SERVEUR; HOST_SERVEUR=${HOST_SERVEUR:-192.168.1.101}
}

##################################################################################################################################################################################
# Menu 1 - Nom du domaine #
###########################
func_SRV_DOMAINE()  {
 read -p "Quel est le nom de domaine ? " HOST_DOMAINE; HOST_DOMAINE=${HOST_DOMAINE:-Local}
}

##################################################################################################################################################################################
# Menu 2 - Nom d'utilisateur #
##############################
func_SRV_USERNAME() {
 read -p "Quel est le nom de compte utilisateur ? " HOST_USERNAME; HOST_USERNAME=${HOST_USERNAME:-Demonstration}
}

##################################################################################################################################################################################
# Menu 3 - Mot de passe #
#########################
func_SRV_PASSWORD() {
 read -p "Quel est le mot de passe du compte utilisateur ? " HOST_PASSWORD; HOST_PASSWORD=${HOST_PASSWORD:-Demonstration74@}
}

##################################################################################################################################################################################
# Menu 4 - Nom du partage #
###########################
func_SRV_PARTAGE()  {
 read -p "Quel est le nom de partage du serveur ? " HOST_SHARE; HOST_SHARE=${HOST_SHARE:-home}
}
##################################################################################################################################################################################
# Menu 5 - Point de montage #
#############################
func_HOST_MOUNT1()   {
 read -p "Où souhaitez vous monter le partage sur la machine ? " HOST_MOUNTPOINT; HOST_MOUNTPOINT=${HOST_MOUNTPOINT:-/mnt/backup}
}

##################################################################################################################################################################################
# Menu 6 - Creation du dossier de montage #
###########################################
func_HOST_MKDIR()    {
 # Verification si la variable est NULL,un message est envoyé
 if [ -z $HOST_MOUNTPOINT   ];then echo  "La Valeur Point de montage NULL"; fi
 #
 # Si ma valeur est pas NULL et que le dossier MOUNT existe alors un message est envoyé
 if [ ! -z $HOST_MOUNTPOINT   ] && [ -d $HOST_MOUNTPOINT   ];then echo  "> Le dossier de montage existe déjà."; fi
 #
 # Si le point de montage n'existe pas,un message est envoyé
 if [ ! -z $HOST_MOUNTPOINT   ] && [ ! -d $HOST_MOUNTPOINT ];then mkdir -p $HOST_MOUNTPOINT; echo "> Le dossier de montage a ete cree."; fi
 #
 # Pause
 read -p "";
}

##################################################################################################################################################################################
# Menu 7 - Demontage du partage #
#################################
func_HOST_UMOUNT()   {
 # Verification si la variable est NULL,un message est envoyé
 if [ -z $HOST_SERVEUR     ];then echo "La Valeur Serveur NULL"; fi
 if [ -z $HOST_MOUNTPOINT  ];then echo "La Valeur Point de montage NULL"; fi
 #
 # Si les valeurs sont pas NULL, démonter le point de montage
 if [ ! -z "${HOST_SERVEUR}" ] && [ ! -z "${HOST_MOUNTPOINT}" ];then umount -l $HOST_MOUNTPOINT; echo "> Demontage de la partition $HOST_MOUNTPOINT"; fi
 #
 # Pause
 read -p "";
}

##################################################################################################################################################################################
# Menu 8 - Montage du partage (Local) #
#######################################
func_HOST_MOUNT2()  {
 # En cas de variable Vide, un message est envoyé
 if [ -z $HOST_SERVEUR     ];then echo "La Valeur Serveur NULL"; fi
 if [ -z $HOST_SHARE       ];then echo "La Valeur Partage NULL"; fi
 if [ -z $HOST_MOUNTPOINT  ];then echo "La Valeur Point de montage NULL"; fi
 #
 # Creation de Variable ponctuellement pour la suite des commandes
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
 # Remise a zéro des variables
 OPTION=""
 SOURCE=""
 DESTINATION=""
 # Pause
 read -p "";
}

##################################################################################################################################################################################
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
 # Remise a zéro des variables
 OPTION=""
 SOURCE=""
 DESTINATION=""
 #
 # Pause
 read -p "";
}

##################################################################################################################################################################################
# Menu 9 - Editer le fichier des chemins à sauvegarder #
########################################################
func_HOST_EDIT_RSYNC_FILE(){
 nano $HOME/rsync.txt;
}

##################################################################################################################################################################################
# Menu A - Verification du montage #
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

##################################################################################################################################################################################
# Menu B - Vérification des chemins de Rsync #
##############################################
func_HOST_CHECK_RSYNC_FOLDER(){
 #  Si le  fichier est vide ou n'existe pas alors message d'erreur.
 if [[ ! -s $HOME/rsync.txt || ! -f $HOME/rsync.txt ]]; then echo "Le fichier rsync.txt est absent ou vide"; fi
 # Création d'une variable servant au check
 RC="0"
 # Si le fichier a du contenu et existe alors poursuivre
 if [[ -s $HOME/rsync.txt || -f $HOME/rsync.txt ]]; then
  # Lecture du fichier rsync par ligne en excluant les lignes commençant par #.
  for i in $(cat $HOME/rsync.txt | grep -v "^#");do
   # Verification de l'existance du dossier pour chaque ligne. En cas d'erreur, un message est afficher.
   if [ ! -d $i ];then
    echo "-------------------------------------------------------------"
    echo "[KO] Problème sur la ligne du fichier rsync : $i"; RC=1; fi
  done
  # Selon le code retour (RC = 0 ou 1), un message apparait.
  if [ $RC = 1 ]; then echo; echo "Veuiller aller dans le menu A pour coriger l'erreur"; fi
  if [ $RC = 0 ]; then       echo "Aucune erreur présent dans le fichier rsync"; fi
  #
 fi
 # Pause
 read -p "";
}

##################################################################################################################################################################################
# Menu C - Mode Simulation #
############################
func_HOST_ARCHIVAGE_RSYNC_SIMU(){
 read -p "Souhaitez vous activer le mode simulation ? (oui ou non) " HOST_RSYNC_SIM; HOST_RSYNC_SIM=${HOST_RSYNC_SIM:-oui}
}

##################################################################################################################################################################################
# Menu D - Lancer la sauvegarde #
#################################
func_HOST_ARCHIVAGE_RSYNC(){
# Si variable vide, un message est envoyé
 if [ -z $HOST_SERVEUR     ];then echo "La Valeur Serveur NULL"; fi
 if [ -z $HOST_DOMAINE     ];then echo "La Valeur DOMAINE NULL"; fi
 if [ -z $HOST_USERNAME    ];then echo "La Valeur USERNAME NULL"; fi
 if [ -z $HOST_SHARE       ];then echo "La Valeur Partage NULL"; fi
 if [ -z $HOST_MOUNTPOINT  ];then echo "La Valeur Point de montage NULL"; fi
 if [ -z $RC               ];then echo "Merci de lancer la vérification de Rsync via le menu B"; fi
 if [ -z $HOST_RSYNC_SIM   ];then echo "La valeur Rsync Simulation est NULL"; fi

 # Si la valeur HOST_MOUNTPOINT est pas NULL, création d'une variable MOUNT.
 if [ ! -z $HOST_MOUNTPOINT ];then MOUNT=$(df -h $HOST_MOUNTPOINT | tail -n 1 | cut -d " " -f1); fi

 # Si la valeur Serveur,SHARE et MOUNTPOINT sont pas NULL alors lancer le script
 if [ ! -z $HOST_SERVEUR ] && [ ! -z $HOST_SHARE ] && [ ! -z $HOST_MOUNTPOINT ] && [ ! -z $RC ] && [ ! -z $HOST_RSYNC_SIM ] && [ ! -z $(df -h $HOST_MOUNTPOINT | tail -n 1 | cut -d " " -f1) ];then
    # ==============================================================================================================================================================================================
    # Comparaison du point de montage avec le montage attendu
    if [ $(df -h $HOST_MOUNTPOINT | tail -n 1 | cut -d " " -f1) == "//$HOST_SERVEUR/$HOST_SHARE" ];then
       # ===========================================================================================================================================================================================
       if [ $RC = 1 ]; then echo "La vérification du fichier Rsync est incorrecte, merci de lancer le menu A puis le B"; fi
       # ===========================================================================================================================================================================================
       if [ $RC = 0 ];then
           clear;
           if   [ $HOST_RSYNC_SIM = "oui" ];then for i in $(cat $HOME/rsync.txt | grep -v "^#");do rsync -avz --dry-run $i $HOST_MOUNTPOINT; done;
           elif [ $HOST_RSYNC_SIM = "non" ];then for i in $(cat $HOME/rsync.txt | grep -v "^#");do
            ########################################################################################################################################################################################
            if [ ! -d $HOST_MOUNTPOINT/Journal ];then mkdir $HOST_MOUNTPOINT/Journal; fi            
            echo "##########################################################################################################################"
            echo "# Dossier     : $i                                                                                                        "
            echo "# Taille      : $(du -h -d0 $i | cut -d "." -f 1-2 | cut -d "/" -f1)                                                      "
            echo "# Lancement   : $(date +"%d/%m/%y à %H:%M")                                                                               "
            echo "# Fichier log : $HOST_MOUNTPOINT/Journal/$DATE.log;                                                                       "
            ########################################################################################################################################################################################
            echo "##########################################################################################################################" >> $HOST_MOUNTPOINT/Journal/$DATE.log;
            echo "# Debut de l'archivage : $(date +"%d/%m/%y à %H:%M") pour le dossier $i                                                   " >> $HOST_MOUNTPOINT/Journal/$DATE.log;
            echo ""                                                                                                                           >> $HOST_MOUNTPOINT/Journal/$DATE.log;
            rsync -avz $i $HOST_MOUNTPOINT                                                                                                    >> $HOST_MOUNTPOINT/Journal/$DATE.log;
            echo ""                                                                                                                           >> $HOST_MOUNTPOINT/Journal/$DATE.log;
            echo "# Fin de l'archivage : $(date +"%d/%m/%y à %H:%M") pour le dossier $i                                                     " >> $HOST_MOUNTPOINT/Journal/$DATE.log;
            echo "##########################################################################################################################" >> $HOST_MOUNTPOINT/Journal/$DATE.log;
            echo ""                                                                                                                           >> $HOST_MOUNTPOINT/Journal/$DATE.log;
            echo ""                                                                                                                           >> $HOST_MOUNTPOINT/Journal/$DATE.log;
            ########################################################################################################################################################################################
            echo "# Terminé     : $(date +"%d/%m/%y à %H:%M")                                                                               "
            echo "##########################################################################################################################"
            echo ""
            ########################################################################################################################################################################################
           done;
           else echo "La valeur du Mode Simulation est incorrecte";
           fi
       fi
       # =================================================================================================================================================================
    fi
    # ==============================================================================================================================================================================================
 fi
 #
 # Pause
 echo
 echo "Le fichier log est accessible au chemin suivant $HOST_MOUNTPOINT/Journal/$DATE.log";
 echo
 read -p "Veuiller appuyer sur une touche pour continuer";
}

##################################################################################################################################################################################
# Menu R #
##########
func_RECAP()         {
 NUMBER_LINE_BACKUP=$(cat rsync.txt | grep "^#" | wc -l)
 clear;
 echo "# ====================================================== #";
 echo "#              Resumer de la configuration               #";
 echo "# ====================================================== #";
 echo "> Adresse IP      : $HOST_SERVEUR";
 echo "> Nom de domaine  : $HOST_DOMAINE";
 echo "> Identifiant     : $HOST_USERNAME";
# echo "> Mot de passe    : $HOST_PASSWORD";
 echo "> Nom du partage  : $HOST_SHARE";
 echo "> Chemin UNC      : //$HOST_SERVEUR/$HOST_SHARE";
 echo "> Chemin local    : $HOST_MOUNTPOINT"
 echo
 echo "# ====================================================== #";
 echo "#             Information sur la sauvegarde              #";
 echo "# ====================================================== #";
 echo "> Etat du mode Simulation      : $HOST_RSYNC_SIM";
 echo "> Nb de dossier à sauvegarder  : $NUMBER_LINE_BACKUP";
 echo "# ====================================================== #";
}

##################################################################################################################################################################################
func_BACKUP_CONFIG(){
echo "######################################
HOST_SERVEUR=\"$HOST_SERVEUR\"
HOST_DOMAINE=\"$HOST_DOMAINE\"
HOST_USERNAME=\"$HOST_USERNAME\"
HOST_SHARE=\"$HOST_SHARE\"
HOST_MOUNTPOINT=\"$HOST_MOUNTPOINT\"
HOST_RSYNC_SIM=\"$HOST_RSYNC_SIM\"
######################################" > settings;
}

##################################################################################################################################################################################
# Contenu du Menu #
###################
func_MENU()          {
echo "############################################################"
echo "#     Information pour le montage du partage (Etat AD: $AD)  #"
echo "############################################################"
echo "Menu 0: Adresse du serveur ($HOST_SERVEUR)"
echo "Menu 1: Nom du domaine     ($HOST_DOMAINE)"
echo "Menu 2: Nom d'utilisateur  ($HOST_USERNAME)"
echo "Menu 3: Mot de passe"
#echo "Menu 3: Mot de passe       ($HOST_PASSWORD)"
echo "Menu 4: Nom du partage     ($HOST_SHARE)"
echo
echo "############################################################"
echo "#          Gestion du montage sur la machine HOTE          #"
echo "############################################################"
echo "Menu 5: Point de montage   ($HOST_MOUNTPOINT)"
echo "Menu 6: Creation du dossier de montage"
echo "Menu 7: Demontage du partage"
echo "Menu 8: Montage du partage"
echo "Menu 9: Editer le fichier des chemins à sauvegarder"
echo
echo "############################################################"
echo "#          Actions Spécial sur le système                  #"
echo "############################################################"
echo "Menu A: Vérification des montages"
echo "Menu B: Vérification des chemins de Rsync"
echo "Menu C: Mode Simulation ($HOST_RSYNC_SIM)"
echo "Menu D: Lancer la sauvegarde"
echo "Menu R: Résumer des actions"
echo "Menu T: Sauvegarder la configuration actuelle"
echo "Menu Q: Quitter le menu"
echo
echo
echo "############################################################"
echo "                     En Developpement                      #"
echo "############################################################"
echo "Menu E: Verifier si un backup est actif"
echo "Menu F: Tuer Rsync en Urgence";
echo "Menu I: Information sur le script"
echo
echo "############################################################"
echo
read -p "Indiquer votre choix: " choix
echo
}

##################################################################################################################################################################################
# Action du menu #
##################
func_CHOIX(){
case $choix in
 # ------------------------------------------------------------ #
 0)
  func_SRV_ADRESS; clear;
 ;;
 # ------------------------------------------------------------ #
 1)
  func_SRV_DOMAINE; clear;
 ;;
 # ------------------------------------------------------------ #
 2)
  func_SRV_USERNAME; clear;
 ;;
 # ------------------------------------------------------------ #
 3)
  func_SRV_PASSWORD; clear;
 ;;
 # ------------------------------------------------------------ #
 4)
  func_SRV_PARTAGE; clear;
 ;;
 # ------------------------------------------------------------ #
 5)
  func_HOST_MOUNT1; clear;
 ;;
 # ------------------------------------------------------------ #
 6)
  func_HOST_MKDIR; clear;
 ;;
 # ------------------------------------------------------------ #
 7)
  func_HOST_UMOUNT; clear;
 ;;
 # ------------------------------------------------------------ #
 8)
  if [ $AD = 0 ];then   func_HOST_MOUNT2;
  elif [ $AD = 1 ];then func_HOST_MOUNT2_AD;
  else                  echo "Menu 8 en anomalie";
  fi
  clear;
 ;;
 # ------------------------------------------------------------ #
 9)
 func_HOST_EDIT_RSYNC_FILE; clear;
 ;;
 # ------------------------------------------------------------ #
 a|A)
  func_HOST_CHECKMOUNT; clear;
 ;;
 # ------------------------------------------------------------ #
 b|B)
  func_HOST_CHECK_RSYNC_FOLDER; clear;
 ;;
 # ------------------------------------------------------------ #
 c|C)
  func_HOST_ARCHIVAGE_RSYNC_SIMU;
  clear;
 ;;
 # ------------------------------------------------------------ #
 d|D)
 func_HOST_ARCHIVAGE_RSYNC; clear;
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
 # ------------------------------------------------------------ #
 ;;
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
 t|T)
  echo
  func_BACKUP_CONFIG;
  echo    "#-------------------------#"
  echo    "# Bienvenue sur le menu T #"
  echo    "#-------------------------#"
  read -p ""
  clear;
 ;;
 # ------------------------------------------------------------ #
 q|Q)
  clear; exit;
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

##################################################################################################################################################################################
# Nettoyage de la console #
###########################
clear;

##################################################################################################################################################################################
# Récupération de l'ID en cours #
#################################
ID=$(id -u)

##################################################################################################################################################################################
# Vérification Root #
#####################
if [[ $ID = 0 ]];then MENU=0; else echo "Veuiller lancer le script depuis root"; MENU=1; fi

##################################################################################################################################################################################
# Boucle Infinie #
##################
# Si Root, la valeur MENU est sur 0 alors lance le menu
while [ $MENU = 0 ];do func_MENU; func_CHOIX; done

##################################################################################################################################################################################
