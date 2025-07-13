#!/bin/bash

#anyone can call this script by passing argument
# mail.sh TO_ADDRESS SUBJECT BODY TEAM_NAME ALERT_TYPE
TO_ADDRESS=$1
SUBJECT=$2
BODY=$3
TEMA_NAME=$4
ALERT_TYPE=$5

echo "all args: $@"