----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## <p align='center'> Indiquer à Docker d'attendre le montage des partitions </p>

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## I. Présentation
Le service docker se lance avant le montage et si les conteneurs utilisent les montages, les dossiers dans les conteneurs seront vides.

Pour éviter celà, on indique au système d'attendre les services de montages soit OK pour démarrer docker.


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## II. Mise en service
### A. Liste les montages
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

### B. Editer le service
```bash
clear;
nano /lib/systemd/system/docker.service;
```

### C. Ajouter les Units Mounts
Ajouter à la fin des lignes `After`et `Wants` la listes des Unités de montages (.mount) qu'on à lister avant de manière consécutif avec un espace entre chaque ligne.
```
After=network-online.target docker.socket firewalld.service containerd.service time-set.target mnt-Media_1.mount mnt-Media_2.mount mnt-Media_3.mount mnt-Media_4.mount mnt-Media_5.mount
Wants=network-online.target containerd.service                                                 mnt-Media_1.mount mnt-Media_2.mount mnt-Media_3.mount mnt-Media_4.mount mnt-Media_5.mount
```

### D. Mise à jour SystemD
```bash
clear;
systemctl daemon-reload;
```

### E. Relance du service
```bash
clear;
systemctl restart docker.service;
```

### F. Vérification
Le service docker ne sera pas démarrer tant que les mounts seront pas OK.
```bash
clear;
systemctl status docker.service;
```


