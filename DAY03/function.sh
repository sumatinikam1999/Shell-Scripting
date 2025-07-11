#!/bin/bash

#program to install mysql
USERID=$(id -u)
#this function should validate previous command and inform user it's success or failure
VALIDATE() {
 # $1 it will receive argument1
 # $2 it will receive argument2
if [ $1 -ne 0 ] 
       then
           echo "$2 failure"
else
           echo "$2 success"
fi
    }
if [ $USERID -ne 0 ]
    then
       echo "ERROR: Please run script with roo user"
       exit 1 #shell script won't understand by default to stop after seeing error so we have give exit status other than zero to exit if having error
fi

yum install git -y

VALIDATE $? "Installing Git"

yum install postfix -y

VALIDATE $? "Installing postfix"