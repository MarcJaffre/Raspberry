----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## <p align='center'> Sauvegarder et Restaurer les volumes Docker </p>

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
### I. Présentation
Les conteneurs Docker utilise les volumes pour les données dynamiques.

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
### II. Script de sauvegarde / restauration
#### A. Installation de CURL
```bash
clear;
apt install -y curl;
```
#### B. Téléchargement du script
```bash
clear;
curl -SL https://raw.githubusercontent.com/junedkhatri31/docker-volume-snapshot/main/docker-volume-snapshot -o /usr/local/bin/docker-volume-snapshot;
```

#### B. Modification des permissions
```bash
clear;
chmod +x /usr/local/bin/docker-volume-snapshot;
```

<br />

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
### III. Sauvegarder les volumes
#### A. Auto-création du fichier de configuration
```bash
clear;
cat > settings << EOF
#######################################################################################################################
# Dossier de stockage de la sauvegarde #
########################################
DATASTORE="/mnt/Media_5/test"

#######################################################################################################################
# Liste des volumes exclus #
############################
EXLUSION="backingFsBlockDev\|.db"
EOF
```

#### B. Auto-création du Script Backup.sh
```bash
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
    /usr/local/bin/docker-volume-snapshot create "\$VOLUME" "\$DATASTORE/\$VOLUME".tar 1>/dev/null;
    if [ \$? = 0 ]; then echo "Le volume \$VOLUME est sauvegardé"; fi
    echo "";
   done
fi
#######################################################################################################################
EOF
```



