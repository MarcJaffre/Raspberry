------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## <p align='center'> Installation et configuration d'un Raspberry PI 5</p>

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
### I. Présentation
#### A. Information Système
```
```



<br />

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
### II. Installation du système d'exploitation
#### A. Télécharger Raspberry Pi imager
Aller sur le site de Raspberry ([ici](https://www.raspberrypi.com/software/)) puis télécharger la version de Raspberry Imager.

#### B. Raspberry Pi imager
Sélectionner  `Raspeberry PI 5` > `Raspberry PI OS Lite (64 Bit)` > `SD Card`.

![image](https://github.com/user-attachments/assets/2038da19-2744-4359-abc3-f29c5c1aeed5)


#### C. Gestion des dépôts linux 

```bash
source /etc/os-release;
```
 
#### D. Mise à jour du Raspberry (Boot, Noyau ...)
```bash
clear;
rpi-update;
rpi-eeprom-update -d -a;
```
#### E. Mise à jour des paquets du Raspberry
```bash
clear;
apt update;
apt upgrade;
```


```bash
clear;
```



<br />

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
### III. Configuration
#### X. Nommage de la machine
#### X. Configuration de la Carte-réseau (Ethernet)


