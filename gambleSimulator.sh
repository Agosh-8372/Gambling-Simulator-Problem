#!/bin/bash -x
STAKE_AMOUNT=100;
BET_AMOUNT=1;
PY_LOST=0;
PY_WON=1;
echo "Press 1 to place the bet"
 read userValue
  while [[ $userValue == "1" ]]
  do
       random=$((RANDOM%2))
   if [[ $random -eq 0 ]]
   then
        echo "you lost $"$BET_AMOUNT
   else
        echo "you won $"$BET_AMOUNT
   fi
 echo "To Continue press 1"
 read userValue
 done
