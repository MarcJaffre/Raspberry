#/usr/bin/bash

##################################################################################################################################################################################
# Auteur: Marc Jaffre 
# Description: Sauvegarder / restaurer les volumes Docker de maniere simple
# Pre-requis: 
# curl -SL https://raw.githubusercontent.com/junedkhatri31/docker-volume-snapshot/main/docker-volume-snapshot -o /usr/local/bin/docker-volume-snapshot;
# chmod +x /usr/local/bin/docker-volume-snapshot;
#
##################################################################################################################################################################################


##################################################################################################################################
# Nettoyage de la console #
###########################
clear;

##################################################################################################################################
# create | restore #
####################
DOSSIER="/mnt/Media_5/docker"
ACTION=""

##################################################################################################################################
# Nom des volumes #
###################
VOLUME001="database_mariadb"
VOLUME002="filebrowser_Data"
VOLUME003="jellyfin_Data"
VOLUME004="outils_adguardhome_conf"
VOLUME005="outils_adguardhome_work"
VOLUME006="outils_bitwarden"
VOLUME007="outils_nginx_certif"
VOLUME008="outils_nginx_config"
VOLUME009="outils_nginx_data"

VOLUME010="Portainer"
VOLUME011="root_Data"

VOLUME012="warez_Jackett"
VOLUME013="warez_Jellyseerr"
VOLUME014="warez_Prowlarr"
VOLUME015="warez_Qbittorrent"
VOLUME016="warez_Qbittorrent_old"
VOLUME017="warez_Radarr"
VOLUME018="warez_Sonarr"

##################################################################################################################################
# Check Root #
##############
if [ $(id -g) = 0 ]; then
 RC=0
else
 echo "Veuiller lancer le script en root";
fi

##################################################################################################################################
# Verification de la variable ACTION #
######################################
if [ -z $ACTION ]; then
 echo "La valeur Action est NULL, fermeture du script"
 exit
fi


##################################################################################################################################
# Execution du script #
#######################


# ===============================================================================================
if [ $RC = 0 ]; then
   # ====================================================================
   if   [ $ACTION = create  ]; then
    docker-volume-snapshot  create  $VOLUME001  $DOSSIER/$VOLUME001.tar;
    docker-volume-snapshot  create  $VOLUME002  $DOSSIER/$VOLUME002.tar;
    docker-volume-snapshot  create  $VOLUME003  $DOSSIER/$VOLUME003.tar;
    docker-volume-snapshot  create  $VOLUME004  $DOSSIER/$VOLUME004.tar;
    docker-volume-snapshot  create  $VOLUME005  $DOSSIER/$VOLUME005.tar;
    docker-volume-snapshot  create  $VOLUME006  $DOSSIER/$VOLUME006.tar;
    docker-volume-snapshot  create  $VOLUME007  $DOSSIER/$VOLUME007.tar;
    docker-volume-snapshot  create  $VOLUME008  $DOSSIER/$VOLUME008.tar;
    docker-volume-snapshot  create  $VOLUME009  $DOSSIER/$VOLUME009.tar;
    docker-volume-snapshot  create  $VOLUME010  $DOSSIER/$VOLUME010.tar;
    docker-volume-snapshot  create  $VOLUME011  $DOSSIER/$VOLUME011.tar;
    docker-volume-snapshot  create  $VOLUME012  $DOSSIER/$VOLUME012.tar;
    docker-volume-snapshot  create  $VOLUME013  $DOSSIER/$VOLUME013.tar;
    docker-volume-snapshot  create  $VOLUME014  $DOSSIER/$VOLUME014.tar;
    docker-volume-snapshot  create  $VOLUME015  $DOSSIER/$VOLUME015.tar;
    docker-volume-snapshot  create  $VOLUME016  $DOSSIER/$VOLUME016.tar;
    docker-volume-snapshot  create  $VOLUME017  $DOSSIER/$VOLUME017.tar;
    docker-volume-snapshot  create  $VOLUME018  $DOSSIER/$VOLUME018.tar;

   # ====================================================================
   elif [ $ACTION = restore ]; then
    docker-volume-snapshot  create  $DOSSIER/$VOLUME001.tar  $VOLUME001;
    docker-volume-snapshot  create  $DOSSIER/$VOLUME002.tar  $VOLUME002;
    docker-volume-snapshot  create  $DOSSIER/$VOLUME003.tar  $VOLUME003;
    docker-volume-snapshot  create  $DOSSIER/$VOLUME004.tar  $VOLUME004;
    docker-volume-snapshot  create  $DOSSIER/$VOLUME005.tar  $VOLUME005;
    docker-volume-snapshot  create  $DOSSIER/$VOLUME006.tar  $VOLUME006;
    docker-volume-snapshot  create  $DOSSIER/$VOLUME007.tar  $VOLUME007;
    docker-volume-snapshot  create  $DOSSIER/$VOLUME008.tar  $VOLUME008;
    docker-volume-snapshot  create  $DOSSIER/$VOLUME009.tar  $VOLUME009;
    docker-volume-snapshot  create  $DOSSIER/$VOLUME010.tar  $VOLUME010;
    docker-volume-snapshot  create  $DOSSIER/$VOLUME011.tar  $VOLUME011;
    docker-volume-snapshot  create  $DOSSIER/$VOLUME012.tar  $VOLUME012;
    docker-volume-snapshot  create  $DOSSIER/$VOLUME013.tar  $VOLUME013;
    docker-volume-snapshot  create  $DOSSIER/$VOLUME014.tar  $VOLUME014;
    docker-volume-snapshot  create  $DOSSIER/$VOLUME015.tar  $VOLUME015;
    docker-volume-snapshot  create  $DOSSIER/$VOLUME016.tar  $VOLUME016;
    docker-volume-snapshot  create  $DOSSIER/$VOLUME017.tar  $VOLUME017;
    docker-volume-snapshot  create  $DOSSIER/$VOLUME018.tar  $VOLUME018;


   # ====================================================================
   else
    echo "Script en anomalie";
   fi
   # ====================================================================
fi
# ===============================================================================================
pause
