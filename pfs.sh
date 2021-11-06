re='^[0-9]+$'
echo -e "Pierre . Feuille . Ciseaux\n"
while true; do
  echo -n "Choisissez le nombre de tours au quel vous souhaitez jouer : "
  read -r rounds
  if ! [[ $rounds =~ $re ]] ; then
     echo "Veuillez choisir un nombre valide."
     echo -e "Réessayez.\n"
  elif [ $rounds -lt 0 ]; then
    echo "Vous devez choisir un nombre de tours supérieur ou égal à 1 !"
  else
    echo -e "$rounds tours, commençons!\n"
    break
  fi
done
re='^[pfs]+$'
currentRound=1
while [ $rounds -gt 0 ]; do
  echo "Tour: $currentRound"
  botChosen=$(shuf -i 1-3 -n 1)
  [ "$botChosen" == "1" ] && botChosen="p"
  [ "$botChosen" == "2" ] && botChosen="f"
  [ "$botChosen" == "3" ] && botChosen="s"
  echo -n "Pierre, Feuille ou Ciseaux (p/f/s): "
  read -r playerChosen
  if ! [[ "$playerChosen" =~ $re ]] || [ "${#playerChosen}" != "1" ]; then
     echo "Ce n'est pas une réponse valide!"
     echo -e "Please chose again.\n"
  else
    [ "$playerChosen" == "p" ] && playerdisplayChosen="Pierre"
    [ "$playerChosen" == "f" ] && playerdisplayChosen="Feuille"
    [ "$playerChosen" == "s" ] && playerdisplayChosen="Ciseaux"
    [ "$botChosen" == "p" ] && botdisplayChosen="Pierre"
    [ "$botChosen" == "f" ] && botdisplayChosen="Feuille"
    [ "$botChosen" == "s" ] && botdisplayChosen="Ciseaux"
    echo "Vous avez choisi : $playerdisplayChosen !"
    echo "Le bot a choisi : $botdisplayChosen !"
    echo -e "\n"
    botWin=0
    playerWin=0
    if [ "$playerChosen" == "p" ]; then
      [ "$botChosen" == "f" ] && botWin=1
      [ "$botChosen" == "s" ] && playerWin=1
    fi
    if [ "$playerChosen" == "f" ]; then
      [ "$botChosen" == "s" ] && botWin=1
      [ "$botChosen" == "p" ] && playerWin=1
    fi
    if [ "$playerChosen" == "s" ]; then
      [ "$botChosen" == "p" ] && botWin=1
      [ "$botChosen" == "f" ] && playerWin=1
    fi
    if [ "$botWin" == "0" ] && [ "$playerWin" == "0" ]; then
      echo "Egalité!"
    elif [ "$playerWin" == 1 ]; then
      echo "Vous avez gagné !"
      ((playerScore++))
    elif [ "$botWin" == 1 ]; then
      echo "Le bot a gagné :("
      ((botScore++))
    fi
    echo -e "\n"
    ((rounds--))
    ((currentRound++))
  fi
done
echo "Statistique de la partie"
echo "Vous avez $playerScore point(s)"
echo "Le bot a $botScore point(s)"
echo -e "\n"
if [ $botScore -gt $playerScore ]; then
  echo "Vous avez perdu !"
elif [ $playerScore -gt $botScore ]; then
  echo "Vous avez gagné !"
elif [ $botScore -eq $playerScore ]; then
  echo "Egalité !"
fi
echo -e "\n"
exit