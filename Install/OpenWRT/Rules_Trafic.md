--------------------------------------------------------------------------------------------------------------
## <p align='center'> Règle de trafic </p>
--------------------------------------------------------------------------------------------------------------
### A. Présentation
La configuration suivante permet unê amélioration de la sécurité.

#### B. Règle de Pare-feu
> Zone WIFI : Blocage (Entrée, Sortie et Inter^-Zone)
>
> Zone WAN : Sortie autorisé uniquement

![image](https://github.com/user-attachments/assets/67b67988-40e9-4a27-9db7-c609c9bae739)

<br />

#### C. Autorîser les protocoles
##### 1a. DHCPv4 (Entrant)
Le client qui est dans la zone WIFI utilise le port `67/UDP` pour demander une adresse IP.

![image](https://github.com/user-attachments/assets/7c76f1c3-c926-4171-8cdc-bf05486f5c22)

##### 1b. DHCPv4 (Sortant)
Le serveur utilise le port `68/UDP` pour répondre à la demande d'adresse IP qui est dans la zone WIFI.

![image](https://github.com/user-attachments/assets/12be971e-96f0-4ef1-830a-420adf900f95)

##### 2. DNS
La requete DNS est transmise par le client qui est dans la zone WIFI vers le routeur. Le routeur fera la suite.
