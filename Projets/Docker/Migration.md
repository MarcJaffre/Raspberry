----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## <p align='center'> Sauvegarder et Restaurer les volumes Docker </p>

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
### I. Présentation
Les conteneurs Docker utilise les volumes pour les données dynamiques, pour migré les données il est nécessaire de sauvegarder les volumes.


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
### II. Sauvegarder les volumes
#### A. Création du fichier de configuration
```bash
clear;
cat > settings << EOF
DATASTORE="/mnt/Media_5/test"
EXLUSION="backingFsBlockDev\|.db"
EOF
```

#### B. Création du Script Backup.sh
```bash
clear;
cat > backup2.sh << EOF

#######################################################################################################################
# Chargement du ficher settings #
#################################
source ./settings;

#######################################################################################################################
# Creation de dossier #
#######################
if [ ! -d $FOLDER_BACKUP ];then mkdir $FOLDER_BACKUP; fi

#######################################################################################################################
# Question #
############
read -p "Souhaitez vous lancer la sauvegarder ? (y|n) " VALIDATION

#######################################################################################################################
# Sauvegarde completes des volumes #
####################################
if [ $VALIDATION = y ];then
   # Lister les volumes
   for VOLUME in $(ls /var/lib/docker/volumes | sort -n | grep -v "$EXLUSION")
   do
    # Actions par volume
    echo "___________________________________________________________________________________________________________"
    echo "Le volume $VOLUME est en cours de sauvegarde";
    /usr/local/bin/docker-volume-snapshot create $VOLUME $DATASTORE/$VOLUME.tar 1>/dev/null;
    if [ $? = 0 ]; then echo "Le volume $VOLUME est sauvegardé"; fi
    echo "";
   done
fi
```
