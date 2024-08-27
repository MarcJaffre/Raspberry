------------------------------------------------------------------------------------------------------------------------------------
# <p align='center'> Installation d'un environnement bureautique sous Raspberry PI 5</p>

------------------------------------------------------------------------------------------------------------------------------------
## I. Installation de base
### A. Mise à jour
```bash
clear;
rpi-update rpi-6.6.y
apt update;
apt upgrade -y;
```

### B. Pilote Vidéo
```bash
clear;
apt install -y gldriver-test;
```

### C. Xorg
```bash
clear;
apt install -y xorg;
```

### D. Gestionnaire de Connexion
```bash
clear
apt install -y lightdm;
mkdir -p /var/lib/lightdm/data;
chown lightdm:lightdm /var/lib/lightdm/data;
```

### E. Cinnamon
```bash
clear;
apt install -y cinnamon;
apt install -y cinnamon-l10n;
```
