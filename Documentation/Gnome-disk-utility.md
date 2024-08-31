-----------------------------------------------------------------------------------------------
# <p align='center'> Sauvegarde, Restauration et Redimensionnement de partitionnement </p>

-----------------------------------------------------------------------------------------------
## I. Sauvegarde

-----------------------------------------------------------------------------------------------
## II. Restauration

-----------------------------------------------------------------------------------------------
## III. Redimensionnement
### A. [Depuis une IMG](https://blog.f8asb.com/2020/02/09/comment-faire-une-image-reduite-de-votre-carte-sd/)
#### 1. Montage
```bash
clear;
losetup -f;
losetup -Pf /Data/Raspberry/Backup/Raspbian_SRV_DOCKER.img;
losetup;
```

#### 2. Gparted
```bash
clear;
gparted /dev/loop0;
```

#### 3. Démontage
```bash
clear;
losetup -D /dev/loop0;
losetup;
```

#### 4. Compresser Image
On prend la fin du secteur de la second partition et on fait +1 et on multiplie par 512.
```bash
clear;
fdisk -l /Data/Raspberry/Backup/Raspbian_SRV_DOCKER.img | grep img2;
```

```
Périphérique                                    Amorçage   Début      Fin Secteurs Taille   Id Type
/Data/Raspberry/Backup/Raspbian_SRV_DOCKER.img1             8192      1056767      1048576   512M  c W95 FAT32 (LBA)
/Data/Raspberry/Backup/Raspbian_SRV_DOCKER.img2             1056768   42999807     41943040    20G 83 Linux
```

```bash
clear;
SIZE=$(fdisk -l /Data/Raspberry/Backup/Raspbian_SRV_DOCKER.img | grep img2  | awk '{print $3 }')
truncate --size=$[($SIZE+1)*512] /Data/Raspberry/Backup/Raspbian_SRV_DOCKER.img;
```
