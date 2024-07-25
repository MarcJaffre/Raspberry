
#### Database
```yml
################
version: '3.9' #
services:      #
################
#
#####################################################################
# docker-compose -f database.yml up -d
# docker-compose -f database.yml down
#####################################################################
 MariaDB:                                                           #
  # --------------------------------------------------------------- #
  image: 'linuxserver/mariadb'                                      #
  container_name: 'mariadb'                                         #
  network_mode: 'bridge'                                            #
  restart: 'unless-stopped'                                         #
  # --------------------------------------------------------------- #
  hostname: 'mariadb'                                               #
  # --------------------------------------------------------------- #
  environment:                                                      #
   # -------------------------------------------------------------- #
   TZ: 'EUROPE/PARIS'                                               #
   # -------------------------------------------------------------- #
   PUID: '0'                                                        #
   PGID: '0'                                                        #
   # -------------------------------------------------------------- #
   MYSQL_ROOT_PASSWORD: 'root'                                      #
   MYSQL_DATABASE: 'default'                                        #
   MYSQL_USER: 'myusername'                                         #
   MYSQL_PASSWORD: 'mypassword'                                     #
   # -------------------------------------------------------------- #
  ports:                                                            #
   - '3306:3306'                                                    #
  # --------------------------------------------------------------- #
  volumes:                                                          #
   - 'Data:/config'                                                 #
  # --------------------------------------------------------------- #
  labels:                                                           #
   Cacher: 'Non'                                                    #
  # --------------------------------------------------------------- #
#####################################################################
#
#
#####################################################################
 Mysql:                                                             #
  # --------------------------------------------------------------- #
  image: 'mysql'                                                    #
  container_name: 'mysql'                                           #
  network_mode: 'bridge'                                            #
  restart: 'unless-stopped'                                         #
  # --------------------------------------------------------------- #
  hostname: 'mysql'                                                 #
  # --------------------------------------------------------------- #
  command: --default-authentication-plugin=mysql_native_password    #
  # --------------------------------------------------------------- #
  environment:                                                      #
   # -------------------------------------------------------------- #
   MYSQL_ROOT_PASSWORD: 'root'                                      #
   # -------------------------------------------------------------- #
   MYSQL_DATABASE: 'exemple'                                        #
   MYSQL_USER: 'myusername'                                         #
   MYSQL_PASSWORD: 'mypassword'                                     #
  # --------------------------------------------------------------- #
  ports:                                                            #
   - '3307:3306'                                                    #
  # --------------------------------------------------------------- #
  volumes:                                                          #
   - 'mysql:/var/lib/mysql'                                         #
  # --------------------------------------------------------------- #
  labels:                                                           #
   Cacher: 'Non'                                                    #
  # --------------------------------------------------------------- #
#####################################################################
#
#
#####################################################################
volumes:                                                            #
 # ---------------------------------------------------------------- #
 Data:                                                              #
  external: false                                                   #
 # ---------------------------------------------------------------- #
 mysql:                                                             #
  external: false                                                   #
 # ---------------------------------------------------------------- #
#####################################################################
```

