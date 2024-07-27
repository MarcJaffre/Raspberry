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
rm  /usr/local/bin/docker-compose /usr/bin/docker-compose 2>/dev/null;
curl -L https://github.com/docker/compose/releases/download/v2.29.1/docker-compose-linux-aarch64 -o /usr/local/bin/docker-compose;
chmod +x /usr/local/bin/docker-compose;
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose;
/usr/bin/docker-compose;
```

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
### II. Migrer les volumes
#### A. Installation du [Docker Snapshot](https://github.com/junedkhatri31/docker-volume-snapshot)
```bash
clear;
curl -SL https://raw.githubusercontent.com/junedkhatri31/docker-volume-snapshot/main/docker-volume-snapshot -o /usr/local/bin/docker-volume-snapshot;
chmod +x /usr/local/bin/docker-volume-snapshot;
```
#### B. Sauvegarder un volume
La commande suivante permet de sauvegarder le volume `jellyfin_Data` dans le fichier compresser situer à `/root/jellyfin_Data.tar`
```
VOLUME="jellyfin_Data"
BACKUP_FOLDER="/tmp"
BACKUP_FILE="jellyfin_Data.tar"
docker-volume-snapshot create  $VOLUME $BACKUP_FOLDER/$BACKUP_FILE;
```

#### C. Restauration d'un volume
```bash
clear;
VOLUME="jellyfin_Data"
BACKUP_FOLDER="/tmp"
BACKUP_FILE="jellyfin_Data.tar"

docker-volume-snapshot restore $BACKUP_FOLDER/$BACKUP_FILE $VOLUME;
```

#### E. Syntaxe
```bash
docker-volume-snapshot (create|restore) source destination
  create         create snapshot file from docker volume
  restore        restore snapshot file to docker volume
  source         source path
  destination    destination path
```




