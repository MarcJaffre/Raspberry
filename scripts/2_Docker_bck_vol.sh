clear;
cat > backup.sh << EOF
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
# Creation de dossier #
#######################
if [ ! -d \$DATASTORE ];then mkdir \$DATASTORE; fi

#######################################################################################################################
# Question #
############
read -p "Souhaitez vous lancer la sauvegarder ? (o|y) " VALIDATION

#######################################################################################################################
# Sauvegarde completes des volumes #
####################################
if (( \$VALIDATION == y || \$VALIDATION == o ));then
   # Lister les volumes
   for VOLUME in \$(ls /var/lib/docker/volumes | sort -n | grep -v "\$EXLUSION")
   do
    # Actions par volume
    echo "___________________________________________________________________________________________________________"
    echo "Le volume \$VOLUME est en cours de sauvegarde";
    # ----------------------------------------------------------------------------- #
    docker-volume-snapshot create "\$VOLUME" "\$DATASTORE/\$VOLUME.tar" 1>/dev/null;
    # ----------------------------------------------------------------------------- #
    if [ \$? = 0 ]; then echo "Le volume \$VOLUME est sauvegardé"; fi
    echo "";
   done
fi
#######################################################################################################################
EOF
