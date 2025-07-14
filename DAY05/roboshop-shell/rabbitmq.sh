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

#curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash &>>$LOGFILE

#curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash &>>$LOGFILE

#dnf install rabbitmq-server -y  &>>$LOGFILE
#VALIDATE $? "Downloading"

# Step 1: Install Erlang (dependency)
#curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash &>>$LOGFILE
#VALIDATE $? "Adding Erlang repo"

#dnf install -y erlang &>>$LOGFILE
#VALIDATE $? "Installing Erlang"

#dnf install -y https://github.com/rabbitmq/erlang-rpm/releases/download/v26.2.1/erlang-26.2.1-1.el9.x86_64.rpm

# Step 2: Install RabbitMQ repo
#curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash &>>$LOGFILE
#VALIDATE $? "Adding RabbitMQ repo"
dnf install -y https://github.com/rabbitmq/rabbitmq-server/releases/download/v3.12.11/rabbitmq-server-3.12.11-1.el9.noarch.rpm

# Step 3: Install RabbitMQ
dnf install -y rabbitmq-server &>>$LOGFILE
VALIDATE $? "Installing RabbitMQ"
systemctl enable rabbitmq-server &>> $LOGFILE
VALIDATE $? "Enabling"

systemctl start rabbitmq-server &>> $LOGFILE
VALIDATE $? "Starting"

rabbitmqctl add_user roboshop roboshop123 &>> $LOGFILE
VALIDATE $? "adding user"

rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>> $LOGFILE
VALIDATE $? "Setting permission"