#### Supervision
```yml
################
version: '3.9' #
services:      #
################
#
#####################################################################
# docker-compose -f supervision.yml up -d
# docker-compose -f supervision.yml down
#
#####################################################################
#
#
#####################################################################
 Adminer:                                                           #
  # --------------------------------------------------------------- #
  image: 'adminer'                                                  #
  container_name: 'adminer'                                         #
  network_mode: 'bridge'                                            #
  restart: 'unless-stopped'                                         #
  hostname: 'Adminer'                                               #
  # --------------------------------------------------------------- #
  external_links:                                                   #
   - 'mariadb:mariadb'                                              #
  # --------------------------------------------------------------- #
  environment:                                                      #
   ADMINER_DEFAULT_SERVER: 'mariadb'                                #
  # --------------------------------------------------------------- #
  ports:                                                            #
   - '644:8080'                                                     #
  # --------------------------------------------------------------- #
  labels:                                                           #
   Cacher: 'Non'                                                    #
  # --------------------------------------------------------------- #
#####################################################################
#
#
#####################################################################
 Dozzle:                                                            #
  # --------------------------------------------------------------- #
  image: 'amir20/dozzle'                                            #
  container_name: 'dozzle'                                          #
  network_mode: 'bridge'                                            #
  restart: 'unless-stopped'                                         #
  # --------------------------------------------------------------- #
  hostname: 'Dozzle'                                                #
  # --------------------------------------------------------------- #
  volumes:                                                          #
   - '/var/run/docker.sock:/var/run/docker.sock'                    #
  # --------------------------------------------------------------- #
  ports:                                                            #
   - '1005:8080'                                                    #
  # --------------------------------------------------------------- #
  labels:                                                           #
   Cacher: 'Non'                                                    #
#####################################################################
#
#
#####################################################################
 FileBrowser:                                                       #
  image: 'filebrowser/filebrowser'                                  #
  container_name: 'FileBrowser'                                     #
  network_mode: 'bridge'                                            #
  restart: 'unless-stopped'                                         #
  # --------------------------------------------------------------- #
  hostname: 'FileBrowser'                                           #
  # --------------------------------------------------------------- #
  ports:                                                            #
   - '1114:80'                                                      #
  # --------------------------------------------------------------- #
  volumes:                                                          #
   - 'FileBrowser:/srv'                                             #
  # --------------------------------------------------------------- #
  labels:                                                           #
   Cacher: 'Non'                                                    #
#####################################################################
#
#
#####################################################################
volumes:                                                            #
 FileBrowser:                                                       #
  external: false                                                   #
  # --------------------------------------------------------------- #
#####################################################################
```


