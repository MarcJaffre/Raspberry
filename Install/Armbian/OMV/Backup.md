------------------------------------------------------------------------------------------------------------------------
## <p align='center'> Sauvegarder ou restaurer OMV </p>

------------------------------------------------------------------------------------------------------------------------
### I. Sauvegarde
#### Planification
```bash
clear;
/usr/bin/cp /etc/openmediavault/config.xml /srv/dev-disk-by-uuid-80667AAF667AA596/Backup/OMV/config_$(date +"%d-%m-%y-%HH%M").xml
```

<br />

------------------------------------------------------------------------------------------------------------------------
#### II. Restauration
```bash
clear;
cp /srv/dev-disk-by-uuid-80667AAF667AA596/Backup/OMV/config_19-12-24-00H05.xml /etc/openmediavault/config.xml
omv-salt stage run all
```
