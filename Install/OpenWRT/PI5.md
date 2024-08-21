----------------------------------------------------------------------------------------------------------------------------------------------------------------
## <p align='center'> Installation d'un routeur OpenWRT sous Raspberry PI 3B (1 Go) </p>

----------------------------------------------------------------------------------------------------------------------------------------------------------------
## I. Présentation
> Le routeur disposera d'une interface WAN en mode DHCP client, d'un LAN en mode DHCP et d'un point WIFI qui sera attaché sur le LAN.

<br />

----------------------------------------------------------------------------------------------------------------------------------------------------------------
## II. Création de la carte SD OpenWRT 


### A. OpenWRT
```
https://openwrt.org/toh/raspberry_pi_foundation/raspberry_pi
```

### B. Firmware
#### 1. Lien
```
https://firmware-selector.openwrt.org/
```
<br />

#### 2. Choisir l'image
> Sélectionner `SNAPSHOT` puis taper dans le champs recherche `Raspberry PI 5`
>
> Cliquer sur `Personnaliser les paquets installés et/ou le script de démarrage` pour personnaliser les paquets de la distribution.

#### 3. Activer les modules I2C et SPI
Il est nécessaire d'ajouter le paquet `kmod-i2c-bcm2835` puis d'éditer le fichier `/boot/config.txt`.
```
dtparam=i2c1=on
dtparam=i2s=on
dtparam=spi=on
```

#### 4. Ajouter des Pilotes
```
kmod-usb-net-asix
asix-ax88179
```

#### 5. Real-Time Clock
Il est nécessaire d'ajouter le paquet `kmod-rtc-ds1307` puis d'éditer le fichier `/boot/config.txt`.
```
dtoverlay=i2c-rtc,ds1307
```



<br />
