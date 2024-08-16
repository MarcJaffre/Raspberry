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

##### X. Détails du matériel
```bash
clear;
for device in $(ls /dev/video* | xargs -n 1); do
 echo "___________________________________________________________________________________________________________________________";
 echo "$device";
 echo "";
 v4l2-ctl --info --device $device;
 echo "";
 echo "";
done
```

### X. Format prise en charge
```bash
clear;
for device in $(ls /dev/video* | xargs -n 1); do
 echo "___________________________________________________________________________________________________________________________";
 echo "$device";
 echo "";
 v4l2-ctl --list-formats-out --device $device;
 echo "";
 echo "";
done
``` 

##### X. lshw
```bash
clear;
apt install -y lshw;
```

```bash
clear;
lshw;
```

```
raspberry-05
    description: Computer
    produit: Raspberry Pi 5 Model B Rev 1.0
    numéro de série: XXXXXXXXXXXXXXXXXXXX
    bits: 64 bits
    fonctionnalités: smp cp15_barrier setend swp tagged_addr_disabled
  *-core
       description: Motherboard
       identifiant matériel: 0
     *-cpu:0
          description: CPU
          produit: cpu
          identifiant matériel: 1
          information bus: cpu@0
          taille: 2400MHz
          capacité: 2400MHz
          fonctionnalités: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics fphp asimdhp cpuid asimdrdm lrcpc dcpop asimddp cpufreq
     *-cpu:1
          description: CPU
          produit: cpu
          identifiant matériel: 2
          information bus: cpu@1
          taille: 2400MHz
          capacité: 2400MHz
          fonctionnalités: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics fphp asimdhp cpuid asimdrdm lrcpc dcpop asimddp cpufreq
     *-cpu:2
          description: CPU
          produit: cpu
          identifiant matériel: 3
          information bus: cpu@2
          taille: 2400MHz
          capacité: 2400MHz
          fonctionnalités: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics fphp asimdhp cpuid asimdrdm lrcpc dcpop asimddp cpufreq
     *-cpu:3
          description: CPU
          produit: cpu
          identifiant matériel: 4
          information bus: cpu@3
          taille: 2400MHz
          capacité: 2400MHz
          fonctionnalités: fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics fphp asimdhp cpuid asimdrdm lrcpc dcpop asimddp cpufreq
     *-cpu:4 DÉSACTIVÉ
          description: CPU
          produit: l2-cache
          identifiant matériel: 5
          information bus: cpu@4
     *-cpu:5 DÉSACTIVÉ
          description: CPU
          produit: l3-cache
          identifiant matériel: 6
          information bus: cpu@5
     *-memory
          description: Mémoire système
          identifiant matériel: 7
          taille: 4045MiB
     *-pci
          description: PCI bridge
          produit: Broadcom Inc. and subsidiaries
          fabriquant: Broadcom Inc. and subsidiaries
          identifiant matériel: 0
          information bus: pci@0000:00:00.0
          version: 21
          bits: 32 bits
          horloge: 33MHz
          fonctionnalités: pci pm pciexpress normal_decode bus_master cap_list
          configuration: driver=pcieport
          ressources: irq:38 mémoire:1f00000000-1f005fffff
        *-network
             description: Ethernet controller
             identifiant matériel: 0
             information bus: pci@0000:01:00.0
             version: 00
             bits: 32 bits
             horloge: 33MHz
             fonctionnalités: pm pciexpress msix bus_master cap_list
             configuration: driver=rp1 latency=0
             ressources: irq:38 mémoire:1f00410000-1f00413fff mémoire:1f00000000-1f003fffff mémoire:1f00400000-1f0040ffff
  *-usbhost:0
       produit: xHCI Host Controller
       fabriquant: Linux 6.6.20+rpt-rpi-2712 xhci-hcd
       identifiant matériel: 1
       information bus: usb@1
       nom logique: usb1
       version: 6.06
       fonctionnalités: usb-2.00
       configuration: driver=hub slots=2 speed=480Mbit/s
  *-usbhost:1
       produit: xHCI Host Controller
       fabriquant: Linux 6.6.20+rpt-rpi-2712 xhci-hcd
       identifiant matériel: 2
       information bus: usb@2
       nom logique: usb2
       version: 6.06
       fonctionnalités: usb-3.00
       configuration: driver=hub slots=1 speed=5000Mbit/s
     *-usb
          description: Périphérique de stockage de masse
          produit: External USB 3.0
          fabriquant: JMicron
          identifiant matériel: 1
          information bus: usb@2:1
          nom logique: scsi0
          version: 52.03
          numéro de série: 20170331000C3
          fonctionnalités: usb-3.00 scsi emulated
          configuration: driver=usb-storage maxpower=8mA speed=5000Mbit/s
        *-disk:0
             description: SCSI Disk
             produit: USB3.0 DISK00
             fabriquant: External
             identifiant matériel: 0.0.0
             information bus: scsi@0:0.0.0
             nom logique: /dev/sda
             version: 5203
             numéro de série: 20170331000C3
             taille: 5589GiB (6001GB)
             fonctionnalités: gpt-1.00 partitioned partitioned:gpt
             configuration: ansiversion=6 guid=832ade6d-2853-b849-b489-1f6d9f3bfed1 logicalsectorsize=512 sectorsize=4096
           *-volume
                description: Windows NTFS volume
                fabriquant: Windows
                identifiant matériel: 1
                information bus: scsi@0:0.0.0,1
                nom logique: /dev/sda1
                nom logique: /mnt/Media_1
                version: 3.1
                numéro de série: 7c5b-68ad
                taille: 1493GiB
                capacité: 5589GiB
                fonctionnalités: ntfs initialized
                configuration: clustersize=4096 created=2024-05-02 18:39:51 filesystem=ntfs label=Media_1 mount.fstype=fuseblk mount.options=rw,relatime,user_id=0,group_id=0,allow_other,blksize=4096 state=mounted
        *-disk:1
             description: SCSI Disk
             produit: USB3.0 DISK01
             fabriquant: External
             identifiant matériel: 0.0.1
             information bus: scsi@0:0.0.1
             nom logique: /dev/sdb
             version: 5203
             numéro de série: 20170331000C3
             taille: 5589GiB (6001GB)
             fonctionnalités: gpt-1.00 partitioned partitioned:gpt
             configuration: ansiversion=6 guid=3d65afc2-4a97-9e44-990f-230f2e865a3e logicalsectorsize=512 sectorsize=4096
           *-volume
                description: Windows NTFS volume
                fabriquant: Windows
                identifiant matériel: 1
                information bus: scsi@0:0.0.1,1
                nom logique: /dev/sdb1
                nom logique: /mnt/Media_2
                version: 3.1
                numéro de série: 09bd-abac
                taille: 1493GiB
                capacité: 5589GiB
                fonctionnalités: ntfs initialized
                configuration: clustersize=4096 created=2024-04-24 21:54:14 filesystem=ntfs label=Media_2 mount.fstype=fuseblk mount.options=rw,relatime,user_id=0,group_id=0,allow_other,blksize=4096 state=mounted
        *-disk:2
             description: SCSI Disk
             produit: USB3.0 DISK02
             fabriquant: External
             identifiant matériel: 0.0.2
             information bus: scsi@0:0.0.2
             nom logique: /dev/sdc
             version: 5203
             numéro de série: 20170331000C3
             taille: 3726GiB (4TB)
             fonctionnalités: gpt-1.00 partitioned partitioned:gpt
             configuration: ansiversion=6 guid=09c50777-0149-42f1-ba39-007e7e905965 logicalsectorsize=512 sectorsize=4096
           *-volume
                description: Windows NTFS volume
                fabriquant: Windows
                identifiant matériel: 1
                information bus: scsi@0:0.0.2,1
                nom logique: /dev/sdc1
                nom logique: /mnt/Media_3
                version: 3.1
                numéro de série: 36411b18-881b-18bc-6418-bcbc36bcbc10
                taille: 1677GiB
                capacité: 3726GiB
                fonctionnalités: ntfs initialized
                configuration: clustersize=4096 created=2023-05-07 16:13:33 filesystem=ntfs label=Media_3 mount.fstype=fuseblk mount.options=rw,relatime,user_id=0,group_id=0,allow_other,blksize=4096 state=mounted
        *-disk:3
             description: SCSI Disk
             produit: USB3.0 DISK03
             fabriquant: External
             identifiant matériel: 0.0.3
             information bus: scsi@0:0.0.3
             nom logique: /dev/sdd
             version: 5203
             numéro de série: 20170331000C3
             taille: 1863GiB (2TB)
             fonctionnalités: gpt-1.00 partitioned partitioned:gpt
             configuration: ansiversion=6 guid=8e8b535a-1283-41d1-8563-6ceaf301c11b logicalsectorsize=512 sectorsize=512
           *-volume
                description: Windows NTFS volume
                fabriquant: Windows
                identifiant matériel: 1
                information bus: scsi@0:0.0.3,1
                nom logique: /dev/sdd1
                nom logique: /mnt/Media_4
                version: 3.1
                numéro de série: 5a13-a110
                taille: 1863GiB
                capacité: 1863GiB
                fonctionnalités: ntfs initialized
                configuration: clustersize=4096 created=2024-04-25 18:46:09 filesystem=ntfs label=Media_4 mount.fstype=fuseblk mount.options=rw,relatime,user_id=0,group_id=0,allow_other,blksize=4096 name=Basic data partition state=mounted
        *-disk:4
             description: SCSI Disk
             produit: USB3.0 DISK04
             fabriquant: External
             identifiant matériel: 0.0.4
             information bus: scsi@0:0.0.4
             nom logique: /dev/sde
             version: 5203
             numéro de série: 20170331000C3
             taille: 3726GiB (4TB)
             fonctionnalités: gpt-1.00 partitioned partitioned:gpt
             configuration: ansiversion=6 guid=eea006d3-8d6e-46cc-bba0-c7c76ea0448a logicalsectorsize=512 sectorsize=4096
           *-volume
                description: Windows NTFS volume
                fabriquant: Windows
                identifiant matériel: 1
                information bus: scsi@0:0.0.4,1
                nom logique: /dev/sde1
                nom logique: /mnt/Media_5
                version: 3.1
                numéro de série: 2ec4b1ef-df39-314c-902f-74a826f1c3d3
                taille: 1678GiB
                capacité: 3726GiB
                fonctionnalités: ntfs initialized
                configuration: clustersize=4096 created=2024-03-21 17:33:12 filesystem=ntfs label=Media_5 mount.fstype=fuseblk mount.options=rw,relatime,user_id=0,group_id=0,allow_other,blksize=4096 name=Basic data partition state=mounted
  *-usbhost:2
       produit: xHCI Host Controller
       fabriquant: Linux 6.6.20+rpt-rpi-2712 xhci-hcd
       identifiant matériel: 3
       information bus: usb@3
       nom logique: usb3
       version: 6.06
       fonctionnalités: usb-2.00
       configuration: driver=hub slots=2 speed=480Mbit/s
  *-usbhost:3
       produit: xHCI Host Controller
       fabriquant: Linux 6.6.20+rpt-rpi-2712 xhci-hcd
       identifiant matériel: 4
       information bus: usb@4
       nom logique: usb4
       version: 6.06
       fonctionnalités: usb-3.00
       configuration: driver=hub slots=1 speed=5000Mbit/s
  *-mmc0
       description: MMC Host
       identifiant matériel: 5
       nom logique: mmc0
     *-device
          description: SD Card
          produit: SR128
          fabriquant: SanDisk
          identifiant matériel: aaaa
          nom logique: /dev/mmcblk0
          version: 8.6
          date: 08/2023
          numéro de série: 3506210095
          taille: 119GiB (127GB)
          fonctionnalités: sd partitioned partitioned:dos
          configuration: logicalsectorsize=512 sectorsize=512 signature=a6b1eb76
        *-volume:0
             description: Windows FAT volume
             fabriquant: mkfs.fat
             identifiant matériel: 1
             nom logique: /dev/mmcblk0p1
             nom logique: /boot/firmware
             version: FAT32
             numéro de série: 44fc-6cf2
             taille: 507MiB
             capacité: 512MiB
             fonctionnalités: primary fat initialized
             configuration: FATs=2 filesystem=fat label=bootfs mount.fstype=vfat mount.options=rw,relatime,fmask=0022,dmask=0022,codepage=437,iocharset=ascii,shortname=mixed,errors=remount-ro state=mounted
        *-volume:1
             description: EXT4 volume
             fabriquant: Linux
             identifiant matériel: 2
             nom logique: /dev/mmcblk0p2
             nom logique: /
             version: 1.0
             numéro de série: 93c89e92-8f2e-4522-ad32-68faed883d2f
             taille: 118GiB
             capacité: 118GiB
             fonctionnalités: primary journaled extended_attributes large_files dir_nlink recover extents ext4 ext2 initialized
             configuration: created=2024-03-15 16:08:00 filesystem=ext4 label=rootfs lastmountpoint=/ modified=2024-07-27 06:09:42 mount.fstype=ext4 mount.options=rw,noatime mounted=2024-07-27 06:09:44 state=mounted
  *-mmc1
       description: MMC Host
       identifiant matériel: 6
       nom logique: mmc1
     *-device
          description: SDIO Device
          identifiant matériel: 1
          information bus: mmc@1:0001
          numéro de série: 0
          fonctionnalités: sdio
        *-interface:0 DÉSACTIVÉ
             description: Interface réseau sans fil
             produit: 4345
             fabriquant: Broadcom
             identifiant matériel: 1
             information bus: mmc@1:0001:1
             nom logique: mmc1:0001:1
             nom logique: wlan0
             numéro de série: d8:3a:dd:a8:8f:1b
             fonctionnalités: ethernet physical wireless
             configuration: broadcast=yes driver=brcmfmac driverversion=7.45.234 firmware=01-996384e2 multicast=yes wireless=IEEE 802.11
        *-interface:1
             produit: 4345
             fabriquant: Broadcom
             identifiant matériel: 2
             information bus: mmc@1:0001:2
             nom logique: mmc1:0001:2
        *-bt
             description: BlueTooth interface
             produit: 4345
             fabriquant: Broadcom
             identifiant matériel: 3
             information bus: mmc@1:0001:3
             nom logique: mmc1:0001:3
             fonctionnalités: wireless bluetooth
             configuration: wireless=BlueTooth
  *-sound:0
       description: vc4hdmi0
       identifiant matériel: 7
       nom logique: card0
       nom logique: /dev/snd/controlC0
       nom logique: /dev/snd/pcmC0D0p
  *-sound:1
       description: vc4hdmi1
       identifiant matériel: 8
       nom logique: card1
       nom logique: /dev/snd/controlC1
       nom logique: /dev/snd/pcmC1D0p
  *-input:0
       produit: pwr_button
       identifiant matériel: 9
       nom logique: input0
       nom logique: /dev/input/event0
       fonctionnalités: platform
  *-input:1
       produit: vc4-hdmi-0
       identifiant matériel: a
       nom logique: input1
       nom logique: /dev/input/event1
       fonctionnalités: cec
  *-input:2
       produit: vc4-hdmi-0 HDMI Jack
       identifiant matériel: b
       nom logique: input2
       nom logique: /dev/input/event2
  *-input:3
       produit: vc4-hdmi-1
       identifiant matériel: c
       nom logique: input3
       nom logique: /dev/input/event3
       fonctionnalités: cec
  *-input:4
       produit: vc4-hdmi-1 HDMI Jack
       identifiant matériel: d
       nom logique: input4
       nom logique: /dev/input/event4
  *-network
       description: Ethernet interface
       identifiant matériel: e
       nom logique: eth0
       numéro de série: d8:3a:dd:a8:8f:1a
       taille: 1Gbit/s
       capacité: 1Gbit/s
       fonctionnalités: ethernet physical tp mii 10bt 10bt-fd 100bt 100bt-fd 1000bt 1000bt-fd autonegotiation
       configuration: autonegotiation=on broadcast=yes driver=macb driverversion=6.6.20+rpt-rpi-2712 duplex=full ip=192.168.20.2 link=yes multicast=yes port=twisted pair speed=1Gbit/s
```



```bash
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
