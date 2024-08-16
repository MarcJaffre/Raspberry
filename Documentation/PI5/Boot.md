----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# <p align='center'> Configuration du démarrage du Raspberry PI 5 sur la distrîbution Bookworm </p>

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## I. Présentation
### A. config.txt
Le fichier de configuration sous BookWorm se situe à l'emplacement `/boot/firmware/config.txt` .

### B. Obtenir la configuration actuellement
Tous les paramètres de configuration ne peuvent pas être récupérés à l'aide de vcgencmd.

#### 1. Afficher les valeurs non null
```bash
clear;
vcgencmd get_config int
```
#### 2. Afficher les valeurs null
```bash
clear;
vcgencmd get_config str;
```

### C. Limitation de la longueur de ligne
Il existe une limite de longueur de ligne de 98 caractères pour les entrées. 

Raspberry Pi OS ignore tous les caractères dépassant cette limite.

