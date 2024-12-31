#!/bin/bash

MOVIES=("PUSHPA" "RRR" "DEVARA")

echo "movie of 1: ${MOVIES[0]}"
echo "movie OF 2: ${MOVIES[1]}"
echo "movie of 3: ${MOVIES[2]}"

echo "movie of 3: ${MOVIES[@]}"  #FOR ALL MOVIES