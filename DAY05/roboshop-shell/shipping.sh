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


yum install maven -y &>> $LOGFILE

VALIDATE $? "Installing maven"

VALIDATE_Roboshop $? "Creating User if not exists"
VALIDATE_DIR $? "Creating dir if not exists"

curl -L -o /tmp/shipping.zip https://roboshop-builds.s3.amazonaws.com/shipping.zip &>> $LOGFILE

VALIDATE $? "Downloading"

cd /app &>> $LOGFILE

VALIDATE $? "Moving to /app"

unzip /tmp/shipping.zip &>> $LOGFILE

VALIDATE $? "unzipping shipping"

cd /app &>> $LOGFILE

VALIDATE $? "Moving to /app"

mvn clean package &>> $LOGFILE

VALIDATE $? "packaging shipping app"

mv target/shipping-1.0.jar shipping.jar &>> $LOGFILE

VALIDATE $? "shipping jar"

cp /home/ec2-user/Shell-Scripting/DAY05/roboshop-shell/shipping.service /etc/systemd/system/shipping.service &>> $LOGFILE

VALIDATE $? "Copying shipping service"

systemctl daemon-reload &>> $LOGFILE

VALIDATE $? "daemon reload"

systemctl start shipping &>> $LOGFILE

VALIDATE $? "starting shipping"

dnf install mariadb105 -y &>> $LOGFILE

VALIDATE $? "Installing mysql client"

#mysql -h 13.204.79.95 -uroot -pRoboShop@1 < /app/schema/schema.sql  &>> $LOGFILE

#VALIDATE $? "Trying to login to mysql"

if [ -f /app/schema/schema.sql ]; then
  mysql -h 13.204.79.95 -uroot -pRoboShop@1 < /app/schema/schema.sql &>> $LOGFILE
  VALIDATE $? "Loading schema into MySQL"
else
  echo -e "Schema file /app/schema/schema.sql not found...$R Failure...$N"
  exit 1
fi

systemctl restart shipping &>> $LOGFILE

VALIDATE $? "Restarting shipping"