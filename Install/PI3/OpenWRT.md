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
> 2. Taper l'url `http://192.168.1.1`

### B. Création d'un Device
Ouvrir le menu `Network` puis `Interfaces`. Cliquer sur `Device`.

Dans le menu `Device`, cliquer sur `Add device configuration`, indiquer les réglages ci-dessosu puis cliquer sur `Save`.

```
- Device Type : Bridge device
- Device Name : WAN
- Bridge Port : Ethernet Adapter "Eth0"
```

```
- Device Type : Bridge device
- Device Name : LAN
- Bridge Port : Unspecified
```

### C. Suppression d'un Device
Ouvrir le menu `Network` puis `Interface`. Cliquer sur `Devices` puis cliquer sur `Unconfigure` pour le device `br-lan`.


### D. Création d'une interface (WAN)
Ouvrir le menu `Network` puis `Interface`. Cliquer sur `Add new interface` puis configurer l'interface et cliquer sur `Save`.

```
[General Settings]
- Name     : WAN
- Protocol : DHCP Client
- Device   : Bridge WAN

[Firewall Settings]
 - Assiign Firewall Zone : WAN
```

### F. Création d'une interface (LAN)
Ouvrir le menu `Network` puis `Interface`. Cliquer sur `Add new interface` puis configurer l'interface et cliquer sur `Save`.

```
[General Settings]
- Name         : LAN
- Protocol     : Static address
- Device       : Bridge LAN
- IPV4 Address : 192.168.1.1
- IPV4 Mask    : 255.255.255.0

[Firewall Settings]
 - Assiign Firewall Zone : LAN

[DHCP Server] Set up DHCP Server
```

### G. Suppression de l'interface par défaut
Ouvrir le menu `Network` puis `Interface` et cliquer sur `Delete` sur le `LAN`.



### H. Création du Point WIFI
Ouvrir le menu `Network` puis `Wireless`.

#### 1. WIFI 2.4 GHz
Cliquer sur le bouton `ADD` concernant le point WIFI `802.11b/g/n` puis sur `Save`.
```
[General Setup]
- Operating Frequency
  > Mode    : Legacy (2.4 GHz)
  > Channel : 2.412 GHz

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
