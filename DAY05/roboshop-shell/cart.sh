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

curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>> $LOGFILE

VALIDATE $? "Setting up NPM Source" 

yum install nodejs -y &>> $LOGFILE

VALIDATE $? "Installing NodeJS"

#once the user is created, if you run this script second time
#this command will fail
#Improvements: first check the user already exist or not if not exist then create
#useradd roboshop 
VALIDATE_Roboshop $? "Checking whether roboshop user created or not, if not then create user"

#write a condition directory already exists or not
#mkdir /app &>> $LOGFILE
VALIDATE_DIR $? "Checking directory exists or not, if not then create directory"

VALIDATE $? "Creating directory"

curl -o /tmp/cart.zip https://roboshop-builds.s3.amazonaws.com/cart.zip &>> $LOGFILE

VALIDATE $? "Downloading app code"

cd /app  >> $LOGFILE

VALIDATE $? "Moving to /app directory"

unzip /tmp/cart.zip &>> $LOGFILE

VALIDATE $? "Unzip File"

cd /app &>> $LOGFILE

VALIDATE $? "Moving to /app directory"

npm install  &>> $LOGFILE

VALIDATE $? "Installing dependencies"

#give full path of cart.service because we are inside /app
cp /home/ec2-user/Shell-Scripting/DAY05/roboshop-shell/cart.service /etc/systemd/system/cart.service &>> $LOGFILE

VALIDATE $? "Copying cart.service"

systemctl daemon-reload &>> $LOGFILE

VALIDATE $? "Running daemon reload"

systemctl enable cart &>> $LOGFILE

VALIDATE $? "Enabling cart"

systemctl start cart &>> $LOGFILE

VALIDATE $? "Start cart"

