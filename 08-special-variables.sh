#!/bin/bash

echo "all variables: $@"
echo "number of variables: $#"
echo "script Name : $0"
echo "present working directory: $PWD"
echo "HOME DIRECTORY OF A CURRENT USER : $HOME"
echo "WHICH USER EXECUTING THE SCRIPT : $USER"
echo "PROCESS ID OF THE CURRENT SCRIPT : $$"

sleep 60 & #BACK GROUND COMMAND WE ARE USING TO CHECK THE BELOW COMMAND

echo "PROCESS ID OF THE LAST COMMAND RUNNNING IN BACKGROUND : $!"



