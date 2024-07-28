#/usr/bin/bash

##############################################################################################################################################################
# Auteur: Marc Jaffre 
# Description: Sauvegarder / restaurer les volumes Docker de maniere simple
# Pre-requis: 
# curl -SL https://raw.githubusercontent.com/junedkhatri31/docker-volume-snapshot/main/docker-volume-snapshot -o /usr/local/bin/docker-volume-snapshot;
# chmod +x /usr/local/bin/docker-volume-snapshot;
#
##############################################################################################################################################################

# ls /var/lib/docker/volumes
#for i in $(docker volume ls | cut -c 11-200 | grep -v VOLUME | xargs -n 1)
#do
#  echo "Arrêt du conteneur : $i"
#done



##############################################################################################################################################################
# Nettoyage de la console #
###########################
clear;

##############################################################################################################################################################
# create | restore #
####################
DOSSIER="/mnt/Media_5/docker"
ACTION=""

##############################################################################################################################################################
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

##############################################################################################################################################################
# Check Root #
##############
if [ $(id -g) = 0 ]; then
 RC=0
else
 echo "Veuiller lancer le script en root";
fi

##############################################################################################################################################################
# Verification de la variable ACTION #
######################################
if [ -z $ACTION ]; then
 echo "La valeur Action est NULL, fermeture du script"
 exit
fi


##############################################################################################################################################################
# Execution du script #
#######################


# ===============================================================================================
if [ $RC = 0 ]; then
   # ===============================================================================
   if   [ $ACTION = create  ]; then
    systemctl stop docker.socket;
    systemctl stop docker.service;
    docker-volume-snapshot  create  $VOLUME001  $DOSSIER/$VOLUME001.tar 2>/dev/null;
    docker-volume-snapshot  create  $VOLUME002  $DOSSIER/$VOLUME002.tar 2>/dev/null;
    docker-volume-snapshot  create  $VOLUME003  $DOSSIER/$VOLUME003.tar 2>/dev/null;
    docker-volume-snapshot  create  $VOLUME004  $DOSSIER/$VOLUME004.tar 2>/dev/null;
    docker-volume-snapshot  create  $VOLUME005  $DOSSIER/$VOLUME005.tar 2>/dev/null;
    docker-volume-snapshot  create  $VOLUME006  $DOSSIER/$VOLUME006.tar 2>/dev/null;
    docker-volume-snapshot  create  $VOLUME007  $DOSSIER/$VOLUME007.tar 2>/dev/null;
    docker-volume-snapshot  create  $VOLUME008  $DOSSIER/$VOLUME008.tar 2>/dev/null;
    docker-volume-snapshot  create  $VOLUME009  $DOSSIER/$VOLUME009.tar 2>/dev/null;
    docker-volume-snapshot  create  $VOLUME010  $DOSSIER/$VOLUME010.tar 2>/dev/null;
    docker-volume-snapshot  create  $VOLUME011  $DOSSIER/$VOLUME011.tar 2>/dev/null;
    docker-volume-snapshot  create  $VOLUME012  $DOSSIER/$VOLUME012.tar 2>/dev/null;
    docker-volume-snapshot  create  $VOLUME013  $DOSSIER/$VOLUME013.tar 2>/dev/null;
    docker-volume-snapshot  create  $VOLUME014  $DOSSIER/$VOLUME014.tar 2>/dev/null;
    docker-volume-snapshot  create  $VOLUME015  $DOSSIER/$VOLUME015.tar 2>/dev/null;
    docker-volume-snapshot  create  $VOLUME016  $DOSSIER/$VOLUME016.tar 2>/dev/null;
    docker-volume-snapshot  create  $VOLUME017  $DOSSIER/$VOLUME017.tar 2>/dev/null;
    docker-volume-snapshot  create  $VOLUME018  $DOSSIER/$VOLUME018.tar 2>/dev/null;
    systemctl start docker.socket;
    systemctl start docker.service;
   # ===============================================================================
   elif [ $ACTION = restore ]; then
    systemctl stop docker.socket;
    systemctl stop docker.service;
    docker-volume-snapshot  restore $DOSSIER/$VOLUME001.tar  $VOLUME001 2>/dev/null;
    docker-volume-snapshot  restore $DOSSIER/$VOLUME002.tar  $VOLUME002 2>/dev/null;
    docker-volume-snapshot  restore $DOSSIER/$VOLUME003.tar  $VOLUME003 2>/dev/null;
    docker-volume-snapshot  restore $DOSSIER/$VOLUME004.tar  $VOLUME004 2>/dev/null;
    docker-volume-snapshot  restore $DOSSIER/$VOLUME005.tar  $VOLUME005 2>/dev/null;
    docker-volume-snapshot  restore $DOSSIER/$VOLUME006.tar  $VOLUME006 2>/dev/null;
    docker-volume-snapshot  restore $DOSSIER/$VOLUME007.tar  $VOLUME007 2>/dev/null;
    docker-volume-snapshot  restore $DOSSIER/$VOLUME008.tar  $VOLUME008 2>/dev/null;
    docker-volume-snapshot  restore $DOSSIER/$VOLUME009.tar  $VOLUME009 2>/dev/null;
    docker-volume-snapshot  restore $DOSSIER/$VOLUME010.tar  $VOLUME010 2>/dev/null;
    docker-volume-snapshot  restore $DOSSIER/$VOLUME011.tar  $VOLUME011 2>/dev/null;
    docker-volume-snapshot  restore $DOSSIER/$VOLUME012.tar  $VOLUME012 2>/dev/null;
    docker-volume-snapshot  restore $DOSSIER/$VOLUME013.tar  $VOLUME013 2>/dev/null;
    docker-volume-snapshot  restore $DOSSIER/$VOLUME014.tar  $VOLUME014 2>/dev/null;
    docker-volume-snapshot  restore $DOSSIER/$VOLUME015.tar  $VOLUME015 2>/dev/null;
    docker-volume-snapshot  restore $DOSSIER/$VOLUME016.tar  $VOLUME016 2>/dev/null;
    docker-volume-snapshot  restore $DOSSIER/$VOLUME017.tar  $VOLUME017 2>/dev/null;
    docker-volume-snapshot  restore $DOSSIER/$VOLUME018.tar  $VOLUME018 2>/dev/null;
    systemctl start docker.socket;
    systemctl start docker.service;
   # ===============================================================================
   else
    echo "Script en anomalie";
   fi
   # ===============================================================================
fi
# ===============================================================================================

##############################################################################################################################################################
# Fermeture du script #
#######################
exit

