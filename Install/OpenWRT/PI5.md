----------------------------------------------------------------------------------------------------------------------------------------------------------------
## <p align='center'> [Installation d'un routeur OpenWRT sous Raspberry PI 5](https://openwrt.org/toh/raspberry_pi_foundation/raspberry_pi) </p>

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

#### 4. Real-Time Clock
Il est nécessaire d'ajouter le paquet `hwclock`, `i2c-tools` et `kmod-rtc-ds1307` puis d'éditer le fichier `/boot/config.txt`.
```
dtoverlay=i2c-rtc,ds1307
```

#### 5. FAN
Il est nécessaire d'ajouter le paquet `kmod-hwmon-gpiofan` puis d'éditer le fichier `/boot/config.txt`.
```
dtoverlay=gpio-fan,gpiopin=14,temp=80000
```

#### 7. Ajouter des Pilotes USB
```
kmod-usb-net-asix
kmod-usb-net-asix-ax88179
```

```
hwclock i2c-tools kmod-hwmon-gpiofan kmod-usb-net-asix kmod-usb-net-asix-ax88179

#kmod-i2c-bcm2835
#kmod-rtc-ds1307
```

```
dtparam=i2c1=on
dtparam=i2s=on
dtparam=spi=on
dtoverlay=i2c-rtc,ds1307
dtoverlay=gpio-fan,gpiopin=14,temp=80000
```
<br />
