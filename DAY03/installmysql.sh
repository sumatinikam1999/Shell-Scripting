#!/bin/bash

#program to install mysql
USERID=$(id -u)
if [ $USERID -ne 0 ]
    then
       echo "ERROR: Please run script with roo user"
       exit 1 #shell script won't understand by default to stop after seeing error so we have give exit status other than zero to exit if having error
fi

yum install git -y

if [ $? -ne 0 ]
    then
       echo "Installation Failure"
       exit 1
else
       echo "Installation is success"
fi

yum install postfix -y

if [ $? -ne 0 ]
     then
        echo "Installation of postfix is error"
else
        echo "Installation of postfix is success"
fi