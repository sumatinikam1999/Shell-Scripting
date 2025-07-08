#!/bin/bash
DATE=$(date +%F:%H:%M:%S)
LOGDIR=/home/centos/shell
SCRIPT=$0
LOGFILE=$LOGDIR/$SCRIPT-$DATE.log

USERID=$(id -u)
R="\e[31"
G="\e[32"
N="\e[0"

if [ $USERID -ne 0 ]
then
echo -e "$R Error $N"
exit 1
fi

validate(){
    if [ $? -ne 0 ]
    then
    echo -e "Installing $R Failure $N"
    else
    echo -e "Installing $G Success $N"
    fi
}

for i in $@
do
yum installed $i &>> $LOGFILE
if [ $? -ne 0 ]
then
echo "$i is not installed, let's install it"
yum install $i -y &>> $LOGFILE
validate $? "$i"
else
echo -e "$G $i is already installed"
fi
done