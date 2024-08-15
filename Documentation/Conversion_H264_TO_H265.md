------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## <p align='center'> Convertir film h264 en h265 depuis un raspberry </p>

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Pour convertir des vidéos de H.264 à H.265 sur un Raspberry Pi 5, vous pouvez utiliser un outil comme `FFmpeg`, qui est un puissant logiciel de traitement vidéo. Voici les étapes à
suivre :

### Étape 1 : Installer FFmpeg
1. **Ouvrez un terminal sur votre Raspberry Pi.**

2. **Mettez à jour votre système :**
   ```bash
   sudo apt update
   sudo apt upgrade
   ```

3. **Installez FFmpeg :**
   ```bash
   sudo apt install ffmpeg
   ```

### Étape 2 : Convertir une vidéo

1. **Naviguez vers le dossier contenant votre vidéo :**
   ```bash
   cd /chemin/vers/votre/vidéo
   ```

2. **Utilisez la commande FFmpeg pour convertir la vidéo :**
   ```bash
   ffmpeg -i input_video.mp4 -c:v libx265 -preset medium -crf 28 output_video.mp4
   ```
   - Remplacez `input_video.mp4` par le nom de votre fichier vidéo source.
   - `-c:v libx265` spécifie que vous voulez utiliser le codec H.265.
   - `-preset medium` détermine la vitesse de compression (vous pouvez utiliser `slow`, `medium`, ou `fast` selon vos besoins).
   - `-crf 28` est le facteur de qualité (0 est la meilleure qualité, 51 est la pire ; 28 est un bon compromis).


```bash
clear;
INPUT="/mnt/media/monfilm.mkv"
OUTPUT="/mnt/media/monfilm_H265.mkv"
ffmpeg -i "$INPUT";
ffmpeg -i "$INPUT" -c:v libx265 -preset medium -crf 28 "$OUTPUT";
``` 





### Étape 3 : Vérifier la conversion

Après la conversion, vous pouvez vérifier que le fichier a bien été converti en H.265 en utilisant la commande suivante :

```bash
ffmpeg -i output_video.mp4
```

Cela affichera des informations sur le fichier, y compris le codec vidéo utilisé.

### Remarques

- La conversion peut prendre du temps, en fonction de la taille de la vidéo et des performances de votre Raspberry Pi.
- Assurez-vous d'avoir suffisamment d'espace de stockage pour la vidéo convertie.
- Si vous avez des vidéos en haute résolution, le Raspberry Pi peut rencontrer des limitations de performance. Dans ce cas, envisagez de réduire la résolution ou d'utiliser un ordinateur
plus puissant pour la conversion.

Voilà, vous devriez maintenant être en mesure de convertir des vidéos de H.264 à H.265 sur votre Raspberry Pi 5 !
