INITIAL=100;
BET_AMOUNT=1;
PY_LOST=0;
PERCENT_STAKE=$(((INITIAL*50)/100))
WIN_LIMIT=$((PERCENT_STAKE+INITIAL))
LOSE_LIMIT=$((INITIAL-PERCENT_STAKE))
NUM_OF_DAYS=30;

stakeAmount=100;
half=50;
sumWin=0;
sumLose=0;
amtWin=0;
amtLose=0;

function dayWinLoose()
{
	dayWin=$1
	dayLose=$2
	dayCount=$3
	if [ $dayWin -gt $dayLose ]
	then
		amtWin=$((dayWin-dayLose))
		echo "you win today $"$amtWin
		arr_Win[(($dayCount))]=$amtWin
		sumWin=$((sumWin+amtWin))
	else
		amtLose=$((dayLose-dayWin))
		echo "you lost today $"$amtLose
		arr_Lose[(($dayCount))]=$amtLose
		sumLose=$((sumLose+amtLose))
	fi
}

function checkLuckyDay()
{
	max=$half;
	for findMax in "${arr_Win[@]}" ;
	do
		((findMax > max)) && max=$findMax
	done
	value=$max
	for findIndex in "${!arr_Win[@]}";
	do
		if [[ "${arr_Win[$findIndex]}" = "${value}" ]];
		then
			echo -e "\nLucky Day=${findIndex} and Amount Won=$max";
		fi
	done
}

function checkUnluckyDay()
{
	min=$half;
	for findMin in "${arr_Lose[@]}" ;
	do
		((findMin > min)) && min=$findMin
	done
	value=$min
	for findMinIndex in "${!arr_Lose[@]}";
	do
		if [[ "${arr_Lose[$findMinIndex]}" = "${value}" ]];
		then
			echo -e "\nunLucky Day=${findMinIndex} and Amount Lost=$min";
		fi
	done
}

function checkMonthWinLose()
{
	if [ $sumWin -gt $sumLose ]
	then
		echo -e "Win Amount=$sumWin\nLose Amount=$sumLose\nyou won this month Continuing for next month"
		day=1;
		play
	else
		echo -e "Win Amount=$sumWin\nLose Amount=$sumLose\nyou lost this month ....Play stops."
	fi
}

function play()
{
	declare -a arr_Win
	declare -a arr_Lose
	day=1;
	for((counter=$day;counter<=$NUM_OF_DAYS;counter++))
	do
		local	dayWinCount=0;
		local	dayLostCount=0;
		while (( $stakeAmount < $WIN_LIMIT )) && (( $stakeAmount > $LOSE_LIMIT ))
		do
			random=$((RANDOM%2))
			if [[ $random -eq $PY_LOST ]]
			then
				stakeAmount=$((stakeAmount-1));
				((dayLostCount++))
			else
				stakeAmount=$((stakeAmount+1));
				((dayWinCount++))
			fi
		done
		dayWinLoose $dayWinCount $dayLostCount $day
		((day++))
		stakeAmount=$((stakeAmount+INITIAL))
		echo "start amount for today = $stakeAmount"
		PERCENT_STAKE=$(((stakeAmount*50)/100))
		WIN_LIMIT=$((PERCENT_STAKE+stakeAmount))
		LOSE_LIMIT=$((stakeAmount-PERCENT_STAKE))
		if [ $counter -eq 30 ]
		then
			echo -e "Days on which player Won and Amount:\nDay=${!arr_Win[@]}\n${arr_Win[@]}"
			echo -e "Days on which player Lost and Amount:\nDay=${!arr_Lose[@]}\n${arr_Lose[@]}"
			checkLuckyDay
			checkUnluckyDay
			checkMonthWinLose
		fi
	done
}
play
