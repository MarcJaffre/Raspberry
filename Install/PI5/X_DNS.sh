# Libérer le port 53


mkdir -p /etc/systemd/resolved.conf.d;
echo "[Resolve]
DNS=8.8.8.8
DNSStubListener=no" > /etc/systemd/resolved.conf.d/adguardhome.conf;
mv /etc/resolv.conf /etc/resolv.conf.backup;
ln -s /run/systemd/resolve/resolv.conf /etc/resolv.conf;
systemctl restart systemd-resolved;