#### Outils
```yml
################
version: '3.7' #
services:      #
################
#
###################################################################
# docker-compose -f outils.yml up -d
# docker-compose -f outils.yml down
###################################################################
#
#
###################################################################
 adguardhome:                                                     #
  # ------------------------------------------------------------- #
  image: 'adguard/adguardhome'                                    #
  container_name: 'adguardhome'                                   #
  network_mode: 'bridge'                                          #
  restart: 'unless-stopped'                                       #
  # ------------------------------------------------------------- #
  hostname: 'adguardhome'                                         #
  # ------------------------------------------------------------- #
  environment:                                                    #
   TZ: 'Europe/Paris'                                             #
  # ------------------------------------------------------------- #
  volumes:                                                        #
   - '/etc/localtime:/etc/localtime:ro'                           #
   - 'adguardhome_conf:/opt/adguardhome/conf'                     #
   - 'adguardhome_work:/opt/adguardhome/work'                     #
  # ------------------------------------------------------------- #
  ports:                                                          #
   - '3000:3000'                                                  #
   - '53:53/udp'                                                  #
   - '53:53/tcp'                                                  #
   - '3272:80'                                                    #
  # ------------------------------------------------------------- #
  labels:                                                         #
   Cacher: 'Non'                                                  #
  # ------------------------------------------------------------- #
###################################################################
#
#
###################################################################
# DATABASE: default | USER: myusername | PASS: mypassword         #
# Token: admin                                                    #
###################################################################
 bitwarden:                                                       #
  # ------------------------------------------------------------- #
  image: 'vaultwarden/server'                                     #
  container_name: 'bitwarden'                                     #
  network_mode: 'bridge'                                          #
  restart: 'unless-stopped'                                       #
  # ------------------------------------------------------------- #
  hostname: 'bitwarden'                                           #
  # ------------------------------------------------------------- #
  external_links:                                                 #
   - 'mariadb:db'                                                 #
  # ------------------------------------------------------------- #
  sysctls:                                                        #
   - net.ipv6.conf.all.disable_ipv6=1                             #
  # ------------------------------------------------------------- #
  environment:                                                    #
   # ------------------------------------------------------------ #
   TZ: 'Europe/Paris'                                             #
   PUID: '0'                                                      #
   PGID: '0'                                                      #
   # ------------------------------------------------------------ #
   # General                                                      #
   DOMAIN: 'http://localhost'                                     #
   SENDS_ALLOWED: 'true'                                          #
   HIBP_API_KEY: ''                                               #
   USER_ATTACHMENT_LIMIT: ''                                      #
   ORG_ATTACHMENT_LIMIT: ''                                       #
   USER_SEND_LIMIT: ''                                            #
   TRASH_AUTO_DELETE_DAYS: ''                                     #
   INCOMPLETE_2FA_TIME_LIMIT: '3'                                 #
   DISABLE_ICON_DOWNLOAD: 'false'                                 #
   SIGNUPS_ALLOWED: 'true'                                        #
   SIGNUPS_VERIFY: 'false'                                        #
   SIGNUPS_VERIFY_RESEND_TIME: '3600'                             #
   SIGNUPS_VERIFY_RESEND_LIMIT: '6'                               #
   SIGNUPS_DOMAINS_WHITELIST: ''                                  #
   ORG_CREATION_USERS: ''                                         #
   INVITATIONS_ALLOWED: 'true'                                    #
   EMERGENCY_ACCESS_ALLOWED: 'true'                               #
   EMAIL_CHANGE_ALLOWED: 'true'                                   #
   PASSWORD_ITERATIONS: '600000'                                  #
   PASSWORD_HINTS_ALLOWED: 'true'                                 #
   SHOW_PASSWORD_HINT: 'false'                                    #
   ADMIN_TOKEN: 'admin'                                           #
   INVITATION_ORG_NAME: 'Vaultwarden'                             #
  # ------------------------------------------------------------- #
   # Advanced                                                     #
   IP_HEADER: 'X-Real-IP'                                         #
   ICON_REDIRECT_CODE: '302'                                      #
   ICON_CACHE_TTL: '2592000'                                      #
   ICON_CACHE_NEGTTL: '259200'                                    #
   ICON_DOWNLOAD_TIMEOUT: '10'                                    #
   ICON_BLACKLIST_REGEX: ''                                       #
   ICON_BLACKLIST_NON_GLOBAL_IPS: 'true'                          #
   DISABLE_2FA_REMEMBER: 'false'                                  #
   AUTHENTICATOR_DISABLE_TIME_DRIFT: 'false'                      #
   REQUIRE_DEVICE_EMAIL: 'false'                                  #
   RELOAD_TEMPLATES: 'false'                                      #
   LOG_TIMESTAMP_FORMAT: '%Y-%m-%d %H:%M:%S.%3f'                  #
   ALLOWED_IFRAME_ANCESTORS: ''                                   #
   ADMIN_SESSION_LIFETIME: '60'                                   #
   # ------------------------------------------------------------ #
   # Yubikey                                                      #
   _ENABLE_YUBICO: 'false'                                        #
   YUBICO_CLIENT_ID: ''                                           #
   YUBICO_SECRET_KEY: ''                                          #
   YUBICO_SERVER: ''                                              #
   # ------------------------------------------------------------ #
   # Global Duo                                                   #
   _ENABLE_DUO: 'false'                                           #
   DUO_IKEY: ''                                                   #
   DUO_SKEY: ''                                                   #
   DUO_HOST: ''                                                   #
   # ------------------------------------------------------------ #
   # SMTP EMAIL                                                   #
   _ENABLE_SMTP: 'true'                                           #
   USE_SENDMAIL: 'false'                                          #
   SENDMAIL_COMMAND: ''                                           #
   SMTP_HOST: 'smtp.gmail.com'                                    #
   SMTP_SECURITY: 'starttls'                                      #
   SMTP_PORT: '587'                                               #
   SMTP_FROM: 'XXXXXXXXXXXX@gmail.com'                            #
   SMTP_FROM_NAME: 'XXXXXXXXXXXX@gmail.com'                       #
   #SMTP_FROM_NAME: '[VaultWarden] Mail de confirmation'          #
   SMTP_USERNAME: 'XXXXXXXXXXXX@gmail.com'                        #
   SMTP_PASSWORD: 'XXXXXXXXXXXXXXXX'                              #
   SMTP_AUTH_MECHANISM: 'Plain, Login, Xoauth2'                   #
   SMTP_TIMEOUT: '30'                                             #
   HELO_NAME: 'HELO'                                              #
   SMTP_EMBED_IMAGES: 'true'                                      #
   SMTP_ACCEPT_INVALID_CERTS: 'false'                             #
   SMTP_ACCEPT_INVALID_HOSTNAMES: 'false'                         #
   # ------------------------------------------------------------ #
   # EMAIL 2FA                                                    #
   _ENABLE_EMAIL_2FA: 'false'                                     #
   EMAIL_TOKEN_SIZE: '6'                                          #
   EMAIL_EXPIRATION_TIME: '900'                                   #
   EMAIL_ATTEMPTS_LIMIT: '3'                                      #
   # ------------------------------------------------------------ #
   # READ-ONLY CONFIG                                             #
   DATA_FOLDER: 'data'                                            #
   DATABASE_URL: 'mysql://myusername:mypassword@db:3306/default'  #
   ICON_CACHE_FOLDER: 'data/icon_cache'                           #
   ATTACHMENTS_FOLDER: 'data/attachments'                         #
   SENDS_FOLDER: 'data/sends'                                     #
   TMP_FOLDER: 'data/tmp'                                         #
   TEMPLATES_FOLDER: 'data/templates'                             #
   RSA_KEY_FILENAME: 'data/rsa_key'                               #
   WEB_VAULT_FOLDER: 'web-vault/'                                 #
   WEBSOCKET_ENABLED: 'false'                                     #
   WEBSOCKET_ADDRESS: '0.0.0.0'                                   #
   WEBSOCKET_PORT: '3012'                                         #
   PUSH_ENABLED: 'false'                                          #
   PUSH_RELAY_URL: 'https://push.bitwarden.com'                   #
   PUSH_IDENTITY_URL: 'https://identity.bitwarden.com'            #
   PUSH_INSTALLATION_ID: ''                                       #
   PUSH_INSTALLATION_KEY: ''                                      #
   JOB_POLL_INTERVAL_MS: '30000'                                  #
   SEND_PURGE_SCHEDULE: '0 5 * * * *'                             #
   TRASH_PURGE_SCHEDULE: '0 5 0 * * *'                            #
   INCOMPLETE_2DA_SCHEDULE: '30 * * * * *'                        #
  # ------------------------------------------------------------- #
  volumes:                                                        #
    - 'bitwarden:/data'                                           #
  # ------------------------------------------------------------- #
  ports:                                                          #
   - '7777:80'                                                    #
  # ------------------------------------------------------------- #
  labels:                                                         #
   Cacher: 'Non'                                                  #
  # ------------------------------------------------------------- #
###################################################################
#
#
###################################################################
# Email: admin@example.com | Password: changeme                   #
###################################################################
 NginxProxyManager:                                               #
  # ------------------------------------------------------------- #
  image: 'jc21/nginx-proxy-manager'                               #
  container_name: 'nginx'                                         #
  network_mode: 'bridge'                                          #
  restart: 'unless-stopped'                                       #
  # ------------------------------------------------------------- #
  hostname: 'nginxproxymanager'                                   #
  # ------------------------------------------------------------- #
  external_links:                                                 #
   - 'mariadb:db'                                                 #
  # ------------------------------------------------------------- #
  sysctls:                                                        #
   - net.ipv6.conf.all.disable_ipv6=1                             #
  # ------------------------------------------------------------- #
  environment:                                                    #
   # ------------------------------------------------------------ #
   TZ: 'EUROPE/PARIS'                                             #
   # ------------------------------------------------------------ #
   DB_MYSQL_HOST: 'db'                                            #
   DB_MYSQL_PORT: '3306'                                          #
   DB_MYSQL_NAME: 'default'                                       #
   DB_MYSQL_USER: 'myusername'                                    #
   DB_MYSQL_PASSWORD: 'mypassword'                                #
  # ------------------------------------------------------------- #
  volumes:                                                        #
   - 'nginx_config:/config'                                       #
   - 'nginx_certif:/etc/letsencrypt'                              #
   - 'nginx_data:/data'                                           #
  # ------------------------------------------------------------- #
  ports:                                                          #
   - '80:80'                                                      #
   - '81:81'                                                      #
   - '443:443'                                                    #
  # ------------------------------------------------------------- #
  labels:                                                         #
   Cacher: 'Non'                                                  #
  # ------------------------------------------------------------- #
###################################################################
#
#
###################################################################
volumes:                                                          #
 # -------------------------------------------------------------- #
 adguardhome_conf:                                                #
  external: false                                                 #
 # -------------------------------------------------------------- #
 adguardhome_work:                                                #
  external: false                                                 #
 # -------------------------------------------------------------- #
 bitwarden:                                                       #
  external: false                                                 #
 # -------------------------------------------------------------- #
 nginx_config:                                                    #
  external: false                                                 #
 # -------------------------------------------------------------- #
 nginx_certif:                                                    #
  external: false                                                 #
 # -------------------------------------------------------------- #
 nginx_data:                                                      #
  external: false                                                 #
 # -------------------------------------------------------------- #
###################################################################
```

#### Multimedias
```yml

```

#### Warez
```yml
```


```yml
```


```yml
```
