-----------------------------------------------------------------------------------------------------------------------
# <p align='center'> Chroot le système Raspberry </p>

-----------------------------------------------------------------------------------------------------------------------
## I. Présentation
### A. Raspberry
```bash
clear;
lsblk;
```

```
Filesystem      Size  Used Avail Use% Mounted on
/dev/sdb2        20G   14G  5.5G  71% /
/dev/sdb3        97G   24K   92G   1% /home
udev             16G     0   16G   0% /dev
tmpfs           3.2G  3.3M  3.2G   1% /run
```

-----------------------------------------------------------------------------------------------------------------------
## II. Guide de montage du CHROOT
### A. Lister les partitions
```bash
clear;
lsblk;
```

```
NAME              MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
loop0               7:0    0  29,8G  1 loop 
sda                 8:0    1   1,8T  0 disk 
├─sda1              8:1    1   487M  0 part /boot/efi
└─sda2              8:2    1   1,8T  0 part 
  ├─vg0-HOME      254:0    0 193,1G  0 lvm  /home
  ├─vg0-SYSTEM    254:1    0    30G  0 lvm  /
  ├─vg0-SWAP      254:2    0   3,7G  0 lvm  [SWAP]
  ├─vg0-DATA      254:3    0 931,3G  0 lvm  /Data
  └─vg0-Timeshift 254:4    0    30G  0 lvm  
sdb                 8:16   1 119,1G  0 disk 
├─sdb1              8:17   1   512M  0 part 
├─sdb2              8:18   1    20G  0 part 
└─sdb3              8:19   1  98,6G  0 part 
```

### B. Préparation de l'environnement
```bash
clear;
mkdir -p /mnt/linux/home;
```


### C. Montage des partitions
```bash
clear
mount /dev/sdb2    /mnt/linux/
mount /dev/sdb3    /mnt/linux/home/
mount --bind /dev  /mnt/linux/dev
mount --bind /proc /mnt/linux/proc
mount --bind /sys  /mnt/linux/sys
mount --bind /run  /mnt/linux/run/
```

### D. Chroot
```bash
clear
chroot /mnt/linux /bin/bash;
```

### E. Vérification
```bash
clear;
lsblk;
```


