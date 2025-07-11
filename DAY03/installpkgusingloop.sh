#!/bin/bash
DATE=$(date +%F)
SCRIPT_NAME=$0
LOGFILE=/tmp/$SCRIPT_NAME-$DATE.log
R="\e[31m"
G="\e[32m"
N="\e[0m"
VALIDATE(){
    if [ $1 -ne 0 ]
          then
            echo -e "$2...$R...Failure...$N"
            exit 1
    else
            echo -e "$2...$G...Success...$N"
    fi
}
#all arguments are in $@
for i in $@
do
 yum install $i -y &>> $LOGFILE
done
VALIDATE $? "Installing $@"
#improvemnts
#implement log file
#implement colors
#implement validations
#implement validations through functions
#your script should check package is already installed or not, if already installed print yellow color
#If installed just print package is already installed it should not go for installation again

