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
# Chargement du fichier de configuration #
##########################################
source ./settings

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
