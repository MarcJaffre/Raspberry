
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
over_voltage=5
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
# Fan PWM ...
dtparam=cooling_fan=on

# 20% ...
dtparam=fan_temp0=55000
dtparam=fan_temp0_hyst=2500
dtparam=fan_temp0_speed=50

# 30% ...
dtparam=fan_temp1=60000
dtparam=fan_temp1_hyst=2500
dtparam=fan_temp1_speed=75

# 40% ...
dtparam=fan_temp2=62500
dtparam=fan_temp2_hyst=2500
dtparam=fan_temp2_speed=100

# 50% ...
dtparam=fan_temp3=65000
dtparam=fan_temp3_hyst=2500
dtparam=fan_temp3_speed=125

# 60% ...
dtparam=fan_temp4=67500
dtparam=fan_temp4_hyst=2500
dtparam=fan_temp4_speed=150

# 70% ...
dtparam=fan_temp5=70000
dtparam=fan_temp5_hyst=2500
dtparam=fan_temp5_speed=175

# 80% ...
dtparam=fan_temp6=72500
dtparam=fan_temp6_hyst=2500
dtparam=fan_temp6_speed=200

# 100% ...
dtparam=fan_temp7=75000
dtparam=fan_temp7_hyst=2500
dtparam=fan_temp7_speed=250
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
