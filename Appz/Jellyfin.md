---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# <p align='center'> Installation Jellyfin </p>
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## I. Installation de Base
### A. Bash Générique
```bash
clear;
curl -s https://repo.jellyfin.org/install-debuntu.sh | bash
```


<br />

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## II. Lecture
### A. Accélération matérielle
Sélectionner `Video4Linux2 (V4L2)`.
### B. Activer le décodage matériel pour
Forcer le décodage matériel côté client, ne rien cocher !
```
- [] H264
```

### C. Options d'encodage matériel
Ne pas cocher `Activer l'encodage matériel`. Ceci force l'encodage côté client.

### D. Options de format d'encodage
Ne pas cocher `Autoriser l'encodage au format HEVC` et `Autoriser l'encodage au format AV1`. Ceci force l'encodage côté client.

### E. Nombre de threads de transcodage
Sélectionner `Auto`.

### F. Activer les polices de secours

### G. Activer l’encodage audio VBR

### H. Algorithme de rééchantillonnage en stéréo

### I. Taille maximale de la queue de multiplexage

### J. Profil d'encodage

### K. CRF d'encodage H.265

### L. CRF d'encodage H.264

### M. Méthode de désentrelacement
#### 1. Multiplier par deux la fréquence d'images lors du désentrelacement
#### 2. Autoriser l'extraction des sous-titres à la volée 


### N.
### O.
### P. 
