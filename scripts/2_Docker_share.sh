#!/bin/bash
####################################################################################################################################
# Information:
# Script qui ajout des volumes Docker
# Ces volumes sert a acceder au partage
# Parametres :
# - ,vers=3.0
# - ,file_mode=0777
# - ,dir_mode=0777
##################################################################################################################################################################################################
#
#
##################################################################################################################################################################################################
# Variables d_environnements #
##############################
# Connexion au serveur de partage
SERVEUR=""
UTILISATEUR=""
MOTDEPASSE=""
#
# Nom des partages Samba
PARTAGE_1=""
PARTAGE_2=""
PARTAGE_3=""
PARTAGE_4=""
PARTAGE_5=""
#
# Nom des volumes Docker
NAME_1=""
NAME_2=""
NAME_3=""
NAME_4=""
NAME_5=""

#
##################################################################################################################################################################################################
# Suppression des volumes #
###########################
docker volume rm -f ${NAME_1};
docker volume rm -f ${NAME_2};
docker volume rm -f ${NAME_3};
docker volume rm -f ${NAME_4};
docker volume rm -f ${NAME_5};
#
##################################################################################################################################################################################################
# Ajout des volumes #
#####################
docker volume create --driver local --opt type=cifs --opt device=//${SERVEUR}/${PARTAGE_1} --opt o=username=${UTILISATEUR},password=${MOTDEPASSE} --name ${NAME_1};
docker volume create --driver local --opt type=cifs --opt device=//${SERVEUR}/${PARTAGE_2} --opt o=username=${UTILISATEUR},password=${MOTDEPASSE} --name ${NAME_2};
docker volume create --driver local --opt type=cifs --opt device=//${SERVEUR}/${PARTAGE_3} --opt o=username=${UTILISATEUR},password=${MOTDEPASSE} --name ${NAME_3};
docker volume create --driver local --opt type=cifs --opt device=//${SERVEUR}/${PARTAGE_4} --opt o=username=${UTILISATEUR},password=${MOTDEPASSE} --name ${NAME_4};
docker volume create --driver local --opt type=cifs --opt device=//${SERVEUR}/${PARTAGE_5} --opt o=username=${UTILISATEUR},password=${MOTDEPASSE} --name ${NAME_5};
