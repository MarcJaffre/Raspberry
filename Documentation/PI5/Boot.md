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
`vcgencmd get_config int | sort -n`

```bash
clear;
cat > /boot/firmware/config.txt << EOF
arm_64bit=1
arm_boost=1
arm_freq=2400
arm_freq_min=1500
arm_peri_high=1
audio_pwm_mode=2
auto_initramfs=1
avs_temp=57614
camera_auto_detect=1
core_freq=910
core_freq_min=500
disable_commandline_tags=2
disable_fw_kms_setup=1
disable_l2cache=1
disable_overscan=1
display_auto_detect=1
display_default_lcd=-1
display_hdmi_rotate=-1
display_lcd_rotate=-1
dvfs=4
enable_gic=1
enable_uart=-1
force_eeprom_read=1
force_pwm_open=1
framebuffer_depth=16
framebuffer_ignore_alpha=1
framebuffer_swap=1
gpu_freq_min=500
hdmi_enable_4kp60=1
hdmi_force_cec_address:0=65535
hdmi_force_cec_address:1=65535
hevc_freq=910
hevc_freq_min=500
ignore_lcd=-1
init_uart_clock=0x2dc6c00
isp_freq=910
isp_freq_min=500
mask_gpu_interrupt1=16418
max_framebuffers=2
over_voltage_avs=0x162b0
pause_burst_frames=1
pciex4_reset=1
pmic_turbo_threshold=600
program_serial_random=1
total_mem=4096
v3d_freq=960
v3d_freq_min=500
vpred=8508
vpred_max=8508
EOF
```
