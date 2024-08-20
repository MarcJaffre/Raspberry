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
### A. Présentation

### B. Accéder au panel LUCI
> 1. Brancher le PC directement sur le Raspberry via le port RJ45
>    
> 2. Relevé l'adresse de la passerelle et taper l'url dans le navigateur

### B. Création du Pont
> 1. Network
>
> 2. Network
>
> 3. Devices
>
> 4. ADD



