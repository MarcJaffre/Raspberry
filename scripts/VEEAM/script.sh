#!/usr/bin/bash

##########################################################################################
# Contenu du Menu #
####################
func_MENU()          {
echo "################################################"
echo "Menu 0: "
echo "Menu 1: "
echo "Menu 2: "
echo "Menu 3: "
echo "Menu 4: "
echo "Menu 5: "
echo "Menu 6: "
echo "Menu 7: "
echo "Menu 8: "
echo "Menu 9: "
echo "Menu Q: Quitter le menu"
echo "################################################"
echo
read -p "Indiquer votre choix: " choix
echo
}

##########################################################################################
# Action du menu #
##################
func_CHOIX(){
case $choix in
 # ------------------------------------------------------------ #
 0)
  echo
  echo    "#-------------------------#"
  echo    "# Bienvenue sur le menu 0 #"
  read -p "#-------------------------#"
  clear;
 ;;
 # ------------------------------------------------------------ #
 1)
  echo
  echo    "#-------------------------#"
  echo    "# Bienvenue sur le menu 1 #"
  read -p "#-------------------------#"
  clear;
 ;;
 # ------------------------------------------------------------ #
 2)
  echo
  echo    "#-------------------------#"
  echo    "# Bienvenue sur le menu 2 #"
  read -p "#-------------------------#"
  clear;
 ;;
 # ------------------------------------------------------------ #
 3)
  echo
  echo    "#-------------------------#"
  echo    "# Bienvenue sur le menu 3 #"
  read -p "#-------------------------#"
  clear;
 ;;
 # ------------------------------------------------------------ #
 4)
  echo
  echo    "#-------------------------#"
  echo    "# Bienvenue sur le menu 4 #"
  read -p "#-------------------------#"
  clear;
 ;;
 # ------------------------------------------------------------ #
 5)
  echo
  echo    "#-------------------------#"
  echo    "# Bienvenue sur le menu 5 #"
  read -p "#-------------------------#"
  clear;
 ;;
 # ------------------------------------------------------------ #
 6)
  echo
  echo    "#-------------------------#"
  echo    "# Bienvenue sur le menu 6 #"
  read -p "#-------------------------#"
  clear;
 ;;
 # ------------------------------------------------------------ #
 7)
  echo
  echo    "#-------------------------#"
  echo    "# Bienvenue sur le menu 7 #"
  read -p "#-------------------------#"
  clear;
 ;;
 # ------------------------------------------------------------ #
 8)
  echo
  echo    "#-------------------------#"
  echo    "# Bienvenue sur le menu 8 #"
  read -p "#-------------------------#"
  clear;
 ;;
 # ------------------------------------------------------------ #
 9)
  echo
  echo    "#-------------------------#"
  echo    "# Bienvenue sur le menu 9 #"
  read -p "#-------------------------#"
  clear;
 ;;
 # ------------------------------------------------------------ #
 q|Q)
  clear;
  exit;
 ;;
 # ------------------------------------------------------------ #
 *)
  echo
  echo    "#--------------------------------------------------#"
  echo    "# Merci d'indiquer un choix parmis ceux disponible #"
  read -p "#--------------------------------------------------#"
  clear;
 ;;
 # ------------------------------------------------------------ #
 esac
}


##########################################################################################
# Nettoyage de la console #
###########################
clear;

##########################################################################################
# Récupération de l'ID en cours #
#################################
ID=$(id -u)

##########################################################################################
# Vérification Root #
#####################
if [[ $ID = 0 ]];
 then
  MENU=0;
 else
  echo "Veuiller lancer le script depuis root"
  MENU=1;
fi

##########################################################################################
# Boucle Infinie #
##################
# Si le compte est root ($MENU) alors lancer la fonction.
while [ $MENU = 0 ];
 do
  func_MENU;
  func_CHOIX;
 done
