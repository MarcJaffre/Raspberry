cat > /boot/firmware/config.txt << EOF
######################################################################
# Fonctionnalites #
###################
audio_pwm_mode=2
auto_initramfs=1
camera_auto_detect=0
disable_splash=1
display_auto_detect=0




######################################################################
# D.O.C.P #
###########
# vcgencmd get_config 
arm_boost=0
force_turbo=0
initial_turbo=0
#
arm_freq=2400
arm_freq_min=1500
#
core_freq=910
core_freq_min=500
#
gpu_freq=0
gpu_freq_min=500
#
v3d_freq=960
v3d_freq_min=500
#
hevc_freq=910
hevc_freq_min=500
#
# vcgencmd pmic_read_adc EXT5V_V
over_voltage=0
over_voltage_min=0
#
temp_limit=0
temp_soft_limit=0



######################################################################
# ALL #
#######

[ALL]
dtoverlay=vc4-kms-v3d-pi5,nohdmi,noaudio

# Ethernet
dtparam=eth_max_speed=1000
#dtparam=eth_led0=5
#dtparam=eth_led1=5

hdmi_enable_4kp60=0
hdmi=0
pcie=0
total_mem=4096
watchdog=on

######################################################################
# PI5 #
#######
[pi5]
dtoverlay=disable-bt-pi5
dtoverlay=disable-wifi-pi5


######################################################################
# Fan - LEVEL 0 #
#################
# Seuil de demrrage : 60°C
dtparam=fan_temp0=60000
#
# Seuil arret (fan_temp0 - fan_temp0_hyst)
dtparam=fan_temp0_hyst=5000
#
# Vitesse du FAN (0-255) : 25%
dtparam=fan_temp0_speed=85
#
######################################################################
# Fan - LEVEL 1 #
#################
#
# Seuil de demrrage : 65°C
dtparam=fan_temp1=65000
#
# Seuil arret (fan_temp0 - fan_temp0_hyst)
dtparam=fan_temp1_hyst=5000
#
# Vitesse du FAN (0-255) : 50%
dtparam=fan_temp1_speed=128
#
######################################################################
# Fan - LEVEL 2 #
#################
#
# Seuil de demrrage : 70°C
dtparam=fan_temp2=70000
#
# Seuil arret (fan_temp0 - fan_temp0_hyst)
dtparam=fan_temp2_hyst=5000
#
# Vitesse du FAN (0-255) : 75%
dtparam=fan_temp2_speed=192
#
######################################################################
# Fan - LEVEL 3 #
#################
#
# Seuil de demrrage : 75 °C
dtparam=fan_temp3=75000
#
# Seuil arret (fan_temp0 - fan_temp0_hyst)
dtparam=fan_temp3_hyst=5000
# Vitesse du FAN (0-255) : 100%
dtparam=fan_temp3_speed=255
#
######################################################################
EOF
