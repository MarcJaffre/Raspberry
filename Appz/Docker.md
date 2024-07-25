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


### F. Service Docker (Expérimental)
Pour permettre le montage des partitions, il faut retarder le lancement de Docker
```bash
clear;
systemctl list-units | grep mount | grep Media | cut -c 3-100;
```

```bash
clear;
nano /lib/systemd/system/docker.service;
systemctl daemon-reload;
systemctl restart docker.service;
systemctl status docker.service;
```

Commenter les lignes
```
#After=network-online.target docker.socket firewalld.service containerd.service time-set.target
#Wants=network-online.target containerd.service
```

Ajouter les montages
```
After=network-online.target docker.socket firewalld.service containerd.service time-set.target mnt-Media_1.mount mnt-Media_2.mount mnt-Media_3.mount mnt-Media_4.mount mnt-Media_5.mount
Wants=network-online.target containerd.service mnt-Media_1.mount mnt-Media_2.mount mnt-Media_3.mount mnt-Media_4.mount mnt-Media_5.mount
```



