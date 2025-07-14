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


VALIDATE_Roboshop(){
#Check if the roboshop user exists
if id "roboshop" >/dev/null 2>&1; then
        echo "user already exists"
else
        useradd roboshop
        echo "user roboshop created"
fi
}

VALIDATE_DIR(){
#Check if the /app directory exists or not
if [ -d "/app" ]; then
        echo "directory already exists"
else
        mkdir /app
        echo "directory /app created"
fi
}

sudo dnf install -y python3 gcc python3-devel &>> $LOGFILE

VALIDATE $? "Installing python"

VALIDATE_Roboshop $? "Creating User if not exists"
VALIDATE_DIR $? "Creating dir if not exists"

curl -L -o /tmp/payment.zip https://roboshop-builds.s3.amazonaws.com/payment.zip &>> $LOGFILE
VALIDATE $? "Downloading"

cd /app  &>> $LOGFILE
VALIDATE $? "Moving"

sudo dnf install -y python3-pip &>> $LOGFILE
VALIDATE $? "Installing python3"

pip3 install -r requirements.txt &>> $LOGFILE
VALIDATE $? "Installing dependencies"
cd /app &>> $LOGFILE
VALIDATE $? "Moving" 

cp /home/ec2-user/Shell-Scripting/DAY05/roboshop-shell/payment.service /etc/systemd/system/payment.service &>> $LOGFILE

systemctl daemon-reload &>> $LOGFILE
VALIDATE $? "daemon reload"

systemctl enable payment &>> $LOGFILE
VALIDATE $? "IEnabling python"

systemctl start payment &>> $LOGFILE
VALIDATE $? "Starting python"