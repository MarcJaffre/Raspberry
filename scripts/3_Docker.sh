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
func_question(){ read -p "Quel action souhaitre vous réaliser ? (backup | restore) " REPONSE; }
func_check_datastore(){ if [ ! -d $DATASTORE ];then mkdir $DATASTORE 2>/dev/null; echo "Creation du dossier"; fi; }
func_get_container_running(){ docker ps --format '{{.Names}}' | sort -n | xargs -n1 > /tmp/running; }
func_stop_container(){ for i in $(docker ps -a --format '{{.Names}}' | sort -n | xargs -n1); do echo docker stop $i; done; }
func_start_container(){ for i in $(cat /tmp/running);do echo docker start $i ; done; }
# 1>/dev/null 2>/dev/null
##################################################################################################################################
func_volumes_backup(){
 for VOLUME in $(ls /var/lib/docker/volumes | sort -n | grep -v "backingFsBlockDev\|metadata.db");do
  echo docker-volume-snapshot create "$VOLUME" "$DATASTORE"/"$VOLUME".tar;
 done
}

func_volumes_restore(){
 for VOLUME in $(ls $DATASTORE | cut -d "." -f1 | xargs -n1);do
  echo docker-volume-snapshot restore   $DATASTORE/$VOLUME.tar "$VOLUME" 
 done
}

##################################################################################################################################

func_question
func_check_datastore
func_get_container_running
func_stop_container

if [ $REPONSE = backup ];then
func_volumes_backup
elif [ $REPONSE = restore ];then
 func_volumes_restore
fi

func_start_container
