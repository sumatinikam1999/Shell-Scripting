#!/bin/bash

DATE=$(date +%F:%H:%M:%S)
LOG_DIR=/tmp
SCRIPT_NAME=$(basename "$0")
LOGFILE=$LOG_DIR/$SCRIPT_NAME-$DATE.log
R="\e[31m"
G="\e[32m"
N="\e[0m"

USERID=$(id -u)
if [ $USERID -ne 0 ]; then
    echo -e "$RERROR: Please run this script as root$N"
    exit 1
fi

VALIDATE() {
    if [ $1 -ne 0 ]; then
        echo -e "$2...$RFailure$N"
        exit 1
    else
        echo -e "$2...$GSuccess$N"
    fi
}

echo -e "Adding Erlang repo..."
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash &>>$LOGFILE
VALIDATE $? "Adding Erlang repo"

echo -e "Installing Erlang..."
dnf install -y erlang &>>$LOGFILE
VALIDATE $? "Installing Erlang"

echo -e "Adding RabbitMQ repo..."
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash &>>$LOGFILE
VALIDATE $? "Adding RabbitMQ repo"

echo -e "Installing RabbitMQ..."
dnf install -y rabbitmq-server &>>$LOGFILE
VALIDATE $? "Installing RabbitMQ"

echo -e "Enabling RabbitMQ service..."
systemctl enable rabbitmq-server &>>$LOGFILE
VALIDATE $? "Enabling RabbitMQ service"

echo -e "Starting RabbitMQ service..."
systemctl start rabbitmq-server &>>$LOGFILE
VALIDATE $? "Starting RabbitMQ service"

echo -e "Creating RabbitMQ user..."
rabbitmqctl add_user roboshop roboshop123 &>>$LOGFILE
VALIDATE $? "Adding user roboshop"

echo -e "Setting RabbitMQ permissions..."
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>$LOGFILE
VALIDATE $? "Setting permissions for roboshop"
