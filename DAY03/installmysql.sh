#!/bin/bash

#program to install mysql
USERID=$(id -u)
if [ $USERID -ne 0 ]
    then
       echo "ERROR: Please run script with roo user"
fi

yum install mysql -y