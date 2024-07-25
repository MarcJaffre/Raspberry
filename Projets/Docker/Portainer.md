```bash
clear;
echo "################
version: '3.9' #
services:      #
################
#
 Portainer:
  image: 'portainer/portainer-ee'
  container_name: 'Portainer'
  network_mode: 'bridge'
  restart: 'always'
  hostname: 'Portainer'
  volumes:
   - '/var/run/docker.sock:/var/run/docker.sock'
   - '/etc/localtime:/etc/localtime:ro'
   - 'Data:/data'
  ports:
   - '8000:8000'
   - '9000:9000' # Webui HTTP
   - '9443:9443' # Webui HTTPS
  labels:
   Cacher: 'Oui'
############################################################################################
volumes:
 Data:
  external: false
############################################################################################" > portainer.yml;
```
