--------------------------------------------------------------------------------------------------------------------------------------------
# <p align='center'> Gestions des modules sur Raspberry </p>
--------------------------------------------------------------------------------------------------------------------------------------------
## I. Présentation

<br />


--------------------------------------------------------------------------------------------------------------------------------------------
## II. Configuration
### A. Syntaxe de la commande dtoverlay
```
Usage:
  dtoverlay <overlay> [<param>=<val>...] Add an overlay (with parameters)
  dtoverlay -D             Dry-run (prepare overlay, but don't apply - save it as dry-run.dtbo)
  dtoverlay -r [<overlay>] Remove an overlay (by name, index or the last)
  dtoverlay -R [<overlay>] Remove from an overlay (by name, index or all)
  dtoverlay -l             List active overlays/params
  dtoverlay -a             List all overlays (marking the active)
  dtoverlay -h             Show this usage message
  dtoverlay -h <overlay>   Display help on an overlay
  dtoverlay -h <overlay> <param>..  Or its parameters where <overlay> is the name of an overlay or 'dtparam' for dtparams

Options applicable to most variants:
    -d <dir>        Specify an alternate location for the overlays (defaults to /boot/overlays or /flash/overlays)
    -p <string>     Force a compatible string for the platform
    -v              Verbose operation
```

### B. Lister les modules
Les modules avec une étoile sont ceux qui sont actif sur la machine.
```bash
clear;
dtoverlay -a;
dtoverlay -l;
```

### C. Afficher les paramètres d'un module
```bash
clear;
# dtoverlay -h <Module> 
dtoverlay -h vc4-kms-v3d
```

### D. Charger / Décharger un module (Ponctuellement)
```bash
clear;
dtoverlay vc4-kms-v3d;
dtoverlay -r vc4-kms-v3d;
```


### E. Charger un module au démarrage
```bash
clear;
nano /boot/firmware/config.txt;
```
```
dtoverlay=<NOMDUMODULE>
dtoverlay=<NOMDUMODULE>,<param>
dtoverlay=<NOMDUMODULE>,<param>[=<val>]

# Exemple:
# dtoverlay vc4-kms-v3d
# dtoverlay ads1115,cha_cfg=1
```
