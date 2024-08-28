-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# <p align='center'> Création de VLAN sur un routeur OpenWRT et Netgear </p>

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
### I. Présentation


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
### II. Switch
#### A. IP Static du Switch
Aller dans l'onglet `System` puis `Management`.

#### B. VLAN Configuration
Aller dans l'onglet `VLAN` puis `802.1Q`. Cliquer sur `Advanced` > `Vlan Configuration` et cocher la Case `Enable`.

Dans le Champ `VLAN ID`, indiquer un `numéro de vlan` (2-4094) et cliquer sur `ADD`. (Dans mon cas, j'ajoute le VLAN 2)

#### C. VLAN Membership

| VLAN ID | PORTS | TYPE | Observation |
| ------- | ----- | ---- | ----------- |
| 1       | 1     | U    | Untag VLAN  |
| 1       | 2     | U    | Untag VLAN  |
| 1       | 3     | U    | Untag VLAN  |
| 1       | 4     | U    | Untag VLAN  |
| 1       | 5     | U    | Untag VLAN  |
| 1       | 6     | U    | Untag VLAN  |
| 1       | 7     | U    | Untag VLAN  |
| 1       | 8     | U    | Untag VLAN  |

| VLAN ID | PORTS | TYPE | Observation |
| ------- | ----- | ---- | ----------- |
| 2       | 1     | U    | Untag VLAN  |
| 2       | 2     | U    | Untag VLAN  |
| 2       | 3     | U    | Untag VLAN  |
| 2       | 4     | U    | Untag VLAN  |
| 2       | 5     | U    | Untag VLAN  |
| 2       | 6     | U    | Untag VLAN  |
| 2       | 7     | -    | None        |
| 2       | 8     | T    | Trunk Mode  |


Les ports `T` sert au Trunk. (Entre équipement réseau)

Les ports `U` seront marqués dans le VLAN.

Les ports `VIDE` seront pas des ports utilisés.

#### D. PORT PVID

| Port | PVID | Observation |
| ---- | ---- | ----------- |
| 1    | 2    | VLAN 2      |
| 2    | 2    | VLAN 2      |
| 3    | 2    | VLAN 2      |
| 4    | 2    | VLAN 2      |
| 5    | 2    | VLAN 2      |
| 6    | 2    | VLAN 2      |
| 7    | 1    | VLAN 1      |
| 8    | 1    | VLAN 1      |


#### E. VLAN Configuration

| VLAN ID | Port Members    |
| ------- | --------------- |
| 1       | - - - - - - 7 8 |
| 2       | 1 2 3 4 5 6 - 8 |


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
### III. Routeur
