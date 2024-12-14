------------------------------------------------------------------------------------------------------------
## <p align='center'> Anydesk </p>

------------------------------------------------------------------------------------------------------------
### I. Installation
#### A. Télécharger le paquet
```bash
clear;
PACKAGE=$(curl https://anydesk.com/fr/downloads/raspberry-pi | grep "https://download.anydesk.com/rpi" | head -n 2 | cut -c 1000-5000 | cut -d ":" -f 16-17  | cut -d "}" -f 1 | cut -c 2-80 | cut -d '"' -f 1)
wget $PACKAGE -O /tmp/anydesk.deb;
```

#### B. Installer le paquet
```bash
clear;
dpkg -i /tmp/anydesk.deb
apt install -f;
```
