INITIAL=100;
STAKE_AMOUNT=100;
BET_AMOUNT=1;
PY_LOST=0;
PERCENT_STAKE=$((($STAKE_AMOUNT*50)/100))
WIN_LIMIT=$((PERCENT_STAKE+STAKE_AMOUNT))
LOSE_LIMIT=$((STAKE_AMOUNT-PERCENT_STAKE))

declare -a arr_Win=()
declare -a arr_lost=()
day=1
num_of_Days=20;

function day_WinLoose()
{
	dayWin=$1
	dayLose=$2
 	dayCount=$3
		if [ $dayWin -gt $dayLose ]
		then
			echo "you win today $"$((dayWin-dayLose))
			arr_Win[(($dayCount-1))]=$((dayWin-dayLose))
		else
			echo "you lost today $"$((dayLose-dayWin))
			arr_Lose[(($dayCount-1))]=$((dayLose-dayWin))
		fi
}


for((i=$day;i<=$num_of_Days;i++))
do
	totalWin=0;
   totalLost=0;
	echo "Day $day-Press 1 to place the bet "
 	read userValue
  		while  (($userValue == "1" )) && (( $STAKE_AMOUNT < $WIN_LIMIT )) && (( $STAKE_AMOUNT > $LOSE_LIMIT))
  		do
       	random=$((RANDOM%2))
   			if [[ $random -eq $PY_LOST ]]
   			then
         		STAKE_AMOUNT=$((STAKE_AMOUNT-1));
					((totalLost++))
   			else
         		STAKE_AMOUNT=$((STAKE_AMOUNT+1));
					((totalWin++))
   			fi
 		done
  	day_WinLoose $totalWin $totalLost $day
	((day++))
	STAKE_AMOUNT=$((STAKE_AMOUNT+INITIAL))
	PERCENT_STAKE=$((($STAKE_AMOUNT*50)/100))
	WIN_LIMIT=$((PERCENT_STAKE+STAKE_AMOUNT))
	LOSE_LIMIT=$((STAKE_AMOUNT-PERCENT_STAKE))
done
