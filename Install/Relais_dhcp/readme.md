sudo apt-get install isc-dhcp-relay --fix-missing

dpkg-reconfigure isc-dhcp-relay

sudo nano /etc/sysctl.conf
net.ipv4.ip_forward=1
sudo sysctl -p
