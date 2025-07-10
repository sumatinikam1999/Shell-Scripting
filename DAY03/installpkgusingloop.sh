#!/bin/bash
DATE=$(date +%F)
SCRIPT_NAME=$0
LOGFILE=/tmp/$SCRIPT_NAME-$DATE.log
#all arguments are in $@
for i in $@
do
 yum install $i -y &>> $LOGFILE
done

#improvemnts
#implement log file
#implement colors
#implement validations
#implement validations through functions
#your script should check package is already installed or not, if already installed print yellow color
#If installed just print package is already installed it should not go for installation again

