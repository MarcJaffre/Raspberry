------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## <p align='center'> Information Divers </p>

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
### I. Matériel
#### A. Raspberry 5
##### X.Lister les périphériques
```bash
clear;
v4l2-ctl --list-devices;
```

```
rpivid (platform:rpivid):
 /dev/video19
 /dev/media2
```
        
##### X. V4L2 I/O
```bash
clear;
v4l2-ctl --info --device /dev/video19;
v4l2-ctl --info --device /dev/video29;
v4l2-ctl --info --device /dev/video30;
v4l2-ctl --info --device /dev/video31;
v4l2-ctl --info --device /dev/video32;
v4l2-ctl --info --device /dev/video33;
v4l2-ctl --info --device /dev/video34;
v4l2-ctl --info --device /dev/video35;
v4l2-ctl --info --device /dev/video37;
```

##### X. pispbe
```bash
clear;
v4l2-ctl --info --device /dev/video20;
v4l2-ctl --info --device /dev/video21;
v4l2-ctl --info --device /dev/video22;
v4l2-ctl --info --device /dev/video23;
v4l2-ctl --info --device /dev/video24;
v4l2-ctl --info --device /dev/video25;
v4l2-ctl --info --device /dev/video26;
v4l2-ctl --info --device /dev/video27;
v4l2-ctl --info --device /dev/video28;

```




<br />

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
### II. Logiciels
