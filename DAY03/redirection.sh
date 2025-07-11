#!/bin/bash

DATE=$(date +%F-%H-%M-%S)
SCRIPT_NAME=$0
LOGFILE=/tmp/$SCRIPT_NAME-$DATE.log

R="\e[31m"
G="\e[32m"
N="\e[0m"

VALIDATE() {
 # $1 it will receive argument1
 # $2 it will receive argument2
if [ $1 -ne 0 ] 
       then
           echo -e "$2 $R failure $N"
else
           echo -e "$2 $G success $N"
fi
    }

USERID=$(id -u)
#this function should validate previous command and inform user it's success or failure

if [ $USERID -ne 0 ]
    then
       echo "ERROR: Please run script with root user"
       exit 1 #shell script won't understand by default to stop after seeing error so we have give exit status other than zero to exit if having error
fi

yum install git -y &>> $LOGFILE

VALIDATE $? "Installing Git"

yum install postfix -y &>> $LOGFILE

VALIDATE $? "Installing postfix"