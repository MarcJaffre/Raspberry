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
```
