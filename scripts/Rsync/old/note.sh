########################################################################################################################################################################################





##################################################################################################################################################################################
# Verification #
################
# Si variable est vide alors un message est envoyé
#if [ -z $HOST_SERVEUR     ];then echo "La Valeur Serveur NULL"; fi
#if [ -z $HOST_DOMAINE     ];then echo "La Valeur DOMAINE NULL"; fi
#if [ -z $HOST_PASSWORD    ];then echo "La Valeur PASSWORD NULL"; fi
#if [ -z $HOST_USERNAME    ];then echo "La Valeur USERNAME NULL"; fi
#if [ -z $HOST_SHARE       ];then echo "La Valeur Partage NULL"; fi
#if [ -z $HOST_MOUNTPOINT  ];then echo "La Valeur Point de montage NULL"; fi
#if [ -z $HOST_RSYNC_SIM   ];then echo "La valeur Rsync Simulation est NULL"; fi




# Si les variables sont vides alors un message est envoyé
#if [ ! -z "${HOST_SERVEUR}" ] && [ ! -z "${HOST_MOUNTPOINT}" ];echo "ERREUR"; fi

# Si le répertoire n'existe pas alors un message est envoyé
#if [ ! -d $HOST_MOUNTPOINT ];then echo  "> Le dossier de montage n'existe déjà."; fi

# Si le fichier est absent alors un message est envoyé
#if [ ! -f $HOME/rsync.txt ];then echo "Le fichier rsync.txt est absent"; fi

# Si le fichier est vide alors un message est envoyé
#if [ ! -s $HOME/rsync.txt ];then echo "Le fichier rsync.txt est vide"; fi

# Pour chaque ligne du fichier rsync, vérifier si le dossier n'existe pas et indique qu'il existe.
#for i in $(cat $HOME/rsync.txt);do if [ ! -d $i ];then echo "[KO] Le répertoire n'existe pas : $i"; fi done

# Rsync
#if [ -z $RC               ];then echo "La variable RC (rsync) est NULL"; fi
#if [ ! -z $RC ];then if [ $RC = 1 ];then echo "La valeur RC est en erreur"; fi fi


# //192.168.20.3/Media_5/TEST

# if [ ! -z $HOST_SERVEUR ] && [ ! -z $HOST_SHARE ] && [ ! -z $HOST_MOUNTPOINT ] && [ ! -z $RC ] && [ ! -z $MOUNT ]; then if [ $MOUNT == "//$HOST_SERVEUR/$HOST_SHARE" ];then
# Si les variables sont vides alors un message est envoyé
#if [ ! -z "${HOST_SERVEUR}" ] && [ ! -z "${HOST_MOUNTPOINT}" ];echo "ERREUR"; fi
# Si le répertoire n'existe pas alors un message est envoyé
#if [ ! -d $HOST_MOUNTPOINT ];then echo  "> Le dossier de montage n'existe déjà."; fi
# Si le fichier est absent alors un message est envoyé
#if [ ! -f $HOME/rsync.txt ];then echo "Le fichier rsync.txt est absent"; fi
# Si le fichier est vide alors un message est envoyé
#if [ ! -s $HOME/rsync.txt ];then echo "Le fichier rsync.txt est vide"; fi
# Pour chaque ligne du fichier rsync, vérifier si le dossier n'existe pas et indique qu'il existe.
# for i in $(cat $HOME/rsync.txt);do if [ ! -d $i ];then echo "[KO] Le répertoire n'existe pas : $i"; fi done




########################################################################################################################################################################################
#func_MKDIR()         {
# if [ ! -d /mnt/backup ]; then
#  mkdir -p /mnt/backup 2>/dev/null;
#  echo "Le creation du dossier a ete fait."
#  echo "";
#  else
#  echo "Le dossier existe deja"
#  echo "";
# fi
#}

########################################################################################################################################################################################
 #func_UMOUNT()        {
 #if [ -d /mnt/backup ]; then
 # umount /mnt/backup;
 # echo "Le dossier a été démonté";
 # echo "";
 #fi
 #}

########################################################################################################################################################################################
func_MOUNT()         {
  mount -t cifs -o username="$HOST_USERNAME",password="$HOST_PASSWORD" //$HOST_SERVEUR/$HOST_SHARE /mnt/backup;
  echo "Le dossier a été monté";
  echo "";
}

########################################################################################################################################################################################
func_MOUNT_AD()      {
  mount -t cifs -o domain="$HOST_DOMAINE";username="$HOST_USERNAME",password="$HOST_PASSWORD" //$HOST_SERVEUR/$HOST_SHARE /mnt/backup;
}

########################################################################################################################################################################################
func_ACTION()        {
  read -p "Quel action souhaitez-vous faire ? (archivage, restauration) " HOST_ACTION
  HOST_ACTION=${HOST_ACTION:-archivage}
}


########################################################################################################################################################################################
# Note #
########
#echo "Chemin UNC     : \\\\$HOST_SERVEUR\\$HOST_SHARE   ";

