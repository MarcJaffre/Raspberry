--------------------------------------------------------------------------------------------------------------
## <p align='center'> Mise en place du conteneur Portainer </p>

--------------------------------------------------------------------------------------------------------------
## I. Présentation
Portainer est une interface Web pour l'administration des conteneurs 

--------------------------------------------------------------------------------------------------------------
## II. Déploiement

### A. Création du fichier (Portainer-Ce)
```bash
clear;

cat >  portainer.yml << EOF
################
version: '3.8' #
services:      #
################
#
########################################################
 Portainer:                                            #
  image: 'portainer/portainer-ce'                      #
  container_name: 'Portainer'                          #
  network_mode: 'bridge'                               #
  restart: 'always'                                    #
  hostname: 'Portainer'                                #
  # -------------------------------------------------- #
  tty: true                                            #
  # -------------------------------------------------- #
  deploy:                                              #
   resources:                                          #
    limits:                                            #
     cpus: '0.50'                                      #
     memory: '256M'                                    #
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

# Arret de Docker
docker-compose -f portainer.yml down;

# Demarrage de Docker
docker-compose -f portainer.yml up -d;
```

### A. Création du fichier (Portainer-Ee)
```yml
cat >  portainer.yml << EOF
################
version: '3.8' #
services:      #
################
#
########################################################
 Portainer:                                            #
  image: 'portainer/portainer-ee'                      #
  container_name: 'Portainer'                          #
  network_mode: 'bridge'                               #
  restart: 'always'                                    #
  hostname: 'Portainer'                                #
  # -------------------------------------------------- #
  tty: true                                            #
  # -------------------------------------------------- #
  deploy:                                              #
   resources:                                          #
    limits:                                            #
     cpus: '1.00'                                      #
     memory: '200M'                                    #
  # -------------------------------------------------- #
  volumes:                                             #
   - '/var/run/docker.sock:/var/run/docker.sock'       #
   - '/etc/localtime:/etc/localtime:ro'                #
   - 'Data:/data'                                      #
  ports:                                               #
   - '8000:8000'                                       #
   - '9000:9000'                                       #
   - '9443:9443'                                       #
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

# Suppression Conteneur
docker container rm -f Portainer;

# Arret de Docker
docker-compose -f portainer.yml down;

# Demarrage de Docker
docker-compose -f portainer.yml up -d;
```

### C. Accéder au panel administration
```
http://XXX.XXX.XXX.XXX:9000
```
