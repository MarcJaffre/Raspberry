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
  echo "Menu 0";
  read "Revenir au menu de sélection";
  clear;
 ;;
 # --------------- #
 1)
  echo "Menu 1";
  read "Revenir au menu de sélection";
  clear;
 ;;
 # --------------- #
 2)
  echo "Menu 2";
  read "Revenir au menu de sélection";
  clear;
 ;;
 # --------------- #
 3)
  echo "Menu 3";
  read "Revenir au menu de sélection";
  clear;
 ;;
 # --------------- #
 4)
  echo "Menu 4";
  read "Revenir au menu de sélection";
  clear;
 ;;
 # --------------- #
 5)
  echo "Menu 5";
  read "Revenir au menu de sélection";
  clear;
 ;;
 # --------------- #
 6)
  echo "Menu 6";
  read "Revenir au menu de sélection";
  clear;
  clear;
 ;;
 # --------------- #
 7)
  echo "Menu 7";
  read "Revenir au menu de sélection";
  clear;
 ;;
 # --------------- #
 8)
  echo "Menu 8";
  read "Revenir au menu de sélection";
  clear;
 ;;
 # --------------- #
 9)
  echo "Menu 9";
  read "Revenir au menu de sélection";
  clear;
 ;;
 # --------------- #
 0)
  echo "Menu 0";
  read "Revenir au menu de sélection";
  clear;
 ;;
 # --------------- #
 q|Q)
  clear;
  exit;
 ;;
 # --------------- #
 *)
  echo "Merci d'indiquer un choix parmis ceux disponible."
  clear;
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
