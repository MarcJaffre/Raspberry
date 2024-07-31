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
}

##########################################################################################
# Action du menu #
##################
func_CHOIX(){
case $choix in
 # --------------- #
 0)
  clear;
  echo "Menu 0";
 ;;
 # --------------- #
 1)
  clear;
  echo "Menu 1";
 ;;
 # --------------- #
 2)
  clear;
  echo "Menu 2";
 ;;
 # --------------- #
 3)
  clear;
  echo "Menu 3";
 ;;
 # --------------- #
 4)
  clear;
  echo "Menu 4";
 ;;
 # --------------- #
 5)
  clear;
  echo "Menu 5";
 ;;
 # --------------- #
 6)
  clear;
  echo "Menu 6";
 ;;
 # --------------- #
 7)
  clear;
  echo "Menu 7";
 ;;
 # --------------- #
 8)
  clear;
  echo "Menu 8";
 ;;
 # --------------- #
 9)
  clear;
  echo "Menu 9";
 ;;
 # --------------- #
 0)
  clear;
  echo "Menu 0";
 ;;
 # --------------- #
 q|Q)
  clear;
  exit;
 ;;
 # --------------- #
 *)
  clear;
  echo "Merci d'indiquer un choix parmis ceux disponible."
 ;;
 # --------------- #
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
