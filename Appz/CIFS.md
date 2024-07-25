----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## <p align='center'> Utilisation d'un stockage CIFS (Partages) </p>

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## I. Présentation

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## II. Installation et utilisation de CIFS
### A. Installation du paquet
```bash
clear;
apt install cifs-utils;
apt install smbclient;
```

### B. Lister les partages
```bash
clear;
smbclient -L 192.168.0.2 -U marc%admin;
```

```
        Sharename       Type      Comment
        ---------       ----      -------
        print$          Disk      Printer Drivers
        SYSTEM          Disk      Acces au dossier root
        IPC$            IPC       IPC Service (Samba 4.17.12-Debian)
        marc            Disk      Home Directories
```



### C. Montage d'un partage (Ponctuellement)
L'identifiant marc à comme UserID 1000 et à commme GroupID 1000.

#### 1. Montage
```bash
clear;
mkdir /mnt/partage;
mount -t cifs -o username=marc,password=admin,uid=1000,gid=1000,forceuid,forcegid //192.168.0.2/homes /mnt/partage;
```
```
mount   : Programme de montage
-t cifs : Le type de partition à monté est CIFS
-o      : Indique une options
username: Identifiant pour la connexion CIFS
password: Mot de passe pour la connexion CIFS
uid     : Fichier et Dossier appartenant à l'utilisateur XXXX
gid     : Fichier et Dossier appartenant au groupe XXXX

//192.168.0.2/homes  : Chemin de partages
/mnt/partage         : Point de montage
```


#### 2. Vérification du montage
```bash
clear;
df -h /mnt/partage;
```
#### 3. Vérification des permissions
```bash
clear;
ls -lah /mnt/partage;
```
#### 4. Démontage
```bash
clear;
umount /mnt/partage;
```


### D. Montage d'un partage (Persistence)
##### 1. Editer le FSTAB
```bash
clear;
nano /etc/fstab;
```

```
//192.168.0.2/homes  /mnt/partage cifs _netdev,username=marc,password=admin,uid=1000,gid=1000  0 0
```

```
//192.168.0.2/homes  : Chemin de partages
/mnt/partage         : Point de montage
cifs                 : Le type de partition
_netdev              : Attendre que le réseau soit actif pour lancer le montage
username             : Identifiant pour la connexion CIFS
password             : Mot de passe pour la connexion CIFS
uid                  : Fichier et Dossier appartenant à l'utilisateur XXXX
gid                  : Fichier et Dossier appartenant au groupe XXXX
```


##### 2. Mise à jour de SystemD
```bash
clear;
systemctl daemon-reload;
```

##### 3. Lancer le montage automatique
```bash
clear;
mount -a;
```

##### 4. Vérification du montage
```bash
clear;
df -h;
```

##### 5. Vérification des permissions
```bash
clear;
ls -lah /mnt/partage;
```
