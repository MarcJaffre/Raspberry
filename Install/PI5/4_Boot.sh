cat > /boot/firmware/config.txt << EOF
######################################################################
# Fonctionnalites #
###################
# Camera
camera_auto_detect=0
#
# HDMI
display_auto_detect=0
#
# Audio Jack
audio_pwm_mode=2
#
auto_initramfs=1
#
disable_splash=1
#
#
######################################################################
# Pilote #
##########
#dtoverlay=mmc


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

# Turn off LED
dtparam=pwr_led_trigger=default-on
dtparam=pwr_led_activelow=off
dtparam=act_led_trigger=none
dtparam=act_led_activelow=off

# Ethernet
dtparam=eth_max_speed=1000
dtparam=eth_led0=5
dtparam=eth_led1=5

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
EOF
reboot;





# https://forums.raspberrypi.com/viewtopic.php?t=332915
