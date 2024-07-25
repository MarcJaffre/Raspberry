----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## <p align='center'> Indiquer à Docker d'attendre le montage des partitions </p>

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## I. Présentation
Le service docker se lance avant le montage et si les conteneurs utilisent les montages, les dossiers dans les conteneurs seront vides.

Pour éviter celà, on indique au système d'attendre les services de montages soit OK pour démarrer docker.


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
##

## Liste les montages
Pour permettre le montage des partitions, il faut retarder le lancement de Docker
```bash
clear;
systemctl list-units | grep mount | grep Media | cut -c 3-100;
```
```
mnt-Media_1.mount
mnt-Media_2.mount
mnt-Media_3.mount
mnt-Media_4.mount
mnt-Media_5.mount
```

```bash
clear;
nano /lib/systemd/system/docker.service;
systemctl daemon-reload;
systemctl restart docker.service;
systemctl status docker.service;
```

Commenter les lignes
```
#After=network-online.target docker.socket firewalld.service containerd.service time-set.target
#Wants=network-online.target containerd.service
```

Ajouter les montages
```
After=network-online.target docker.socket firewalld.service containerd.service time-set.target mnt-Media_1.mount mnt-Media_2.mount mnt-Media_3.mount mnt-Media_4.mount mnt-Media_5.mount
Wants=network-online.target containerd.service                                                 mnt-Media_1.mount mnt-Media_2.mount mnt-Media_3.mount mnt-Media_4.mount mnt-Media_5.mount
```
