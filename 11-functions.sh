#!/bin/bash

# Improve the Existing code and add function into it.

#!/bin/bash

USERID=$(id -u) # Here we fetches the user id of the current user if sudo then it is '0' else any other number

# Valicdation function for success or faliure message
VALIDATE()
{
    if [ $1 -ne 0 ]
    then 
       echo "$2 INSTALLATION IS FAILURE"
       exit 1 # After executing the above statement return with exit status as 1 other than 0  which is "failure"
    else 
       echo "$2 INSTALLATION IS SUCCESS"
    fi # End of If
}



if [ $USERID -eq 0 ] # If result other than zero then show that this account is not authotized..! message as follows  
then 
   
    ############## To Install MYSQL into the linux server ##############

    dnf list installed mysql 
    if [ $? -ne 0 ]
    then 
       dnf install mysql -y
       VALIDATE $? "Mysql"

    else
      echo "MYSQL Is already Installed In your System.."
    fi # End of If

   ############## To Install GIT into the linux server ##############

   dnf list installed git 
    if [ $? -ne 0 ]
    then 
       dnf install git -y
       VALIDATE $? "Git"
    else
      echo "GIT Is already Installed In your System.."
    fi # End of If


else
      echo "ERROR:: You must have sudo access to execute this script"
fi # End of If

