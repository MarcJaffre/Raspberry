----------------------------------------------------------------------------------------------------------------------------------------
# <p align='center'> Déplacer les Data de Docker </p>

----------------------------------------------------------------------------------------------------------------------------------------
## I. Mise en maintenance de Docker
### A. Présentation
Les données stockées par Docker sont stocker das `/var/lib/docker` et on va les déplacer dans `/Data/docker`.

### B. Arrêt des conteneurs actifs
```bash
docker stop $(docker ps -a -q);
```

### C. Désactivation des services Docker
```bash
systemctl disable --now docker.socket docker.service;
```

### D. Synchronisation du dossier Docker 
```bash
rsync -ap --progress /var/lib/docker/ /Data
```

### E. Configuration de Docker
```bash
cat > /etc/docker/daemon.json << EOF
{
  "data-root": "/Data/docker"
}
EOF
```

<br />

----------------------------------------------------------------------------------------------------------------------------------------
## II. Mise en service de Docker
### A. Démarrage de Docker
```bash
systemctl restart docker.socket;
systemctl restart docker.service;
```

### B. Activation des services Docker 
```bash
systemctl enable --now docker.socket docker.service;
```

### C. Vérification du fonctionnement
```bash
docker info -f '{{ .DockerRootDir}}'
```

### D. Lancer les conteneurs inactifs
```bash
docker start $(docker ps -a -q)
docker ps -a
```


<br />

----------------------------------------------------------------------------------------------------------------------------------------
## III. Purge des anciennes données
```bash
clear;
rm -r /var/lib/docker/*;
```

<br />
<br />


----------------------------------------------------------------------------------------------------------------------------------------
## IV. Retour en arrière
### A. Arrêt des conteneurs actifs
```bash
docker stop $(docker ps -a -q);
```

### B. Arrêt de Docker
```bash
systemctl stop docker.socket;
systemctl stop docker.service;
```

### C. Synchronisation du dossier Docker 
```bash
rsync -ap --progress /Data/ /var/lib/docker
```

### E. Configuration de Docker
```bash
cat > /etc/docker/daemon.json << EOF
{
  "data-root": "/var/lib/docker"
}
EOF
```

### F. Démarrage de Docker
```bash
systemctl start docker.socket;
systemctl start docker.service;
```

### G. Vérification du fonctionnement
```bash
docker info -f '{{ .DockerRootDir}}'
```

### H. Lancer les conteneurs inactifs
```bash
docker start $(docker ps -a -q)
docker ps -a
```

