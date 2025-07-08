#/bin/bash
USERID=$(id -u)
R="\e[31"
G="\e[32"

if [ $USERID -ne 0 ]
then 
echo -e "$R Error $N"
exit 1
fi
yum install git -y