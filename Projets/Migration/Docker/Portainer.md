------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## <p align='center'> Migration de Portainer Business Edition vers Community Edition </p>
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
### I Présentation
Migration de Portainer EE vers CE.

<br />

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
### II. Migration
#### A. Sauvegarder les volumes
La première chose est de sauvegarder les volumes pour permettent leur restauration en cas de problème.

#### B. Inspecter le conteneur Portaîner
Avant de détruire le conteneur, il faut connaitre le nom du volume que Portainer utilise
```bash
clear;
NAME_CONTENEUR="Portainer"
DATA=$(docker inspect $NAME_CONTENEUR | grep "Mounts" -A5 | head -n 5 | grep Source | cut -d ":" -f 2 | cut -d '"' -f 2)
echo "Le nom du volume contenant les données de Portaîner est : $DATA"
```

<br />

#### C. Migration de Business vers Community
On commence par détruire le conteneur Portainer puis on le démarre Portainer avec le paramètre de rollback vers CE. Une fois la migration du volûme, on détruit le conteneur uniquement.
```bash
clear;
if [ ! -z $NAME_CONTENEUR ]; then docker container rm -f $NAME_CONTENEUR; fi
if [ ! -z $NAME_CONTENEUR ]; then docker run -it --name $NAME_CONTENEUR -v $DATA:/data portainer/portainer-ee --rollback-to-ce; fi
if [ ! -z $NAME_CONTENEUR ]; then docker container rm -f $NAME_CONTENEUR; fi
```

<br />

### D. Création du Docker-Compose
La commande suivante crée le fichier `portainer.yml`, puis lance le conteneur.
```yml
cat >  portainer.yml << EOF
################
version: '3.9' #
services:      #
################
#
########################################################
 Portainer:                                            #
  # -------------------------------------------------- #
  image: 'portainer/portainer-ce'                      #
  container_name: 'Portainer'                          #
  network_mode: 'bridge'                               #
  restart: 'always'                                    #
  hostname: 'Portainer'                                #
  # -------------------------------------------------- #
  tty: true                                            #
  # -------------------------------------------------- #
  volumes:                                             #
   - '/var/run/docker.sock:/var/run/docker.sock'       #
   - '/etc/localtime:/etc/localtime:ro'                #
   - 'Data:/data'                                      #
  # -------------------------------------------------- #
  ports:                                               #
   - '8000:8000'                                       #
   - '9000:9000'                                       #
   - '9443:9443'                                       #
  # -------------------------------------------------- #
  tty: 'true'                                          #
  # -------------------------------------------------- #
  labels:                                              #
   Cacher: 'Oui'                                       #
########################################################
#
#
########################################################
volumes:                                               #
 Data:                                                 #
  external: false                                      #
########################################################
EOF

docker-compose -f portainer.yml down;
docker-compose -f portainer.yml up -d;
```
