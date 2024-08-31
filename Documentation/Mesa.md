Pour activer l'accélération graphique sur un Raspberry Pi 5 (ou tout autre modèle de Raspberry Pi) sous un environnement graphique, vous devez installer le paquet `mesa-utils`. Ce paquet
contient des outils qui vous permettent de vérifier et de tester l'accélération graphique.

Voici comment vous pouvez l'installer :

1. Ouvrez un terminal.
   
3. Mettez à jour la liste des paquets :
```bash
clear;
apt update;
```

3. Installez `mesa-utils` :
```bash
clear;
sudo apt install mesa-utils;
```


Après l'installation, vous pouvez vérifier si l'accélération graphique fonctionne correctement en exécutant la commande suivante :
```bash
clear;
glxinfo | grep "OpenGL renderer"
```

Cela devrait vous donner des informations sur le rendu OpenGL et vous indiquer si l'accélération graphique est activée.

Assurez-vous également que vous utilisez un environnement de bureau compatible avec l'accélération graphique, comme Raspberry Pi OS avec l'interface graphique.
