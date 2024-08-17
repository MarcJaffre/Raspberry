------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## <p align='center'> Migration de Portainer Business Edition vers Community Edition </p>
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
### I Présentation

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
### II. Migration
#### A. Sauvegarder les volumes
La première chose est de sauvegarders les volumes pour permettent leur restauration en cas de problème.

#### B. Inspecter le conteneur Portaîner
Avant de détruire le conteneur, il faut connaitre le nom du volume que Portainer utilise
```bash
clear;
NAME_CONTENEUR="Portainer"
DATA=$(docker inspect $NAME_CONTENEUR | grep "Mounts" -A5 | head -n 5 | grep Source | cut -d ":" -f 2 | cut -d '"' -f 2)
echo "Le nom du volume contenant les données de Portaîner est : $DATA"
```


#### C. Migration de Business vers Community
On commence par détrûire le conteneur Portainer sans le paramètre de migration puis on le démarre avec le paramètre de migration. Une fois la migration du volûme, on détruit le conteneur.
```bash
clear;
if [ ! -z $NAME_CONTENEUR ]; then docker container rm -f $NAME_CONTENEUR; fi
if [ ! -z $NAME_CONTENEUR ]; docker run -it --name $NAME_CONTENEUR -v $DATA:/data portainer/portainer-ee --rollback-to-ce;
if [ ! -z $NAME_CONTENEUR ]; then docker container rm -f $NAME_CONTENEUR; fi
```

### E. Création du Docker-Compose
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
```


### E. Lancement du con^teneur Portainer-CE
On démarre le conteneur.
```bash
docker-compose -f portainer.yml down;
docker-compose -f portainer.yml up -d;
```
