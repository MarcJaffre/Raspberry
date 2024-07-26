------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## <p align='center'> Monter des disque-dur </p>

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
### I. Présentation
#### A. Paquets
Le paquet `ntfs-3g` permet la prise en charge des partitions NTFS.

```bash
clear;
apt install ntfs-3g;
```

<br />

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
### II. Montages des partitions
#### A. Liste les stockages
La colonne Type permet de connaitre la nature de l'objet. (disque, partition) 

```bash
clear;
lsblk;
```

```
NAME        MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
---------------------------------------------------------
sda           8:0    0  5.5T  0 disk
└─sda1        8:1    0  5.5T  0 part
---------------------------------------------------------
sdb           8:16   0  5.5T  0 disk
└─sdb1        8:17   0  5.5T  0 part
---------------------------------------------------------
sdc           8:32   0  3.6T  0 disk
└─sdc1        8:33   0  3.6T  0 part
---------------------------------------------------------
sdd           8:48   0  1.8T  0 disk
└─sdd1        8:49   0  1.8T  0 part
---------------------------------------------------------
sde           8:64   0  3.6T  0 disk
└─sde1        8:65   0  3.6T  0 part
---------------------------------------------------------
mmcblk0     179:0    0 29.5G  0 disk
├─mmcblk0p1 179:1    0  512M  0 part /boot/firmware
└─mmcblk0p2 179:2    0   29G  0 part /
```


#### X. Obtenir le format des partitions

```bash
clear;
blkid;
```

```
/dev/sda1:      LABEL="Media_1"   BLOCK_SIZE="512" UUID="527C5B8B7C5B68AD"   TYPE="ntfs"                                    PARTUUID="e35f523b-edf0-0d4a-ac2b-dd46e33e82ee"
/dev/sdb1:      LABEL="Media_2"   BLOCK_SIZE="512" UUID="16B2983209BDABAC"   TYPE="ntfs"                                    PARTUUID="20144bc2-e8fc-5945-bcc0-9fb1c10303bf"
/dev/sdc1:      LABEL="Media_3"   BLOCK_SIZE="512" UUID="94001B57001B4022"   TYPE="ntfs"                                    PARTUUID="7c68d9e6-d528-4b58-8ac1-dcdca5c5a0c3"
/dev/sdd1:      LABEL="Media_4"   BLOCK_SIZE="512" UUID="105A13BF5A13A110"   TYPE="ntfs"   PARTLABEL="Basic data partition" PARTUUID="f42d79f3-e109-438e-b8fd-29cef83a45f1"
/dev/sde1:      LABEL="Media_5"   BLOCK_SIZE="512" UUID="80667AAF667AA596"   TYPE="ntfs"   PARTLABEL="Basic data partition" PARTUUID="710204b7-cd31-476e-9803-c1ac3d80ba41"
```

#### X. Création de point de montage
```bash
clear;
mkdir /mnt/Media_{1,2,3,4,5};
```

#### X. Modification du fstab ([Topic](https://forum.ubuntu-fr.org/viewtopic.php?id=1252901))
```bash
clear;
nano /etc/fstab;
```

```
LABEL="Media_1"       /mnt/Media_1    ntfs-3g   rw,user,auto,uid=1000,gid=1000,nofail   0       0
LABEL="Media_2"       /mnt/Media_2    ntfs-3g   rw,user,auto,uid=1000,gid=1000,nofail   0       0
LABEL="Media_3"       /mnt/Media_3    ntfs-3g   rw,user,auto,uid=1000,gid=1000,nofail   0       0
LABEL="Media_4"       /mnt/Media_4    ntfs-3g   rw,user,auto,uid=1000,gid=1000,nofail   0       0
LABEL="Media_5"       /mnt/Media_5    ntfs-3g   rw,user,auto,uid=1000,gid=1000,nofail   0       0
```

#### X. Demontage
```bash
clear;
umount /mnt/Media_1;
umount /mnt/Media_2;
umount /mnt/Media_3;
umount /mnt/Media_4;
umount /mnt/Media_5;
```

#### X. Mise à jour SystemD
```bash
clear;
systemctl daemon-reload;
```

#### X. Montage
```bash
clear;
mount -a;
```


#### X. Vérification du montage
```bash
clear;
df -h | grep "Mounte\|/mnt/Media";
```


#### X. Vérification des permissions
```bash
clear;
ls -lah /mnt/ | grep Media;
```

#### X. Gestion du Cache Disque-Dur
```bash
clear;
apt install -y hdparm;
hdparm -W 0 /dev/sd{a,b,c,d,e};
```
