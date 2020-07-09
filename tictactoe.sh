#!/bin/bash

echo "WELCOME TO TIC TAC TOE SIMULATION"

TOTAL_GRIDS=9

declare -A board

function resetBoard
{
	for (( position=1; position<=$TOTAL_GRIDS; position++ ))
	do
		board[$position]=$position
	done
}

resetBoard
