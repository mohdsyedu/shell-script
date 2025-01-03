#!/bin/bash

# Improve the Existing code and add Logs into it.

#!/bin/bash

USERID=$(id -u) # Here we fetches the user id of the current user if sudo then it is '0' else any other number

R="\e[31m"
G="\e[32m"
Y="\e[33m"
LOGS_FOLDER="/var/log/shellscript-logs"
LOG_FILE=$(echo $0 | cut -d "." -f1 )
TIMIESTAMP=$(date +%Y-%m-%d-%H-%M-%S) # yyyy/mm/dd/HRS/MIN/SEC
LOG_FILE_NAME="$LOGS_FOLDER/$LOG_FILE-$TIMIESTAMP.log" # this is the folder name follwed by logfile with timestamp

# Valicdation function for success or faliure message
VALIDATE()
{
    if [ $1 -ne 0 ]
    then 
       echo -e "$2 INSTALLATION....$R IS FAILURE"
       exit 1 # After executing the above statement return with exit status as 1 other than 0  which is "failure"
    else 
       echo -e "$2 INSTALLATION IS $G SUCCESS"
    fi # End of If
}

echo "Script stat=rted executing at $TIMIESTAMP" &>>$LOG_FILE


if [ $USERID -eq 0 ] # If result other than zero then show that this account is not authotized..! message as follows  
then 
   
    ############## To Install MYSQL into the linux server ##############

    dnf list installed mysql &>>$LOG_FILE
    if [ $? -ne 0 ]
    then 
       dnf install mysql -y &>>$LOG_FILE
       VALIDATE $? "Mysql"

    else
      echo -e "MYSQL Is already $Y Installed In your System.."
    fi # End of If

   ############## To Install GIT into the linux server ##############

   dnf list installed git  &>>$LOG_FILE
    if [ $? -ne 0 ]
    then 
       dnf install git -y &>>$LOG_FILE
       VALIDATE $? "Git"
    else
      echo -e "GIT Is already $Y Installed In your System.."
    fi # End of If


else
      echo -e "$R ERROR:: You must have sudo access to execute this script"
fi # End of If
