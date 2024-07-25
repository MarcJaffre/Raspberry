--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## <p align='center'> Installation de Docker et Docker-compose </p>

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
### I. Déploiement de Docker et Docker-compose
Toutes les commandes doivent être lancés depuis un compte administrateur.


#### A. Mise à jour du système
```bash
clear;
apt update 1>/dev/null;
apt upgrade -y;
```

#### B. Installation du dépendances
```bash
clear;
apt install -y ca-certificates curl gnupg wget 1>/dev/null;
```

#### C. Ajout du dépôt de docker
```bash
clear;
install -m 0755 -d /etc/apt/keyrings;
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg;
chmod a+r /etc/apt/keyrings/docker.gpg;
echo "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
apt update 1>/dev/null;
```

#### D. Installation de docker
```bash
clear;
apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin;
```


#### E. Installation de docker-compose
```bash
clear;
curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose;
chmod +x /usr/local/bin/docker-compose;
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose;
```

#### F. Démarrer Portainer
L'URL de portainer sur le port 9443 (`https://192.168.1.19:9443`)


```bash
clear;
echo "################
version: '3.9' #
services:      #
################
#
 Portainer:
  image: 'portainer/portainer-ee'
  container_name: 'Portainer'
  network_mode: 'bridge'
  restart: 'always'
  hostname: 'Portainer'
  volumes:
   - '/var/run/docker.sock:/var/run/docker.sock'
   - '/etc/localtime:/etc/localtime:ro'
   - 'Data:/data'
  ports:
   - '8000:8000'
   - '9000:9000' # Webui HTTP
   - '9443:9443' # Webui HTTPS
  labels:
   Cacher: 'Oui'
############################################################################################
volumes:
 Data:
  external: false
############################################################################################" > portainer.yml;

############################################################################################
# Démarrage de portainer #
##########################
docker-compose -f portainer.yml up -d
############################################################################################
# Arrêt de portainer #
######################
# docker-compose -f portainer.yml down;
```


```
3-gPPDrrOiwK+WN8jI9rxvCA6vJj0REq/BjYCr4RCnFuUZp6zNJHaVf3tzk3LIBiPDYcwVQaXDMYYP
```

#### G. Serveur KMS
```bash
################
version: '3.9' #
services:      #
################
#
###########################################################################
# Activation de Microsoft Office VLK et Windows Client et serveur
 Microsoft:
  image: 'mikolatero/vlmcsd'
  container_name: 'kms'
  network_mode: 'bridge'
  restart: 'unless-stopped'
  hostname: 'kms'
  ports:
   - '1688:1688'
  labels:
   Cacher: 'Non'
###########################################################################
```



#### H. Activation de Windows 10 (PRO) [Licence KMS](https://github.com/Drthrax74/Microsoft/tree/main/Windows)
```
set KEY=W269N-WFGWX-YVC9B-4J6C9-T83GX
set KMS_SERVER=192.168.1.19
cscript //B "%windir%\system32\slmgr.vbs" -upk
cscript //B "%windir%\system32\slmgr.vbs" -ipk %KEY%
cscript //B "%windir%\system32\slmgr.vbs" -skms %KMS_SERVER% 
cscript //B "%windir%\system32\slmgr.vbs" -ato
"%windir%\system32\slmgr.vbs" -dlv
```
