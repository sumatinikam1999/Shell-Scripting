#!/bin/bash

#program to install mysql
USERID=$(id -u)
if [ $USERID -ne 0 ]
    then
       echo "ERROR: Please run script with roo user"
       exit 1
fi

yum install git -y