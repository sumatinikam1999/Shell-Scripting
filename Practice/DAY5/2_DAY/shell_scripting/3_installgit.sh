#!/bin/bash
yum install git -y

if [ $? -ne 0 ]
then
echo "Git Installation Error"
else
echo "Git Installed successfully"
fi