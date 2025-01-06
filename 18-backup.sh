#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14} #if user is not providing no of days we take as 14 days

LOGS_FOLDER="/home/ec2-user/shellscript-logs"
LOG_FILE=$(echo $0 |  awk -F "/" '${print $NF}' | cut -d "." -f1 )
TIMESTAMP=$(date +%Y-%m-%d-%H-%M-%S)
LOG_FILE_NAME="$LOGS_FOLDER/$LOG_FILE-$TIMESTAMP.log"



VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo -e "$2 ... $R FAILURE $N"
        exit 1
    else
        echo -e "$2 ... $G SUCCESS $N"
    fi
}

USAGE(){
    echo -e "$R USAGE::: $N sh 18-backup-script.sh <SOURCE-DIR> <DEST-DIR> <DAYS(Optional)>"
    exit 1
}
mkdir -p /home/ec2-user/shellscript-logs/

if [ $# -lt 2 ]
then 

 USAGE  

 fi

if [ ! -d $SOURCE_DIR ]
then
  
  echo -e "$SOURCE_DIR Doest not exist please check..."
  exit 1
  
fi

if [ ! -d $DEST_DIR ]
then
  
  echo -e "$DEST_DIR Doest not exist please check..."
  exit
  
fi

FILES=$(find $SOURCE_DIR -name "*.log" -mtime +$DAYS)

if [ -n "$FILES" ] # true if there are files to zip
 then 
   
  echo "Files are $FILES"
  ZIP_FILE="$DEST_DIR/app-log-$TIMESTAMP.zip"
  find $SOURCE_DIR -name "*.log" -mtime +$DAYS | zip -@ "$ZIP_FILE"
  if [ -f "$ZIP_FILE" ]
  then 
    echo -e "Successfully created file for the files older than $DAYS"

            while read -r filepath # here filepath is the variable name, you can give any name
            do
                    echo "Deleting file: $filepath" &>>$LOG_FILE_NAME
                    rm -rf $filepath
                    echo "Deleted file: $filepath"
            done <<< $FILES

  else

   echo -e "$R Error ::: $N Failed to create zip files "
   exit 1

   fi
else 

   echo "No Files found older than $DAYS"
fi



echo "Script started executing at: $TIMESTAMP" &>>$LOG_FILE_NAME