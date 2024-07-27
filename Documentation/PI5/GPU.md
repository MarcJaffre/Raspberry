------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## <p align='center'> Information Divers </p>

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
### I. Matériel
#### A. Raspberry 5
##### X.Lister les périphériques
```bash
clear;
v4l2-ctl --list-devices;
```

```
rpivid (platform:rpivid):
 /dev/video19
 /dev/media2
```
        
##### X. V4L2 I/O
```bash
clear;
v4l2-ctl --info --device /dev/video19;
v4l2-ctl --info --device /dev/video29;
v4l2-ctl --info --device /dev/video30;
v4l2-ctl --info --device /dev/video31;
v4l2-ctl --info --device /dev/video32;
v4l2-ctl --info --device /dev/video33;
v4l2-ctl --info --device /dev/video34;
v4l2-ctl --info --device /dev/video35;
v4l2-ctl --info --device /dev/video37;
```

##### X. pispbe
```bash
clear;
v4l2-ctl --info --device /dev/video20;
v4l2-ctl --info --device /dev/video21;
v4l2-ctl --info --device /dev/video22;
v4l2-ctl --info --device /dev/video23;
v4l2-ctl --info --device /dev/video24;
v4l2-ctl --info --device /dev/video25;
v4l2-ctl --info --device /dev/video26;
v4l2-ctl --info --device /dev/video27;
v4l2-ctl --info --device /dev/video28;

```

##### X. lshw
```bash
apt install -y lshw;
lshw -short;
```

```
Chemin matériel  Périphérique  Classe         Description
============================================================
                                  system         Raspberry Pi 5 Model B Rev 1.0
/0                                bus            Motherboard
/0/1                              processor      cpu
/0/2                              processor      cpu
/0/3                              processor      cpu
/0/4                              processor      cpu
/0/5                              processor      l2-cache
/0/6                              processor      l3-cache
/0/7                              memory         4045MiB Mémoire système
/0/0                              bridge         Broadcom Inc. and subsidiaries
/0/0/0                            network        Ethernet controller
/1                usb1            bus            xHCI Host Controller
/2                usb2            bus            xHCI Host Controller
/2/1              scsi0           storage        External USB 3.0
/2/1/0.0.0        /dev/sda        disk           6001GB USB3.0 DISK00
/2/1/0.0.0/1      /dev/sda1       volume         5589GiB Windows NTFS volume
/2/1/0.0.1        /dev/sdb        disk           6001GB USB3.0 DISK01
/2/1/0.0.1/1      /dev/sdb1       volume         5589GiB Windows NTFS volume
/2/1/0.0.2        /dev/sdc        disk           4TB USB3.0 DISK02
/2/1/0.0.2/1      /dev/sdc1       volume         3726GiB Windows NTFS volume
/2/1/0.0.3        /dev/sdd        disk           2TB USB3.0 DISK03
/2/1/0.0.3/1      /dev/sdd1       volume         1863GiB Windows NTFS volume
/2/1/0.0.4        /dev/sde        disk           4TB USB3.0 DISK04
/2/1/0.0.4/1      /dev/sde1       volume         3726GiB Windows NTFS volume
/3                usb3            bus            xHCI Host Controller
/4                usb4            bus            xHCI Host Controller
/5                mmc0            bus            MMC Host
/5/aaaa           /dev/mmcblk0    disk           127GB SR128
/5/aaaa/1         /dev/mmcblk0p1  volume         512MiB Windows FAT volume
/5/aaaa/2         /dev/mmcblk0p2  volume         118GiB EXT4 volume
/6                mmc1            bus            MMC Host
/6/1                              generic        SDIO Device
/6/1/1            mmc1:0001:1     network        4345
/6/1/2            mmc1:0001:2     generic        4345
/6/1/3            mmc1:0001:3     communication  4345
/7                card0           multimedia     vc4hdmi0
/8                card1           multimedia     vc4hdmi1
/9                input0          input          pwr_button
/a                input1          input          vc4-hdmi-0
/b                input2          input          vc4-hdmi-0 HDMI Jack
/c                input3          input          vc4-hdmi-1
/d                input4          input          vc4-hdmi-1 HDMI Jack
/e                eth0            network        Ethernet interface
```


<br />

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
### II. Logiciels
