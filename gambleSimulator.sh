#!/bin/bash -x
STAKE_AMOUNT=100;
BET_AMOUNT=1;
PY_LOST=0;
PY_WON=1;
PERCENT_STAKE=$((($STAKE_AMOUNT*50)/100))

winLimit=$((PERCENT_STAKE+STAKE_AMOUNT))
loseLimit=$((STAKE_AMOUNT-PERCENT_STAKE))

echo "Press 1 to place the bet "
 read userValue
  while  (($userValue == "1" )) && (( $STAKE_AMOUNT < $winLimit )) && (( $STAKE_AMOUNT > $loseLimit))
  do
       random=$((RANDOM%2))
   if [[ $random -eq $PY_LOST ]]
   then
        echo "you lost $"$BET_AMOUNT
         STAKE_AMOUNT=$((STAKE_AMOUNT-1));
   else
        echo "you won $"$BET_AMOUNT
         STAKE_AMOUNT=$((STAKE_AMOUNT+1));
   fi
 echo -e "Toatal Amount =$STAKE_AMOUNT\nTo Continue press 1"
 read userValue
 done
echo "You pressed the wrong key Or Todays limit is reached "
