#!/usr/bin/bash

##################################################################################################################################
# Nettoyage de la console #
###########################
clear;

##################################################################################################################################
# Chargement des variables #
############################
#source ./settings;
DATASTORE="/mnt/Media_5/Backup/Docker"

##################################################################################################################################
func_question(){
 read -p "Quel action souhaitre vous réaliser ? (backup | recovery) " REPONSE;
}

##################################################################################################################################
func_check_datastore(){
 if [ ! -d $DATASTORE ];then
  mkdir $DATASTORE 2>/dev/null;
  echo "Creation du dossier";
 fi;
}

##################################################################################################################################
func_get_container_running(){
 docker ps --format '{{.Names}}' | sort -n | xargs -n1 > /tmp/running;
}

##################################################################################################################################
func_stop_container(){
 for i in $(cat /tmp/running);do
  docker stop $i 1>/dev/null;
 done;
}

##################################################################################################################################
func_start_container(){
 for i in $(cat /tmp/running);do
  docker start $i 1>/dev/null 2>/dev/null;
 done;
}

func_volumes_backup(){
for VOLUME in $(ls /var/lib/docker/volumes | sort -n | grep -v "backingFsBlockDev\|metadata.db");do
docker-volume-snapshot create "$VOLUME" "$DATASTORE"/"$VOLUME".tar;
done
}

func_volumes_backup
