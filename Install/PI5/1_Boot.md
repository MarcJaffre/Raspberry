---------------------------------------------------------------------------------------------------------------------------------------
# <p align='center'> Configuration du démarrage du Raspberry PI 5 (Bookworm) </p>

---------------------------------------------------------------------------------------------------------------------------------------
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

<br />

---------------------------------------------------------------------------------------------------------------------------------------
## II. Ma Configuration
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
#################################################
# Global #
##########
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
total_mem=4096

#################################################
# Activation Architecture x64 #
###############################
arm_64bit=1

#################################################
# Affichage #
#############
# ===============================================
display_auto_detect=1
display_default_lcd=-1
display_hdmi_rotate=-1
display_lcd_rotate=-1

# ===============================================
framebuffer_depth=16
framebuffer_ignore_alpha=1
framebuffer_swap=1

# ===============================================
hdmi_enable_4kp60=0
hdmi_force_cec_address:0=65535
hdmi_force_cec_address:1=65535

#################################################
# Audio #
#########
audio_pwm_mode=2

#################################################
# Camera #
##########
camera_auto_detect=0

#################################################
# Overclocking #
################
# ===============================================
# Activation du Mode Boost
arm_boost=1
# ===============================================
# Forcer le mode Haute-Performance constamment
force_turbo=0
# ===============================================
# Frequence horloge inîtiale
initial_turbo=0
# ===============================================
# Temp Limit (Defaut: 85°C)
temp_limit=85
# ===============================================
# Vcore (0.025V par pallier)
over_voltage=0
over_voltage_min=0
# ===============================================
# MEMORY
#over_voltage_sdram=0
#over_voltage_sdram_c=0
#over_voltage_sdram_i=0
#over_voltage_sdram_p=0
# ===============================================

#################################################
# D.O.C.P #
###########
# ===============================================
# Bus Periphérique ARM
arm_peri_high=1
# ===============================================
arm_freq=2400
core_freq=910
isp_freq=910
v3d_freq=960
hevc_freq=910
# ===============================================
arm_freq_min=1500
core_freq_min=500
gpu_freq_min=500
isp_freq_min=500
v3d_freq_min=500
hevc_freq_min=500
# ===============================================
# Defaut 0
sdram_freq=4267
sdram_freq_min=0
# ===============================================
vpred_max=8508
vpred=8508
# ===============================================
over_voltage_avs=0x162b0
# ===============================================

#################################################
# Gestions des modules #
########################
auto_initramfs=1

#################################################
# Desactivation des modules #
#############################
disable_commandline_tags=2
disable_fw_kms_setup=1
disable_l2cache=1
disable_overscan=1


[ALL]
# ===============================================
dtparam=hdmi=off
dtparam=act_led_activelow=off
dtparam=audio=off

# ===============================================
dtparam=cooling_fan=on
dtparam=fan_temp0=50000
dtparam=fan_temp0_hyst=5000
dtparam=fan_temp0_speed=75
dtparam=fan_temp1=60000
dtparam=fan_temp1_hyst=5000
dtparam=fan_temp1_speed=125
dtparam=fan_temp2=67500
dtparam=fan_temp2_hyst=5000
dtparam=fan_temp2_speed=175
dtparam=fan_temp3=75000
dtparam=fan_temp3_hyst=5000
dtparam=fan_temp3_speed=250

# ===============================================
dtparam=eee=off

# ===============================================
dtparam=eth_led0=4
dtparam=eth_led1=4
dtparam=eth_max_speed=1000

# ===============================================
dtoverlay=disable-bt-pi5
dtoverlay=disable-wifi-pi5
dtoverlay=vc4-kms-v3d-pi5,nohdmi,noaudio
dtparam=watchdog=off
# ===============================================
#dtoverlay=vc4-kms-v3d,nohdmi,noaudio
#dtoverlay=disable-bt
#dtoverlay=disable-wifi
# ===============================================
EOF
```

```bash
clear;
systemctl disable --now bluetooth;
```

<br />

---------------------------------------------------------------------------------------------------------------------------------------
