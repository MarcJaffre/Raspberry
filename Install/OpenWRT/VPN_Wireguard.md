----------------------------------------------------------------------------------------------------------------------------------------------------------------
## <p align='center'> Déploiement d'un serveur VPN </p>

----------------------------------------------------------------------------------------------------------------------------------------------------------------
## I. Installation du serveur
### A. Installation des paquets
#### 1. Software
Ouvrir le menu `System` puis `Software`.
#### 2. Paquet Wireguard
Cliquer sur le bouton `Update Lists` pour mettre à jour la liste des paquets.

Remplisser le champ `Filter` par le mot `luci-proto-wireguard`.

Installer le paquet en cliquant sur `Installed` puis sur `Install`.

#### 2. Paquet qrencode
Remplisser le champ `Filter` par le mot `qrencode`.

Installer le paquet en cliquant sur `Installed` puis sur `Install`.

Ce paquet permettra à Wireguard de générer un QRCode qui sera utiliser par les clients.

<br />

### B. Création de l'interface Wireguard
Ouvrir le menu `Network` puis `Interfaces`. Cliquer sur le bouton `Add new interface...`, réaliser la configuration (voir ci dessous) puîs cliquer sur `Save` et `Save & Apply`.

```
Name     : Wireguard
Protocol : WireGuard VPN
```

```
[General Settings]
 - Generate new key pair : Permet de générer une pair de clé pour le serveur
 - Listen Port           : 51820
 - IP Addresses          : Définir une adresse réseau en /32 et cliquer sur le +. (Exemple: 192.168.50.1/32)
                           - /32 signifie serveur à Client uniquement. (Bloque Client VPN à Client VPN)
[Firewall settings]
 - Assign firewall-zone  : Indiquer un nom en minuscule pour créer une zone dans le pare-feu (Exemple: vpn) 
```


### C. Gestions des clîents
#### 1. Information
L'interface Wireguard est en `192.168.50.1/32`.

#### 2. Ajouter un client
Editer l'interface `wireguard` puis aller dans `Peer` et cliquer sur `Add peer` et remplissez les champs. (**Ne pas faire SAVE**)
```
- Description            : Peer1
- Generate new key pair  : Permet de générer une paire de clé.
- Generate preshared key : Permet de générer une paire de clé de pre-authentification. (optionnel)
- Allowed IPs            : Indiquer l'adresse IP du client au sein du réseau VPN qui sera autorisé à se connecter et ajouter /32.
                           - La première IP disponible dans le réseau VPN est `192.168.50.2/32`
                           - Si mon client s'authentifie sur une autre IP au sein du VPN sa le refusera.
- Route Allowed IPs      : Cocher
- Endpoint Host          : Adresse public du VPN. (WAN IP ou DDNS)
- Endpoint Port          : Port du client pour se connecter au VPN
```
#### 3. Générer la configuration
Cliquer sur `Generate configuration`.

```
Connection endpoint : Sélectionner l'adresse WAN

Allowed IPs         : Adresse réseaux autorisé à accéder depuis le client. (/!\ Le  pare-feu de OpenWRT devra le permettre /!\)
 - 0.0.0.0/0        : signifie que le client est full tunnel en IPv4. (Tout le trafic passe par le VPN et l'ip Publique du client est le VPN)
 - ::/0             : signifie que le client est full tunnel en IPv4

[Optionnel]
 - 192.168.1.0/24   : Permet au client d'accéder au réseau 192.168.1.0/24  (/!\ Le  pare-feu de OpenWRT devra le permettre /!\)
 - 192.168.0.0/24   : Permet au client d'accéder au réseau 192.168.0.0/24  (/!\ Le  pare-feu de OpenWRT devra le permettre /!\)


DNS Servers         : Serveur DNS que le client utilise (Si c'est un DNS connecté au sein du routeur, penser au parê-feu)
Addresses           : 192.168.50.2/32
```

### D. Firewall
Ouvrir le menu `Network` puis `Firewall`. 
#### 1. General Settings
![image](https://github.com/user-attachments/assets/14f42330-e955-4d8d-8510-635e9b17f216)

#### 2. Port Forwards
Le client transmet se connecte sur le port 5810/UDP depuis le WAN du routeur et le routeur transmert à l'interface VPN
```
Name                : Wireguard
Protocol            : UDP
Source zone         : WAN
External port       : 51820
Destination zone    : VPN
Internal IP address : 192.168.50.1
Internal port       : 51820
```


