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

#yum install nginx -y &>> $LOGFILE
amazon-linux-extras enable nginx1  &>> $LOGFILE

VALIDATE $? "Installing nginx"

# Clean metadata and install nginx
yum clean metadata &>> $LOGFILE

VALIDATE $? "Cleaning yum metadata"

yum install nginx -y &>> $LOGFILE

VALIDATE $? "Installing nginx"


systemctl enable nginx &>> $LOGFILE

VALIDATE $? "Enabling nginx"

systemctl start nginx &>> $LOGFILE

VALIDATE $? "Starting nginx"

rm -rf /usr/share/nginx/html/* &>> $LOGFILE

VALIDATE $? "Removing default website"

curl -o /tmp/web.zip https://roboshop-builds.s3.amazonaws.com/web.zip &>> $LOGFILE

VALIDATE $? "Downloading web artifact"

cd /usr/share/nginx/html &>> $LOGFILE

VALIDATE $? "Moving to default HTML directory"

unzip /tmp/web.zip &>> $LOGFILE

VALIDATE $? "unzipping web artifact"

cp /home/ec2-user/Shell-Scripting/DAY05/roboshop-shell/roboshop.conf /etc/nginx/default.d/roboshop.conf  &>> $LOGFILE

VALIDATE $? "copying roboshop config" 

systemctl restart nginx  &>> $LOGFILE

VALIDATE $? "Restarting nginx"