----------------------------------------------------------------------------------------------------------------------------------------
<p align='center'> Déplacer les Data de Docker </p>

----------------------------------------------------------------------------------------------------------------------------------------
## I. Mise en maintenance de Docker
Les données seront stockés dans `/Data/docker`

### A. Arrêt des conteneurs actifs
```bash
docker stop $(docker ps -a -q);
```
### B. Désactivation des services Docker
```bash
systemctl disable --now docker.socket docker.service;
```

### C. Synchronisation du dossier Docker 
```bash
rsync -avp --progress /var/lib/docker/ /Data
```

### D. Configuration de Docker
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
docker start $(docker ps -a -q)
docker ps -a
```
