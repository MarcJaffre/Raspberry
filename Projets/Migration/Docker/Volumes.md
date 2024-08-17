----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## <p align='center'> Mïgration de volume Docker </p>

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
### I. Présentation
Les conteneurs Docker utilise les volumes pour les données dynamiques. Les scripts suivant permet de créer une sauvegarde complète des volumes et de restaurer.


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
### AMELIORATION
#### A. P1
```
- KILL    des CONTENEURS !
- RELANCE des CONTENEURS !
```


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
### II. Script de sauvegarde et restauration
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

#### C. Auto-création du fichier de configuration
```bash
clear;
cat > settings << EOF
#######################################################################################################################
# Dossier de stockage de la sauvegarde #
########################################
DATASTORE=""

#######################################################################################################################
# Liste des volumes exclus #
############################
EXLUSION="backingFsBlockDev\|.db\|.log"

#######################################################################################################################
EOF
```

#### E. Editer le fichier de configuration
```bash
clear;
nano settings;
```

<br />
<br />

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
### III. Sauvegarder les volumes
Le script `backup.sh` permet la sauvegarde des volumes dans un dossier. Chaque volume à un fichier tar correspondant.

#### A. Auto-création du fichier de sauvegarde complète
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


   ####################################################################################################################
   # Arret des conteneurs #
   ########################
   echo "Arrêt des conteneurs pendant la sauvegarde";
   for i in \$(docker ps --format '{{.Names}}');do docker stop \$i; done
   ####################################################################################################################


   ####################################################################################################################
   # Realisation de la sauvegarde #
   ################################
   for VOLUME in \$(ls /var/lib/docker/volumes | sort -n | grep -v "\$EXLUSION"); do
     # Actions par volume
     echo "___________________________________________________________________________________________________________"
     echo "Le volume \$VOLUME est en cours de sauvegarde";
     # ----------------------------------------------------------------------------- #
     docker-volume-snapshot create "\$VOLUME" "\$DATASTORE/\$VOLUME.tar" 1>/dev/null;
     # ----------------------------------------------------------------------------- #
     if [ \$? = 0 ]; then echo "Le volume $VOLUME est sauvegardé"; fi
     echo "";
   done
   ####################################################################################################################


   ####################################################################################################################
   # Relance des conteneurs #
   ##########################
   echo "Démarrage des conteneurs.";
   for i in \$(docker ps -a --format '{{.Names}}');do docker start $i 2>/dev/null; done
   for i in \$(docker ps -a --format '{{.Names}}');do docker start $i 2>/dev/null; done
   ####################################################################################################################


fi
#######################################################################################################################
EOF
```

<br />
<br />

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
### IV. Restauration
Le script `restore.sh` permet la restauration des volumes depuis la sauvegarde. La journalisation n'est pas présent.

#### B. Auto-création du fichier de restauration complète
```bash
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
if (( \$VALIDATION == y || \$VALIDATION == o ));then
   ####################################################################################################################
   # Arret des conteneurs
   clear;
   echo "Arrêt des conteneurs pendant la sauvegarde";
   for i in \$(docker ps --format '{{.Names}}');do docker stop \$i; done
   ####################################################################################################################
   # Restauration des volumes
   for VOLUME in \$(ls \$DATASTORE | cut -d "." -f1 | xargs -n1)
   do
     # Actions par volume
     echo "___________________________________________________________________________________________________________"
     echo "Restauration du volume \$VOLUME en cours";
     # ----------------------------------------------------------------------------- #
     docker-volume-snapshot restore \$DATASTORE/\$VOLUME.tar \$VOLUME 1>/dev/null;
     # ----------------------------------------------------------------------------- #
     echo "Restauration du volume \$VOLUME terminée";
     echo "";
   done
   ####################################################################################################################
   # Relance des conteneurs
   echo "Démarrage des conteneurs.";
   for i in \$(docker ps -a --format '{{.Names}}');do docker start \$i 2>/dev/null; done
   ####################################################################################################################   
fi
#######################################################################################################################
EOF
```

### Purger tout les Volumes
```bash
clear;
systemctl restart docker.socket;
#docker volume rm \$(ls /var/lib/docker/volumes | grep -v "backingFsBlockDev\|.db") 2>/dev/null
```


<br />
<br />

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
### V. Note de travail
#### A. Base
```
L'utilisation de EOF oblige d'utiliser \ devant les variables sinon elle seront purgés.

xargs -n1 permet d'avoir un rendu par ligne.

ls \$DATASTORE
VOLUME1 VOLUME2 ....

ls \$DATASTORE | xargs -n1
VOLUME1
VOLUME2
```

#### B. Docker Volume Snapshot
```
usage: docker-volume-snapshot (create|restore) source destination
  create         create snapshot file from docker volume
  restore        restore snapshot file to docker volume
  source         source path
  destination    destination path

Tip: Supports tar's compression algorithms automatically based on the file extention, for example .tar.gz

Examples:
docker-volume-snapshot create xyz_volume xyz_volume.tar
docker-volume-snapshot create xyz_volume xyz_volume.tar.gz
docker-volume-snapshot restore xyz_volume.tar xyz_volume
docker-volume-snapshot restore xyz_volume.tar.gz xyz_volume
```
