INITIAL=100;
STAKE_AMOUNT=100;
BET_AMOUNT=1;
PY_LOST=0;
PERCENT_STAKE=$((($STAKE_AMOUNT*50)/100))
WIN_LIMIT=$((PERCENT_STAKE+STAKE_AMOUNT))
LOSE_LIMIT=$((STAKE_AMOUNT-PERCENT_STAKE))

day=1
num_of_Days=30;

declare -a arr_Win
declare -a arr_Lose

function day_WinLoose()
{
	dayWin=$1
	dayLose=$2
	dayCount=$3
		if [ $dayWin -gt $dayLose ]
		then
			echo "you win today $"$((dayWin-dayLose))
			 arr_Win[(($dayCount))]=$((dayWin-dayLose))
		else
			echo "you lost today $"$((dayLose-dayWin))
			arr_Lose[(($dayCount))]=$((dayLose-dayWin))
		fi
}

for((i=$day;i<=$num_of_Days;i++))
do
	dayWinCount=0;
   dayLostCount=0;
	echo "Day $day-Press 1 to place bet "
 	read userValue
  		while (( $userValue == "1" )) && (( $STAKE_AMOUNT < $WIN_LIMIT )) && (( $STAKE_AMOUNT > $LOSE_LIMIT ))
  		do
       	random=$((RANDOM%2))
   			if [[ $random -eq $PY_LOST ]]
   			then
         		STAKE_AMOUNT=$((STAKE_AMOUNT-1));
					((dayLostCount++))
   			else
         		STAKE_AMOUNT=$((STAKE_AMOUNT+1));
					((dayWinCount++))
   			fi
 		done
  	day_WinLoose $dayWinCount $dayLostCount $day
	((day++))
	STAKE_AMOUNT=$((STAKE_AMOUNT+INITIAL))
	PERCENT_STAKE=$((($STAKE_AMOUNT*50)/100))
	WIN_LIMIT=$((PERCENT_STAKE+STAKE_AMOUNT))
	LOSE_LIMIT=$((STAKE_AMOUNT-PERCENT_STAKE))
done
 echo -e "Days on which player Won and Amount:\nDay=${!arr_Win[@]}\n${arr_Win[@]}"
 echo -e "Days on which player Lost and Amount:\nDay=${!arr_Lose[@]}\n${arr_Lose[@]}"
