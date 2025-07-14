#!/bin/bash
DATE=$(date +%F:%H:%M:%S)
LOG_DIR=/tmp
SCRIPT_NAME=$0
LOGFILE=$LOG_DIR/$SCRIPT_NAME-$DATE.log
R="\e[31m"
G="\e[32m"
N="\e[0m"
Y="\e[33m"

USERID=$(id -u)
#this function should validate previous command and inform user it's success or failure

if [ $USERID -ne 0 ]
    then
       echo "ERROR: Please run script with root user"
       exit 1 #shell script won't understand by default to stop after seeing error so we have give exit status other than zero to exit if having error
fi

VALIDATE(){
    if [ $1 -ne 0 ]
          then
            echo -e "$2...$R...Failure...$N"
            exit 1
    else
            echo -e "$2...$G...Success...$N"
    fi
}

cp /home/ec2-user/Shell-Scripting/DAY05/roboshop-shell/mysql.repo /etc/yum.repos.d/mysql.repo &>> $LOGFILE

VALIDATE $? "copying mysql repo"

yum install mysql-community-server -y &>> $LOGFILE

VALIDATE $? "installing mysql"

systemctl enable mysqld &>> $LOGFILE

VALIDATE $? "Enabling mysqld"

systemctl start mysqld &>> $LOGFILE

VALIDATE $? "starting mysqld"

mysql_secure_installation --set-root-pass RoboShop@1 &>> $LOGFILE

VALIDATE $? "Setting up root password"


