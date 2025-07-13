#!/bin/bash

#anyone can call this script by passing argument
# mail.sh TO_ADDRESS SUBJECT BODY TEAM_NAME ALERT_TYPE
TO_ADDRESS=$1
SUBJECT=$2
BODY=$3
TEMA_NAME=$4
ALERT_TYPE=$5

#echo "all args: $@"

# $ will work in double quote not single quote
FINAL_BODY=$(sed -e 's/TEAM_NAME/DevOps Team/g' -e 's/ALERT_TYPE/High Disk Usgae/g' -e "s/MESSAGE/$BODY" template.html)
echo "$FINAL_BODY" | mailx -s "$SUBJECT" $TO_ADDRESS 
