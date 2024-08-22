----------------------------------------------------------------------------------------------------------------------------------
## <p align='center'> Règle de trafic </p>
----------------------------------------------------------------------------------------------------------------------------------
### I. Informations Générales
#### A. Présentation
Pour permettre une meilleur gestion du trafic réseau et n'autoriser que les flux à passer le pare-feu, il est nécessaire de faire une politique de sécurité.

#### B. Pare-Feu
Pour définir une polique globale de sécurité, il est nécessaire de modifier les zones.

L'interface WIFI est dans la zone du Pare-Feu `WIFI`.

![image](https://github.com/user-attachments/assets/e0ea28e8-e245-4e0a-9e58-c60aec6b8066)

La politique Globale: 

![image](https://github.com/user-attachments/assets/6e9b7929-d1ce-43ed-806c-4d7f7f7f5cc1)


<br />
<br />

----------------------------------------------------------------------------------------------------------------------------------
## II. Pare-feu
En ayant aucune règle de Pare-feu, aucun flux peux entrée et sortir de la zone WIFI.

Les règles suivantes permets d'avoir le DHCP, DNS et le surf fonctionnelles.

### A. DHCP
##### 1. Présentation
Le DHCP utilise des ports différents pour communiquer, d'où la nécessiter de réaliser 2 règles.

##### 2. DHCPv4
La requête transmis par le client (Zone: WIFI) sur le port `67/UDP` à comme destinataire finale le routeur pour obtenir une IPv4.

![image](https://github.com/user-attachments/assets/7c76f1c3-c926-4171-8cdc-bf05486f5c22)


##### 3. DHCPv4
La requête transmis par le routeur sur le port `68/UDP` à comme destinataire finale le client (Zone: WIFI) .

![image](https://github.com/user-attachments/assets/12be971e-96f0-4ef1-830a-420adf900f95)

<br />

### B. DNS
La requête transmis par le client (Zone: WIFI) sur le port `53` (TCP/UDP) à comme destinataire finale le routeur.

![image](https://github.com/user-attachments/assets/ab5335b1-3527-4bb0-ac61-67ba3ff8a9a9)

<br />

### C. HTTP
La requête transmis par le client sur le port `80` (TCP) à comme intermédiaire le routeur.

![image](https://github.com/user-attachments/assets/cdd9d874-7bfe-4d1e-958e-81d7041205b0)


<br />

### D. HTTPS
La requête transmis par le client sur le port `443` (TCP) à comme intermédiaire le routeur.

![image](https://github.com/user-attachments/assets/7d03fcbf-27f6-47b3-adf4-9e30ce37ad3c)


----------------------------------------------------------------------------------------------------------------------------------
