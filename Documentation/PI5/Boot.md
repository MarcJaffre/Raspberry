----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# <p align='center'> Configuration du démarrage du Raspberry PI 5 (Bookworm) </p>

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## I. Présentation
### A. config.txt
Le fichier de configuration sous BookWorm se situe à l'emplacement `/boot/firmware/config.txt` .

### B. Obtenir la configuration actuellement
Tous les paramètres de configuration ne peuvent pas être récupérés à l'aide de vcgencmd.

#### 1. Afficher les valeurs non null
```bash
clear;
vcgencmd get_config int
```
#### 2. Afficher les valeurs null
```bash
clear;
vcgencmd get_config str;
```

### C. Limitation de la longueur de ligne
Il existe une limite de longueur de ligne de 98 caractères pour les entrées. 

Raspberry Pi OS ignore tous les caractères dépassant cette limite.

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## II. Config.txt
### A. Par défaut
```bash
clear;
cat > /boot/firmware/config.txt << EOF
############################################################################################################################################
# For more options and information see : http://rptl.io/configtxt
############################################################################################################################################


############################################################################################################################################
# Uncomment some or all of these to enable the optional hardware interfaces #
#############################################################################
#dtparam=i2c_arm=on
#dtparam=i2s=on
#dtparam=spi=on

############################################################################################################################################
# Enable audio (loads snd_bcm2835) #
####################################
dtparam=audio=on

############################################################################################################################################
# Additional overlays and parameters are documented #
#####################################################
# /boot/firmware/overlays/README

############################################################################################################################################
# Automatically load overlays for detected cameras #
####################################################
camera_auto_detect=1

############################################################################################################################################
# Automatically load overlays for detected DSI displays #
#########################################################
display_auto_detect=1

############################################################################################################################################
# Automatically load initramfs files, if found #
################################################
auto_initramfs=1

############################################################################################################################################
# Enable DRM VC4 V3D driver #
#############################
dtoverlay=vc4-kms-v3d
max_framebuffers=2

############################################################################################################################################
# Don't have the firmware create an initial video= setting in cmdline.txt. Use the kernel's default instead #
#############################################################################################################
disable_fw_kms_setup=1

############################################################################################################################################
# Run in 64-bit mode #
######################
arm_64bit=1

############################################################################################################################################
# Disable compensation for displays with overscan #
###################################################
disable_overscan=1

############################################################################################################################################
# Run as fast as firmware / board allows #
##########################################
arm_boost=1

############################################################################################################################################
# CM4 #
#######
[cm4]
otg_mode=1

############################################################################################################################################
# CM5 #
#######
[cm5]
dtoverlay=dwc2,dr_mode=host

############################################################################################################################################
# ALL #
#######
[all]

############################################################################################################################################
EOF
```


### B. Ma Configuration
Les modules sont dans `/boot/overlays/` et le fichier `/boot/overlays/README` permet d'aider à la configuration.


Raspberry pi 4: `vcgencmd get_config over_voltage`.

| over_voltage | Tension (V) |
|--------------|-------------|
| -6           | 0.825       |
| -5           | 0.850       |
| -4           | 0.875       |
| -3           | 0.900       |
| -2           | 0.925       |
| -1           | 0.950       |
| 0            | 1.2         |
| 1            | 1.225       |
| 2            | 1.25        |
| 3            | 1.275       |
| 4            | 1.3         |
| 5            | 1.325       |
| 6            | 1.35        |
| 7            | 1.375       |
| 8            | 1.4         |
| 9            | 1.425       |
| 10           | 1.45        |

```bash
clear;
cat > /boot/firmware/config.txt << EOF
####################################################
# Overclocking #
################
# Forcer le mode Haute-Performance constamment
#arm_boost=1
force_turbo=0

# Frequence horloge inîtiale
initial_turbo=0

# Temp Limit (Defaut: 85°C)
temp_limit=80

# Vcore (0.025V par pallier)
over_voltage=-3
over_voltage_min=-3

# MEMORY
#over_voltage_sdram=0
#over_voltage_sdram_c=0
#over_voltage_sdram_i=0
#over_voltage_sdram_p=0

####################################################
# D.O.C.P #
###########
# ================================
# Bus Periphérique ARM
arm_peri_high=1
# ================================
arm_freq=2400
core_freq=910
isp_freq=910
v3d_freq=960
hevc_freq=910
# ================================
arm_freq_min=1500
core_freq_min=500
gpu_freq_min=500
isp_freq_min=500
v3d_freq_min=500
hevc_freq_min=500
# ================================
# Defaut 0
sdram_freq=4267
sdram_freq_min=0
# ================================
vpred_max=8508
vpred=8508
# ================================
over_voltage_avs=0x162b0
#
####################################################
# Activation Architecture x64 #
###############################
arm_64bit=1
#
####################################################
# Gestions des modules #
########################
auto_initramfs=1
#
####################################################
# Gestions des modules #
########################
#
# Desactivation Bluetooth et WI-FI
dtoverlay=disable-bt-pi5
dtoverlay=disable-wifi-pi5.dtbo
#
dtoverlay=vc4-fkms-v3d
dtoverlay=vc4-kms-v3d
dtoverlay=vc4-kms-v3d-pi5



####################################################
# Desactivation des modules #
#############################
disable_commandline_tags=2
disable_fw_kms_setup=1
disable_l2cache=1
disable_overscan=1
#
####################################################
# Affichage #
#############
display_auto_detect=0
display_default_lcd=-1
display_hdmi_rotate=-1
display_lcd_rotate=-1
#
framebuffer_depth=16
framebuffer_ignore_alpha=1
framebuffer_swap=1
#
hdmi_enable_4kp60=0
hdmi_force_cec_address:0=65535
hdmi_force_cec_address:1=65535
#
####################################################
# Audio #
#########
audio_pwm_mode=2
#
####################################################
# Camera #
##########
camera_auto_detect=0
#
####################################################
avs_temp=57614
dvfs=4
enable_gic=1
enable_uart=-1
force_eeprom_read=1
force_pwm_open=1
ignore_lcd=-1
init_uart_clock=0x2dc6c00
mask_gpu_interrupt1=16418
max_framebuffers=2
pause_burst_frames=1
pciex4_reset=1
pmic_turbo_threshold=600
program_serial_random=1

# Temperature (57.614°C)
total_mem=4096
####################################################
EOF
```
