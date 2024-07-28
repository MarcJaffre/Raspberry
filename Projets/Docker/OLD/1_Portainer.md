---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## <p align='center'> Mise en place du conteneur Portainer </p>

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## I. Présentation
Portainer est une interface Web pour l'administration des conteneurs 

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## II. Déploiement

### A. Création du fichier
```bash
clear;
nano portainer.yml;
```

### B. Contenu du fichier

```yml
################
version: '3.9' #
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
```


### C. Démarrage du conteneur (mode détacher)
```bash
clear;
docker-compose -f portainer.yml up -d;
```

### D. Accéder au panel administration
```
http://XXX.XXX.XXX.XXX:9000
```
