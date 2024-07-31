#!/usr/bin/bash

###############################################################################################################################
# Nettoyage de la console #
###########################
clear;

###############################################################################################################################
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


###############################################################################################################################
# Action du menu #
##################
func_CHOIX(){
case $choix in
 # --------------- #
 0)
  clear;
 ;;
 # --------------- #
 1)
  clear;
  func_VM;
 ;;
 # --------------- #
 2)
  clear;
 ;;
 # --------------- #
 3)
  clear;
 ;;
 # --------------- #
 4)
  clear;
 ;;
 # --------------- #
 5)
  clear;
 ;;
 # --------------- #
 6)
  clear;
 ;;
 # --------------- #
 7)
  clear;
 ;;
 # --------------- #
 8)
  clear;
 ;;
 # --------------- #
 9)
  clear;
 ;;
 # --------------- #
 0)
  clear;
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

###############################################################################################################################
