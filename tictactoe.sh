#!/bin/bash

echo "WELCOME TO TIC TAC TOE SIMULATION"

#Constants
TOTAL_GRIDS=9
NUMBER_OF_ROWS=3
NUMBER_OF_COLUMNS=3

#variables
flag=0
value=0

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
		playerSymbol=X
		computerSymbol=O
	else
		playerSymbol=O
		computerSymbol=X
	fi

	echo "Player Symbol is " $playerSymbol
	echo "Computer Symbol is " $computerSymbol
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
local board[i,j]=3
        for((i=1; i<=${board[i,j]}; i++))
        do
          for((j=1; j<=${board[i,j]}; j++))
          do
          echo -n "| . |"
          done
        echo
       done
}

function changeTurn()
{
	if [ $playerTurn -eq 1 ]
	then
		playerMove
	elif [ $playerTurn -eq 2 ]
	then
		computerMove
	fi
}

function checkRow()
{
	for (( i=1; i<=$NUMBER_OF_ROWS; i++ ))
	do
		if [ $value -eq 0 ]
		then
		j=1
		if [ ${board[$i,$j]} != "." ] && [ ${board[$i,$j]} == ${board[$i,$(( $j+1 ))]} ] && [ ${board[$i,$(( $j+1 ))]} == ${board[$i,$(( $j+2 ))]} ]
		then
			value=1
			checkWinner
			break
		fi
		fi
	done
}

function checkColumn()
{
        for (( i=1; i<=$NUMBER_OF_COLUMNS; i++ ))
        do
		if [ $value -eq 0 ]
		then
        	j=1
                if [ ${board[$j,$i]} != "." ] && [ ${board[$j,$i]} == ${board[$(( $j+1 )),$i]} ] && [ ${board[$(( $j+1 )),$i]} == ${board[$(( $j+2 )),$i]} ]
                then
	                value=1
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
		i=1
		j=1
		value=1
		checkWinner
	elif [ ${board[1,3]} != "." ] && [ ${board[1,3]} == ${board[2,2]} ] && [ ${board[2,2]} == ${board[3,1]} ]
	then
		i=1
		j=3
		value=1
		checkWinner
	fi
}

