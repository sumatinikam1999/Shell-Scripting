#!/bin/bash
R="\e[31m"
G="\e[32m"
N="\e[0m"

yum install mysql -y
if [ $? -ne 0 ]
then
echo -e "${R} Installation of mysql is error ${N}"
else
echo -e "${G} Installation of mysql is success ${N}"
fi

yum install postfix -y
if [ $? -ne 0 ]
then
echo -e "${R} Installation of postfix is error ${N}"
else
echo -e "${G} Installation of postfix is success ${N}"
fi