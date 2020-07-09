#!/bin/bash 

echo "WELCOME TO TIC TAC TOE SIMULATION"

TOTAL_GRIDS=9
NUMBER_OF_ROWS=3
NUMBER_OF_COLUMNS=3
TRUE=1
FALSE=0

flag=$FALSE
value=$FALSE

declare -A board

function resetBoard()
{
	for (( i=$TRUE; i<=$NUMBER_OF_ROWS; i++ ))
	do
		for (( j=$TRUE; j<=$NUMBER_OF_COLUMNS; j++  ))
		do
			board[$i,$j]='.'
		done
	done
}
function assignLetter()
{
	local letter=$(( RANDOM%2 ))
	if [ $letter -eq 1 ]
	then
		playerSymbol=X
		computerSymbol=O
	else
		playerSymbol=O
		computerSymbol=X
	fi

	echo "Player Symbol is " $playerSymbol
	echo "Player Symbol is " $computerSymbol
}

function toss()
{
	assignLetter
	read -p "Enter your choice > 1.Head  2.Tail  >  " choice
	local tossValue=$(( $(( $RANDOM%2 ))+1 ))
	if [ $tossValue -eq $choice ]
	then
		playerTurn=1
		echo "Player won the toss"
		echo "FIRST TURN"
	else
		playerTurn=2
		echo "Player lost the toss"
		echo "SECOND TURN"
	fi
}

function displayBoard()
{
    local num=3
	for((i=1; i<=$num; i++))
	do
  	  for((j=1; j<=$num; j++))
  	   do
             echo -n "."
           done
             echo
        done
}

function checkRow()
{
	for (( i=$TRUE; i<=$NUMBER_OF_ROWS; i++ ))
	do
		if [ $value -eq $FALSE ]
		then
		j=$TRUE
		if [ ${board[$i,$j]} != "." ] && [ ${board[$i,$j]} == ${board[$i,$(( $j+1 ))]} ] && [ ${board[$i,$(( $j+1 ))]} == ${board[$i,$(( $j+2 ))]} ]
		then
			value=$TRUE
			checkWinner
			break
		fi
		fi
	done
}

function checkColumn()
{
        for (( i=$TRUE; i<=$NUMBER_OF_COLUMNS; i++ ))
        do
		if [ $value -eq $FALSE ]
		then
        	j=$TRUE
                if [ ${board[$j,$i]} != "." ] && [ ${board[$j,$i]} == ${board[$(( $j+1 )),$i]} ] && [ ${board[$(( $j+1 )),$i]} == ${board[$(( $j+2 )),$i]} ]
                then
	                value=$TRUE
			checkWinner
			break
                fi
		fi
        done
}

function checkDiagonal()
{
	if [ ${board[1,1]} != "." ] && [ ${board[1,1]} == ${board[2,2]} ] && [ ${board[2,2]} == ${board[3,3]} ]
	then
		i=$TRUE
		j=$TRUE
		value=$TRUE
		checkWinner
	elif [ ${board[1,3]} != "." ] && [ ${board[1,3]} == ${board[2,2]} ] && [ ${board[2,2]} == ${board[3,1]} ]
	then
		i=$TRUE
		j=3
		value=$TRUE
		checkWinner
	fi
}

function checkTie()
{
	tie=$FALSE
	for (( i=$TRUE; i<=$NUMBER_OF_ROWS; i++ ))
	do
		for (( j=$TRUE;j<=$NUMBER_OF_COLUMNS; j++ ))
		do
			if [ ${board[$i,$j]} != '.' ]
			then
				tie=$(( $tie+$TRUE ))
				if [ $tie -eq $TOTAL_GRIDS ]
				then
					echo "TIE"
					break
				fi
			fi
		done
		if [ $tie -eq $TOTAL_GRIDS ]
		then
			break
		fi
	done
}


function isWinner()
{
	position=1
	while [ $position -le $TOTAL_GRIDS ]
	do
		resetBoard
		toss
		displayBoard
		flag1=$(checkRow)
		flag2=$(checkColumn)
		flag3=$(checkDiagonal)

		if [ $flag1 -eq 0 ]
		then
			echo "WIN"
			exit

		elif [ $flag2 -eq 0 ]
		then
			echo "WIN"
			exit

		elif [ $flag3 -eq 0 ]
		then
			echo "WIN"
			exit
		fi

		position=$(( $position+1 ))
	done
}


isWinner