function checkTie()
{
	tie=0
	for (( i=1; i<=$NUMBER_OF_ROWS; i++ ))
	do
		for (( j=1;j<=$NUMBER_OF_COLUMNS; j++ ))
		do
			if [ ${board[$i,$j]} != '.' ]
			then
				tie=$(( $tie+1 ))
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

function checkWinner()
{
	if [ ${board[$i,$j]} == $computerSymbol ]
	then
		echo "computer won"
	elif [ ${board[$i,$j]} == $playerSymbol ]
	then
		echo "player won"
	fi
}
function displayWinner()
{
	checkTie
	checkRow
	checkColumn
	checkDiagonal
}

function setComputerSymbolToWinRow()
{
	for (( i=1; i<=$NUMBER_OF_ROWS; i++ ))
	do
		if [ $flag -ne 1 ]
		then
			j=1
			if [ ${board[$i,$j]} == $computerSymbol ] && [ ${board[$i,$(( $j+1 ))]} == $computerSymbol ] && [ ${board[$i,$(( $j+2 ))]} == "." ]
			then
				board[$i,$(( $j+2 ))]=$computerSymbol
				flag=1
			elif [ ${board[$i,$j]} == $computerSymbol ] && [ ${board[$i,$(( $j+1 ))]} == "." ] && [ ${board[$i,$(( $j+2 ))]} == $computerSymbol ]
			then
				board[$i,$(( $j+1 ))]=$computerSymbol
				flag=1
			elif [ ${board[$i,$j]} == "." ] && [ ${board[$i,$(( $j+1 ))]} == $computerSymbol ] && [ ${board[$i,$(( $j+2 ))]} == $computerSymbol ]
			then
				board[$i,$j]=$computerSymbol
				flag=1
			fi
	fi
        done
}

function setComputerSymbolToWinColumn()
{
        for (( i=1;i<=$NUMBER_OF_COLUMNS; i++ ))
        do
		if [ $flag -ne 1 ]
		then
            		j=1
                	if [ ${board[$j,$i]} == $computerSymbol ] && [ ${board[$(( $j+1 )),$i]} == $computerSymbol ] && [ ${board[$(( $j+2 )),$i]} == "." ]
                        then
                                board[$(( $j+2 )),$i]=$computerSymbol
                                flag=1
                        elif [ ${board[$j,$i]} == $computerSymbol ] && [ ${board[$(( $j+1 )),$i]} == "." ] && [ ${board[$(( $j+2 )),$i]} == $computerSymbol ]
                        then
                                board[$(( $j+1 )),$i]=$computerSymbol
                                flag=1
                        elif [ ${board[$j,$i]} == "." ] && [ ${board[$(( $j+1 )),$i]} == $computerSymbol ] && [ ${board[$(( $j+2 )),$i]} == $computerSymbol ]
                        then
                                board[$j,$i]=$computerSymbol
                                flag=1
                        fi
		fi
        done
}

function setComputerSymbolToDiagonal()
{
	if [ ${board[3,3]} == '.' ]
	then
		if [ ${board[1,1]} == $1 ] && [ ${board[2,2]} == $1 ]
		then
			board[3,3]=$2
			flag=1
		fi
	elif [ ${board[2,2]} == '.' ]
	then
		if [ ${board[1,1]} == $1 ] && [ ${board[3,3]} == $1 ]
		then
			board[2,2]=$2
			flag=1
		fi
	elif [ ${board[1,1]} == '.' ]
	then
		if [ ${board[2,2]} == $1 ] && [ ${board[3,3]} == $1 ]
        	then
                	board[1,1]=$2
                	flag=1
		fi
	elif [ ${board[3,1]} == '.' ]
	then
		if [ ${board[1,3]} == $1 ] && [ ${board[2,2]} == $1 ]
        	then
                	board[3,1]=$2
                	flag=1
		fi
	elif [ ${board[2,2]} == '.' ]
	then
		if [ ${board[1,3]} == $1 ] && [ ${board[3,1]} == $1 ]
        	then
                	board[2,2]=$2
                	flag=1
		fi
	elif [ ${board[1,3]} == '.' ]
	then
		if [ ${board[3,1]} == $1 ] && [ ${board[2,2]} == $1 ]
        	then
                	board[1,3]=$2
                	flag=1
		fi
	fi
}

function setComputerSymbolToBlockRow()
{
	for (( i=1;i<=$NUMBER_OF_ROWS; i++ ))
        do
		if [ $flag == 0 ]
		then
                	j=1
               		if [ ${board[$i,$j]} == $playerSymbol ] && [ ${board[$i,$(( $j+1 ))]} == $playerSymbol ] && [ ${board[$i,$(( $j+2 ))]} == "." ]
                        then
                                board[$i,$(( $j+2 ))]=$computerSymbol
                                flag=1
                        elif [ ${board[$i,$j]} == $playerSymbol ] && [ ${board[$i,$(( $j+1 ))]} == "." ] && [ ${board[$i,$(( $j+2 ))]} == $playerSymbol ]
                        then
                                board[$i,$(( $j+1 ))]=$computerSymbol
                                flag=1
                        elif [ ${board[$i,$j]} == "." ] && [ ${board[$i,$(( $j+1 ))]} == $playerSymbol ] && [ ${board[$i,$(( $j+2 ))]} == $playerSymbol ]
                        then
                                board[$i,$j]=$computerSymbol
                                flag=1
                        fi

		fi
	done
}
function setComputerSymbolToBlockColumn()
{
	for (( i=1;i<=$NUMBER_OF_COLUMNS; i++ ))
	do
		if [ $flag == 0 ]
		then
	            	j=1
                        if [ ${board[$j,$i]} == $playerSymbol ] && [ ${board[$(( $j+1 )),$i]} == $playerSymbol ] && [ ${board[$(( $j+2 )),$i]} == "." ]
                        then
                                board[$(( $j+2 )),$i]=$computerSymbol
                                flag=1
                        elif [ ${board[$j,$i]} == $playerSymbol ] && [ ${board[$(( $j+1 )),$i]} == "." ] && [ ${board[$(( $j+2 )),$i]} == $playerSymbol ]
                        then
                                board[$(( $j+1 )),$i]=$computerSymbol
                                flag=1
                        elif [ ${board[$j,$i]} == "." ] && [ ${board[$(( $j+1 )),$i]} == $playerSymbol ] && [ ${board[$(( $j+2 )),$i]} == $playerSymbol ]
                        then
                                board[$j,$i]=$computerSymbol
                                flag=1
                        fi

                fi
	done
}

function occupyCorner()
{
	for (( i=1; i<=$NUMBER_OF_ROWS; i=$(( $i+2 )) ))
        do
		if [ $flag -eq 0 ]
		then
                for (( j=1; j<=$NUMBER_OF_COLUMNS; j=$(( $j+2 )) ))
                do
                        if [ ${board[$i,$j]} = '.' ]
                        then
				board[$i,$j]=$computerSymbol
				flag=1
				break
			fi
		done
		fi
	if [ $flag -eq 0 ]
	then
		break
	fi
	done
}

function occupyCentre()
{
	if [ $flag -eq 0 ]
	then
	if [ ${board[2,2]} == '.' ]
	then
		board[2,2]=$computerSymbol
		flag=1
	fi
	fi
}

function occupySide()
{
	for (( i=1; i<=$NUMBER_OF_ROWS; i++ ))
        do
		if [ $flag -eq 0 ]
		then
                for (( j=1; j<=$(( $NUMBER_OF_COLUMNS-1 )); j++ ))
                do
			if [ $(( $j-$i )) -eq 1 ] || [ $(( $i-$j )) -eq 1 ]
			then
				if [ ${board[$i,$j]} == '.' ]
				then
					board[$i,$j]=$computerSymbol
					flag=1
				fi
			fi
		done
		fi
	done
}

function computerWin()
{
		setComputerSymbolToWinRow
		setComputerSymbolToWinColumn
		setComputerSymbolToDiagonal $computerSymbol $computerSymbol
}

function computerBlock()
{
		setComputerSymbolToBlockRow
		setComputerSymbolToBlockColumn
		setComputerSymbolToDiagonal $playerSymbol $computerSymbol
}

function computerMove()
{
	flag=0
	computerWin
	computerBlock
	occupyCorner
	occupyCentre
	occupySide
	displayBoard
	displayWinner
	checkTie
	if [ $tie != $TOTAL_GRIDS ] && [ $value == 0 ]
	then
		playerMove
	fi
}

function playerMove()
{
	read -p "Enter Row > " playerRow
	read -p "Enter Column > " playerColumn
	if [ $playerRow -lt 1 ] || [ $playerRow -gt 3 ] || [ $playerColumn -lt 1 ] || [ $playerColumn -gt 3 ]
	then
		echo "Invalid Move"
		playerMove
	elif [ ${board[$playerRow,$playerColumn]} == '.' ]
	then
		board[$playerRow,$playerColumn]=$playerSymbol
		displayBoard
		computerMove
	else
		echo "Board is occupied"
		playerMove
	fi
}

function playGame()
{
	tie=0
	resetBoard
	toss
	while [ $value == 0 ] && [ $tie != $TOTAL_GRIDS ]
	do
		displayBoard
		changeTurn
		displayWinner
		player=$(( (( $playerTurn%2 ))+1 ))
	done
}

playGame
