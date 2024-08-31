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

#### D. [ArmBian](https://www.armbian.com/rpi5b/)
```
GPU acceleration only works with MESA v23.2. In order to get them to work (Bookworm):

Add ‘deb https://deb.debian.org/debian unstable main’ to the sources.list
sudo apt update && sudo apt -t unstable install libegl-mesa0 libgl1-mesa-dri mesa-utils mesa-utils-bin
Remove the line added in sources.list, then sudo apt update
Reboot the system.
```




<br />

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## III. Environnement Bureautique
### A. XFCE
```bash
clear;
apt install xfce4 xfce4-terminal;
apt install lightdm;
```




[Moi](https://forums.raspberrypi.com/viewtopic.php?t=361664)

[XFCE4](https://www.pragmaticlinux.com/2020/11/install-the-xfce-desktop-on-your-raspberry-pi/?utm_content=cmp-true)

https://forums.raspberrypi.com/viewtopic.php?t=285906

[Guide GUI](https://forums.raspberrypi.com/viewtopic.php?t=133691)

[Adding a GUI to a Raspberry Pi running Raspberry Pi OS Lite](https://gijs-de-jong.nl/posts/adding-a-gui-to-a-raspberry-pi-with-vnc/)
