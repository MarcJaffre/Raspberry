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
#### 1. Montage
```bash
clear;
mkdir /mnt/partage;
mount -t cifs -o username=marc,password=admin,uid=1000,gid=1000,forceuid,forcegid //192.168.0.2/homes /mnt/partage

#
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

### D. Montage d'un partage (Permanent
##### 1. Editer le FSTAB
```bash
clear;
nano /etc/fstab;
```

```
##########################################################################################################
# Montage du partage #
######################
//192.168.0.2/homes  /mnt/partage cifs _netdev,username=marc,password=admin,uid=1000,gid=1000  0 0
##########################################################################################################
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

##### D. Vérification du montage
```bash
clear;
df -h;
```


##### E. Vérification des permissions
```bash
clear;
ls -lah /mnt/partage;
```

