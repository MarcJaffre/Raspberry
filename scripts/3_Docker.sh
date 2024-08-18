#!/usr/bin/bash

########################################################################################################################
# Nettoyage de la console #
###########################
clear;

########################################################################################################################
# Chargement des variables #
############################
source ./settings;

########################################################################################################################
# FONCTIONS #
#############
func_question(){
 read -p "Quel action souhaitre vous réaliser ? (backup | recovery)";
}

func_check_datastore(){
 if [ ! -d $DATASTORE ];then mkdir $DATASTORE 2>/dev/null; else echo "La variable Datastore est incorrect"; fi
}

func_get_container_running(){
 CN_RUNNING=$(docker ps --format '{{.Names}}')
}

func_docker_stop_container(){
 for i in $CN_RUNNING;do echo "docker stop $i"; done
}

