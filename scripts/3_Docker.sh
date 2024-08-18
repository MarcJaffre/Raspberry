#!/usr/bin/bash

########################################################################################################################
# Nettoyage de la console #
###########################
clear;

########################################################################################################################
# Chargement des variables #
############################
source ./settings;

DATASTORE="/mnt/Media_5/Backup/Docker"

########################################################################################################################
# FONCTIONS #
#############
func_question(){
 read -p "Quel action souhaitre vous réaliser ? (backup | recovery)" REPONSE;
}

func_check_datastore(){
 if [ ! -d $DATASTORE ];then mkdir $DATASTORE 2>/dev/null; else echo "La variable Datastore est incorrect"; fi
}

func_get_container_running(){
 docker ps --format '{{.Names}}' | sort -n | xargs -n1 > /tmp/running;
}

func_get_volumes_container_running(){
rm /tmp/volumes 2>/dev/null;
for i in $(cat /tmp/running); do
 docker inspect $i | grep -i mounts -A20 | grep Source | grep -v "\/" | cut -d ":" -f 2 | cut -d '"' -f 2 >> /tmp/volumes;
done
}

func_docker_stop_container(){
for i in $(cat /tmp/running); do 
 echo "docker stop $i";
done
}

func_docker_start_container(){
 for i in $CN_RUNNING;do
  echo "docker stop $i";
 done
}

########################################################################################################################
# EN COURS #
############
func_volumes_backup(){
 if [ $REPONSE = backup ];then
  echo "Backup";
 fi
}

func_volumes_restore(){
 if [ $REPONSE = restore ];then
  echo "Restore";
 fi
}




########################################################################################################################
func_check_datastore;
func_get_container_running;
func_docker_stop_container;
func_volumes_backup;
func_volumes_restore;
func_docker_start_container;
