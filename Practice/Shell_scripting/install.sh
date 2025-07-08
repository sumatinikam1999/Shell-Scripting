#!/bin/bash
USERID=$(id -u)
if [ $USERID -ne 0 ]
then
echo "Error::Please run script with root user"
exit 1
else
echo "Info::You are root user"
fi
yum install git -y