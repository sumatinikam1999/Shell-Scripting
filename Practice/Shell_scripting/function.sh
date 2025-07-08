#!/bin/bash
DATE=$(date +%F-%H-%M-%S)
SCRIPT_NAME=$0
LOGFILE=/tmp/$SCRIPT_NAME-$DATE.log
R="\e[31m"
G="\e[32m"
N="\e[0m"

USERID=$(id -u)
validate(){
    if [ $1 -ne 0 ]
    then 
    echo -e "$2 Installation..Failure$R..$N"
    exit 1
    else
    echo -e "$2 Installation..Success$G..$N"
    fi
}
if [ $USERID -ne 0 ]
then
echo "Error"
exit 1
else
echo "Root user"
fi

yum install mysql -y &>> $LOGFILE
VALIDATE $? "Installing mysql"

yum install postfix -y &>> $LOGFILE
VALIDATE $? "Installing postfix"