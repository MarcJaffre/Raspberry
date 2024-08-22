--------------------------------------------------------------------------------------------------------------
## <p align='center'> Règle de trafic </p>
--------------------------------------------------------------------------------------------------------------
### I. Présentation
La configuration suivante permet unê amélioration de la sécurité.

<br />
<br />

--------------------------------------------------------------------------------------------------------------
## II. Pare-feu (Global)
La Zone WIFI Bloque les flux : Entran^t Sortant et Inter-Zone

La Zone WAN : Sortie autorisé uniquement

![image](https://github.com/user-attachments/assets/67b67988-40e9-4a27-9db7-c609c9bae739)


<br />
<br />

--------------------------------------------------------------------------------------------------------------
## II. Pare-feu (Protocoles)
### A. DHCP
##### 1. Présentation
Le DHCP utilise des ports différents pour communiquer, d'où la nécessiter de réaliser 2 règles.

##### 2. DHCPv4
La requête transmis par le client sur le port `67/UDP` à comme destinataire finale le routeur pour obtenir une IPv4.

![image](https://github.com/user-attachments/assets/7c76f1c3-c926-4171-8cdc-bf05486f5c22)


##### 3. DHCPv4
La requête transmis par le routeur sur le port `68/UDP` à comme destinataire finale le client.

![image](https://github.com/user-attachments/assets/12be971e-96f0-4ef1-830a-420adf900f95)

<br />

### B. DNS
La requête transmis par le client sur le port `53` (TCP/UDP) à comme destinataire finale le routeur.
![image](https://github.com/user-attachments/assets/ab5335b1-3527-4bb0-ac61-67ba3ff8a9a9)


### C. HTTP
La requête transmis par le client sur le port `80` (TCP) à comme intermédiaire le routeur.

