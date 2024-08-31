--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# <p align='center'>  Raspberry PI5 sous Raspbian Lite OS x64 </p>

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## I. Graphique
### A. Mise à jour du système
```bash
clear;
apt update 1>/dev/null;
```

### B. Xorg
```bash
clear;
apt install -y xserver-xorg;
apt install -y xinit;
apt install -y x11-xserver-utils;
```

### C. LightDM
```bash
clear
apt install --no-install-recommends -y lightdm;
mkdir -p /var/lib/lightdm/data;
chown lightdm:lightdm /var/lib/lightdm/data;
systemctl restart lightdm;
systemctl set-default graphical.target;
```


#### D. [ArmBian](https://www.armbian.com/rpi5b/)
```bash
clear;
apt install -y mesa-utils;
```

<br />

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## III. Environnement Bureautique







[Moi](https://forums.raspberrypi.com/viewtopic.php?t=361664)

[XFCE4](https://www.pragmaticlinux.com/2020/11/install-the-xfce-desktop-on-your-raspberry-pi/?utm_content=cmp-true)

[TOPIC](https://forums.raspberrypi.com/viewtopic.php?t=285906)

[Guide GUI](https://forums.raspberrypi.com/viewtopic.php?t=133691)

[Adding a GUI to a Raspberry Pi running Raspberry Pi OS Lite](https://gijs-de-jong.nl/posts/adding-a-gui-to-a-raspberry-pi-with-vnc/)
