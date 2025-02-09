clear;
cat > restore.sh << EOF
#######################################################################################################################
#!/usr/bin/bash

#######################################################################################################################
# Nettoyage de la console #
###########################
clear;

#######################################################################################################################
# Chargement du ficher settings #
#################################
source ./settings;

#######################################################################################################################
# Question #
############
read -p "Souhaitez vous lancer la restauration ? (o|y) " VALIDATION

#######################################################################################################################
# Restauration #
################
if (( $VALIDATION == y || $VALIDATION == o ));then
   ####################################################################################################################
   # Arret des conteneurs
   clear;
   echo "Arrêt des conteneurs pendant la restauration";
     for i in $(docker ps --format '{{.Names}}');do docker stop $i; done
   ####################################################################################################################
   # Restauration des volumes
   for VOLUME in $(ls $DATASTORE | cut -d "." -f1 | xargs -n1)
   do
    # Actions par volume
     echo "___________________________________________________________________________________________________________"
    echo "Restauration du volume $VOLUME en cours";
    # ----------------------------------------------------------------------------- #
    docker-volume-snapshot restore $DATASTORE/$VOLUME.tar $VOLUME 1>/dev/null;
    # ----------------------------------------------------------------------------- #
    echo "Restauration du volume $VOLUME terminée";
    echo "";
   done
   ####################################################################################################################
   # Relance des conteneurs x2 (Conteneurs dependant de MariaDB)
   echo "Démarrage des conteneurs.";
   for i in $(docker ps -a --format '{{.Names}}');do docker start $i 2>/dev/null; done
   for i in $(docker ps -a --format '{{.Names}}');do docker start $i; done
   ####################################################################################################################   
fi
#######################################################################################################################
EOF
