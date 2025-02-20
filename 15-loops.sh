#!/bin/bash


USERID=$(id -u) # Here we fetches the user id of the current user if sudo then it is '0' else any other number

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
LOGS_FOLDER="/var/log/shell-script-logs"
LOG_FILE=$(echo $0 | cut -d "." -f1 )
TIMIESTAMP=$(date +%Y-%m-%d-%H-%M-%S) # yyyy/mm/dd/HRS/MIN/SEC
LOG_FILE_NAME="$LOGS_FOLDER/$LOG_FILE-$TIMIESTAMP.log" # this is the folder name follwed by logfile with timestamp

# Valicdation function for success or faliure message
VALIDATE()
{
    if [ $1 -ne 0 ]
    then 
       echo -e "$2 INSTALLATION....$R IS FAILURE $N"
       exit 1 # After executing the above statement return with exit status as 1 other than 0  which is "failure"
    else 
       echo -e "$2 INSTALLATION IS $G SUCCESS $N"
    fi # End of If
}

echo "Script stat=rted executing at $TIMIESTAMP" &>>$LOG_FILE_NAME

for package in $@
do
  dnf list installed $package  &>>$LOG_FILE_NAME
   if [ $? -ne 0 ]
    then 
      dnf install $package -y &>>$LOG_FILE_NAME
      VALIDATE $? "Installing $package"
       
    else
     echo -e "$package is already $Y...Installed.$N"
     fi
done