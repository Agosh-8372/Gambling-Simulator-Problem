INITIAL=100;
STAKE_AMOUNT=100;
BET_AMOUNT=1;
PY_LOST=0;
PERCENT_STAKE=$((($STAKE_AMOUNT*50)/100))
WIN_LIMIT=$((PERCENT_STAKE+STAKE_AMOUNT))
LOSE_LIMIT=$((STAKE_AMOUNT-PERCENT_STAKE))

NUM_OF_DAYS=30;
day=1;

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

function Lucky()
{
	max=50;
		for findMax in "${arr_Win[@]}" ; do
    		((findMax > max)) && max=$findMax
		done
	value=$max
		for findIndex in "${!arr_Win[@]}"; do
   		if [[ "${arr_Win[$findIndex]}" = "${value}" ]]; then
       		echo -e "\nLucky Day=${findIndex} and Amount Won=$max";
   		fi
		done
}

function unLucky()
{
	min=50;
		for findMin in "${arr_Lose[@]}" ; do
    		((findMin > min)) && min=$findMin
		done
	value=$min
		for findMinIndex in "${!arr_Lose[@]}"; do
   		if [[ "${arr_Lose[$findMinIndex]}" = "${value}" ]]; then
       		echo -e "\nunLucky Day=${findMinIndex} and Amount Lost=$min";
   		fi
		done
}

for((counter=$day;counter<=$NUM_OF_DAYS;counter++))
do
	dayWinCount=0;
   dayLostCount=0;
  		while (( $STAKE_AMOUNT < $WIN_LIMIT )) && (( $STAKE_AMOUNT > $LOSE_LIMIT ))
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
 Lucky
 unLucky
