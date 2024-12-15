---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# <p align='center'> Installation Jellyfin sur un Raspberry PI</p>
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## I. Installation de Jellyfin
### A. Installation en dur
```bash
clear;
curl -s https://repo.jellyfin.org/install-debuntu.sh | bash
```

### B. Installation via Docker
Une image `Arm64` en `V8` est nécessaire pour le RaspberryPI 5

```
- CPU: 1 Core
- RAM: 1024Mo
```

```yml
################
services:      #
################
#
#
###########################################################
 Jellyfin:                                                #
  # ----------------------------------------------------- #
  image: 'linuxserver/jellyfin:arm64v8-10.10.2'           #
  container_name: 'Jellyfin'                              #
  network_mode: 'bridge'                                  #
  restart: 'unless-stopped'                               #
  # ----------------------------------------------------- #
  hostname: 'Jellyfin'                                    #
  # ----------------------------------------------------- #
  deploy:                                                 #
   # ---------------------------------------------------- #
   resources:                                             #
    limits:                                               #
     cpus: '2.00'                                         #
     memory: '2048M'                                      #
   # ---------------------------------------------------- #
    reservations:                                         #
     cpus: '0.02'                                         #
     memory: '8M'                                         #
   # ---------------------------------------------------- #
  # ----------------------------------------------------- #
  environment:                                            #
   # ---------------------------------------------------- #
   TZ: 'Europe/Paris'                                     #
   PUID: '0'                                              #
   PGID: '0'                                              #
   # ---------------------------------------------------- #
   JELLYFIN_PublishedServerUrl: '0.0.0.0'                 #
   # ---------------------------------------------------- #
   NVIDIA_VISIBLE_DEVICES: 'all'                          #
   NVIDIA_DRIVER_CAPABILITIES: 'all'                      # 
   # ---------------------------------------------------- #
  # ----------------------------------------------------- #
  volumes:                                                #
   - 'Data:/config'                                       #
   #- '/mnt/Media_1:/media/Media_1:ro'                    #
   #- '/mnt/Media_2:/media/Media_2:ro'                    #
   #- '/mnt/Media_3:/media/Media_3:ro'                    #
  # ----------------------------------------------------- #
  devices:                                                #
   - '/dev/dri:/dev/dri'                                  #
  # ----------------------------------------------------- #
  ports:                                                  #
   - '8096:8096'                                          #
  # ----------------------------------------------------- #
###########################################################
#
#
###########################################################
volumes:                                                  #
 # ------------------------------------------------------ #
 Data:                                                    #
  external: false                                         #
 # ------------------------------------------------------ #
###########################################################
```
<br />
<br />

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## II. Configuration de Jellyfin
### A. Accélération matérielle
Sélectionner `Video4Linux2 (V4L2)`.

<br />

### B. Activer le décodage matériel pour
Ce réglage force le décodage matériel côté client au lieu du serveur.
#### 1. H264
Le raspberry PI 5 n'a pas de décodage matériel, il faut donc `XXX`. (Test: décocher)

<br />

### C. Options d'encodage matériel
#### 1. Activer l'encodage matériel
Ce réglage force le décodage matériel côté client au lieu du serveur. Ne pas cocher.

<br />

### D. Options de format d'encodage
#### 1. Autoriser l'encodage au format HEVC
Ce réglage force l'encodage matériel côté client au lieu du serveur. Ne pas cocher.
#### 2. Autoriser l'encodage au format AV1
Ce réglage force l'encodage matériel côté client au lieu du serveur. Ne pas cocher.

<br />

### E. Nombre de threads de transcodage
Sélectionner la valeur sur  `Auto`. (Défaut)

<br />

### F. Chemin du dossier de secours des polices
#### 1. Activer les polices de secours
Ne pas cocher. (Défaut)

#### 2. Activer l’encodage audio VBR
Ne pas cocher. (Défaut)

<br />

### G. Algorithme de rééchantillonnage en stéréo
Sélectionner la valeur sur  `Aucun`. (Défaut)
<br />

### H. Taille maximale de la queue de multiplexage
Définir la valeur sur `2048` (Mo). (Test: 128 Mo)
<br />

### I. Profil d'encodage
Sélectionner la valeur sur `Ultrafast`.

#### 1. CRF d'encodage H.265
Définir la valeur sur `20`.

#### 2. CRF d'encodage H.264
Définir la valeur sur `22`.

<br />

### J. Méthode de désentrelacement
Définir la valeur sur `YADIF`. (Défaut)
#### 1. Multiplier par deux la fréquence d'images lors du désentrelacement
Ne pas cocher la case.

#### 2. Autoriser l'extraction des sous-titres à la volée
Ne pas cocher la case.

#### 3. Adapter la vitesse du transcodage
Ne pas cocher la case.

#### 4. Supprimer les segments
Ne pas cocher la case.

<br />

### K. Ajuster la vitesse après
Indiquer la valeur `180`. (Défaut)
<br />

### L. Durée de conservation des segments
Indiquer la valeur `720`. (Défaut)
<br />
