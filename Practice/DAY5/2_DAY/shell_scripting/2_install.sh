#!/bin/bash

USERID=$(id -u)
if [ $USERID -ne 0 ]
then 
echo "Error, please login with root user"
fi
yum install git -y