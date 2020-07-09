#!/bin/bash

echo "WELCOME TO TIC TAC TOE SIMULATION"

TOTAL_GRIDS=9
NUMBER_OF_ROWS=3
NUMBER_OF_COLUMNS=3

flag=0

declare -A board

function resetBoard()
{
	for (( i=1; i<=$NUMBER_OF_ROWS; i++ ))
	do
		for (( j=1; j<=$NUMBER_OF_COLUMNS; j++  ))
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
		playerOneSymbol=X
		playerTwoSymbol=O
	else
		playerOneSymbol=O
		playerTwoSymbol=X
	fi

	echo "Player Symbol is " $playerOneSymbol
	echo "Computer Symbol is " $playerTwoSymbol
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
    echo -n "* "
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
function checkWin()
{
	if [ $(checkRow) -eq 1 ]
	then
		echo $(checkRow)
	elif [ $(checkColumn) -eq 1 ]
	then
		echo $(checkColumn)
	elif [ $(checkDiagonal) -eq 1 ]
	then
		echo $(checkDiagonal)
	else
		echo
	fi
}

function displayWinner()
{
	if [ $(checkWin) -eq 1 ]
	then
		echo "WON"
	elif [ $(checkTie) -eq 1 ]
	then
		echo "TIE"
	else
		echo "Next Turn"
	fi
}

toss
displayBoard
assignLetter
displayWinner
