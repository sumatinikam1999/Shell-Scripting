#!/bin/bash

USERID=$(id -u)
DATE=$(date +%F:%H:%M:%S)
SCRIPT_NAME=$0
LOGFILE=/tmp/$SCRIPT_NAME-$DATE

R="\e[31"
G="\e[32"
N="\e[0"

validate(){
    if [ $USERID -ne 0 ]
    then 
    echo -e "$R ERROR: run script with root user $N"
    else
    echo -e "$G INFO:you are root user $N"
    fi
}

yum install git -y &>> $LOGFILE
validate $? "Installing GIT"