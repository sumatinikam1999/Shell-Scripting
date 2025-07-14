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

sudo amazon-linux-extras enable redis6 &>> $LOGFILE

VALIDATE $? "Installing Redis6"

sudo yum clean metadata &>> $LOGFILE

VALIDATE $? "Clean metadata"

sudo yum install redis -y &>> $LOGFILE

VALIDATE $? "Installing Redis"

sed -i 's/127.0.0.1/0.0.0.0/g' /etc/redis.conf  &>> $LOGFILE

VALIDATE $? "Replacing 127.0.0.1 with 0.0.0.0"

sudo systemctl start redis &>> $LOGFILE

VALIDATE $? Starting redis"

sudo systemctl enable redis &>> $LOGFILE

VALIDATE $? "Enabling redis" 


