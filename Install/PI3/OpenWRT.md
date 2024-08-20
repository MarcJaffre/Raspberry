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
> Indiquer dans le champs de recherche `Raspberry Pi (3B/3B+/CM3 (32bit)`
>
> Télécharger l'image `Factory`.
>
> Extraire le fichier compresser jusqu'à obtenir un fichier `img`.

<br />

#### 3. Flasher
L'utilitaire `gnome-disks` permet de flasher la carte SD via `Restaurer l'image disque ...` .

<br />

#### 3. Personnaliser les paquets installés (Optionnel)
Ajouter dans la liste des paquets le paquet `luci-ssl` qui permet de faire fonctionner l'interface graphique `Luci` si besoin.

![image](https://github.com/user-attachments/assets/baeda5ca-e305-42f6-9f3c-296e7c180c04)


<br />
<br />

----------------------------------------------------------------------------------------------------------------------------------------------------------------
## III. Configuration
### A. Accéder au panel LUCI
> 1. Brancher le PC directement sur le Raspberry via le port RJ45
>    
> 2. Taper l'url du routeur en relevant l'adresse de la passerelle.

### B. Création d'un device
Ouvrir le menu `Network` puis `Interfaces`. Cliquer sur `Device`.

Dans le menu `Device`, cliquer sur `Add device configuration`, indiquer les réglages ci-dessosu puis cliquer sur `Save`.

```
- Device Type : Bridge device
- Device Name : LAN
- Bridge Port : Unspecified
```

### B. Création d'une interface
Ouvrir le menu `Network` puis `Interfaces`.
#### 1. Supprimer l'interface LAN
Cliquer sur `Delete` sur l'interface `lan` qui est déjà présent. (**NE SURTOUT PAS FAIRE APPLY !!!!**)

#### 2. Création d'une interface (Partie 1)
Cliquer sur `Add new interface` puis remplir les champs du panneau `Add new interface` puis cliquer sur `Cliquer sur Create interface`.
```
- Name         : LAN
- Protocol     : Static IP
- Device       : Bridge "LAN"
```


#### 2. Création d'une interface (Partie 2)
Cliquer sur `Add new interface` puis remplir les champs du panneau `Add new interface` puis cliquer sur `Cliquer sur Create interface`.
```
- IPv4 address : 192.168.10.1
- IPv4 Mask    : 255.255.255.0
- IPv4 gateway : NONE
```

#### 2. Création d'une interface (Partie 3)
Dans la partie supérieur de la fenètre, cliquer sur `DHCP Server` puis cliquer sur `Set up DHCP Server` pour activer le DHCP.

Le DHCP commence de l'adresse `192.168.10.2` et se termine à `192.168.10.254` avec un bail de 12 Heure. (2 + 252 = 254)
```
Start : 2
Limit : 252
Lease : 12h
```
