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


#### 3. Création d'une interface (Partie 2)
Cliquer sur `Add new interface` puis remplir les champs du panneau `Add new interface` puis cliquer sur `Cliquer sur Create interface`.
```
- IPv4 address : 192.168.10.1
- IPv4 Mask    : 255.255.255.0
- IPv4 gateway : NONE
```

#### 4. Création d'une interface (Partie 3)
Dans la partie supérieur de la fenètre, cliquer sur `Firewall Settings` puis choisir dans le menu la zone d'assignation `LAN`.


#### 5. Création d'une interface (Partie 4)

Dans la partie supérieur de la fenètre, cliquer sur `DHCP Server` puis cliquer sur `Set up DHCP Server` pour activer le DHCP

Le DHCP commence de l'adresse `192.168.10.2` et se termine à `192.168.10.254` avec un bail de 12 Heure. (2 + 252 = 254)
```
Start : 2
Limit : 252
Lease : 12h
```

#### 6. Création d'une interface (Partie 5)
Cliquer sur `SAVE`. (**NE SURTOUT PAS FAIRE APPLY !!!!**)


### C. Création du Point WIFI
Ouvrir le menu `Network` puis `Wireless`.

#### 1. WIFI 2.4 GHz
Cliquer sur le bouton `ADD` concernant le point WIFI `802.11b/g/n` puis sur `Save`.
```
[General Setup]
- Operating Frequency
  > Mode    : Legacy (2.4 GHz)
  > Channel : Auto

[Advanced Settings]
- Country Code          : FR - France
- Coverage cell density : Very High (24 mbps)


[Interface Configuration]
 [General Setup]
  - Mode       : Access Point
  - ESSID      : <NOM DE VOTRE SSID>
  - Network    : LAN (Le réseau Wifi sera attaché à l'interface LAN qui propose un DHCP)
  - Hide ESSID : Permet de cacher le réseau WIFI. (Optionnel)
 
 [Wireless Security]
  - Encryption: WPA2-PSK
  - KEY       : <CLE WIFI POUR SE CONNECTER> (8 Caractères minimum)
    
 [Mac-Filter]
  - Mac Address Filter : Permet l'activation du filtrage MAC pour se connecter au WIFI (optionel)

 [Advanced Setup]
  - Multi to Unicast : ???
  - Isolate client   : Permet de rendre impossible la communication entre client du WIFI. (Exemple: WIFI Public)
  - Interface NAME   : Nommer l'interface WIFI 
```


#### 2. WIFI 5 GHz
