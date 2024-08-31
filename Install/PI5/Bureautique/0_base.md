--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# <p align='center'>  Raspberry PI5 sous Raspbian Lite OS x64 </p>

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## I. Graphique
### A. Mise à jour du système
```bash
clear;
clear;
apt update 1>/dev/null;
```

### B. Xorg
```bash
clear;
apt install --no-install-recommends xserver-xorg;
apt install --no-install-recommends xinit;
```

### C. LightDM
```bash
clear
apt install --no-install-recommends -y lightdm;
mkdir -p /var/lib/lightdm/data;
chown lightdm:lightdm /var/lib/lightdm/data;
systemctl restart lightdm;
```

<br />

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## III. Environnement Bureautique
### A. XFCE
```bash
clear;
apt install --no-install-recommends xserver-xorg;
apt install --no-install-recommends xinit;
apt install xfce4 xfce4-terminal;
apt install lightdm;
```




[Moi](https://forums.raspberrypi.com/viewtopic.php?t=361664)

[XFCE4](https://www.pragmaticlinux.com/2020/11/install-the-xfce-desktop-on-your-raspberry-pi/?utm_content=cmp-true)

https://forums.raspberrypi.com/viewtopic.php?t=285906
