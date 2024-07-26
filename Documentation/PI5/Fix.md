------------------------------------------------------------------------------------------------------------------------------------------------------------
## <p align='center'> Blueetooth - Correctif </p>

------------------------------------------------------------------------------------------------------------------------------------------------------------
## I. Debian 12 (2023-12-11)
```
https://downloads.raspberrypi.com/raspios_lite_arm64/images/raspios_lite_arm64-2023-12-11/2023-12-11-raspios-bookworm-arm64-lite.img.xz
```
------------------------------------------------------------------------------------------------------------------------------------------------------------
## II. Bluetoothd
### A. Message d'erreur pour le problème 1
```
bluetoothd[816]: profiles/audio/vcp.c:vcp_init() D-Bus experimental not enabled
bluetoothd[816]: profiles/audio/bap.c:bap_init() D-Bus experimental not enabled
bluetoothd[816]: profiles/audio/mcp.c:mcp_init() D-Bus experimental not enabled
bluetoothd[816]: src/plugin.c:plugin_init() Failed to init vcp plugin
bluetoothd[816]: src/plugin.c:plugin_init() Failed to init mcp plugin
bluetoothd[816]: src/plugin.c:plugin_init() Failed to init bap plugin
bluetoothd[816]: profiles/sap/server.c:sap_server_register() Sap driver initialization failed.
bluetoothd[816]: sap-server: Operation not permitted (1)
bluetoothd[816]: src/adv_monitor.c:btd_adv_monitor_power_down() Unexpected NULL btd_adv_monitor_manager object upo>
```

### A. Solution au problème 1
```bash
clear;

sed -i -e "s/\#Experimental \= false/Experimental \= true/" /etc/bluetooth/main.conf;
```


### B. Message d'erreur pour le problème 2
```
bluetoothd[816]: Failed to set privacy: Rejected (0x0b)
```

### B. Solution au problème 2
```bash
clear;

echo "[Unit]
Description=Raspberry Pi bluetooth helper
Requires=hciuart.service bluetooth.service
After=hciuart.service bluetooth.service

[Service]
Type=oneshot
ExecStartPre=/bin/sleep 2
ExecStart=/usr/bin/bthelper %I
RemainAfterExit=yes" > /lib/systemd/system/bthelper@.service; systemctl daemon-reload;
```
