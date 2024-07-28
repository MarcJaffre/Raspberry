------------------------------------------------------------------------------------------------------------------------------------------------------------------
## <p align='center'> Installation de Cockpit </p>

------------------------------------------------------------------------------------------------------------------------------------------------------------------
### I. Présentation
```bash
Cockpit est un outil Web pour piloter et administrer une machine sous Linux .
```

------------------------------------------------------------------------------------------------------------------------------------------------------------------
### I. Installation de Cockpit
#### X. Installation de Cockpit
```bash
clear;
apt install -y cockpit 1>/dev/null;
```

#### X. Suppléments
```bash
clear;
apt install -y realmd nfs-common tuned 1>/dev/null;
```

#### X. Installation de Cockpit DOC
```bash
clear;
apt install -y cockpit-doc 1>/dev/null;
```

#### X. Installation de Cockpit Pont
```bash
clear;
apt install -y cockpit-bridge 1>/dev/null;
```

#### X. Installation de Cockpit Machines
```bash
clear;
apt install -y cockpit-machines 1>/dev/null;
```

#### X. Installation de Cockpit NetworkManager
```bash
clear;
apt install -y cockpit-networkmanager 1>/dev/null;
```

#### X. Installation de Cockpit PackageKit
```bash
clear;
apt install -y cockpit-packagekit 1>/dev/null;
```

#### X. Installation de Cockpit PCP (Metrics)
```bash
clear;
apt install -y cockpit-pcp 1>/dev/null;
```

#### X. Installation de Cockpit PodMan
```bash
clear;
apt install -y cockpit-podman 1>/dev/null;
```


#### X. Installation de Cockpit SOS Report
```bash
clear;
apt install -y cockpit-sosreport 1>/dev/null;
```


#### X. Installation de Cockpit Storaged
```bash
clear;
apt install -y cockpit-storaged udisks2-lvm2 1>/dev/null;
```


#### X. Installation de Cockpit System
```bash
clear;
apt install -y cockpit-system 1>/dev/null;
```


#### X. Installation de Cockpit Tests
```bash
clear;
apt install -y cockpit-tests 1>/dev/null;
```


#### X. Installation de Cockpit WS
```bash
clear;
apt install -y cockpit-ws 1>/dev/null;
```


#### X. Installation de Cockpit Navigateur
```bash
clear;
git clone https://github.com/45Drives/cockpit-navigator.git /tmp/cockpit-navigator 2>/dev/null; cd /tmp/cockpit-navigator 1>/dev/null; make install;
```

#### X. Installation de Cockpit File Sharing
```bash
clear;
wget https://github.com/45Drives/cockpit-file-sharing/releases/download/v3.2.9/cockpit-file-sharing_3.2.9-2focal_all.deb -O /tmp/cockpit-file-sharing.deb 2>/dev/null;
apt install -y /tmp/cockpit-file-sharing.deb 1>/dev/null;
```

#### X. Installation de Cockpit Identities
```bash
clear;
wget https://github.com/45Drives/cockpit-identities/releases/download/v0.1.12/cockpit-identities_0.1.12-1focal_all.deb -O /tmp/cockpit-identities.deb 2>/dev/null;
apt install -y /tmp/cockpit-identities.deb 1>/dev/null;
```

#### X. Relance du service
```bash
clear;
systemctl restart cockpit;
```

#### X. Panel d'administration
```
HTTPS://X.X.X.X:9090
```
