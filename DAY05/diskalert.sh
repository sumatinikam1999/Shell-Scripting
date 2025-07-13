## disk usage
#write a shell script that should check disk usage every one hour, and send alert email if is consuming more than 80%
#df -hT
#you need to have gmail installed in linux server
#we don't have browse in linux everything is through command line
#install 3rd party tools give gmail credentials, 3rd party tolls connect to gmail server and send email#

#algorithm
#check disk memory
#compare with threshold(10)
#if more than threshold trigger alert email
#command to check disk memory: df -hT

#!/bin/bash
#colors
#validations
#log redirection
LOGFILE_DIRECTORY=/tmp
DATE=$(date +%F:%H:%M:%S)
SCRIPT_NAME=$0
LOGFILE=$LOGFILE_DIRECTORY/$SCRIPT_NAME-$DATE.log

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"


DISK_USAGE=$(df -hT|grep -vE 'tmpfs|vfat|Filesystem')
DISK_USAGE_THRESHOLD=1
message=""

#IFS= means internal field seperator is space.
while IFS= read line
do
  #this command will give you usage in number format for comparision
  usage=$(echo $line | awk '{print $6}' | cut -d % -f1)
  #this command will give us partition
  partition=$(echo $line | awk '{print $1}')
  #now you need to check whether it is more than threshold or not
  if [ $usage -gt $DISK_USAGE_THRESHOLD ];
  then
  # + here means append to previous message
  message+="HIGH Disk Usage on $partition: $usage \n"
  fi
done <<< $DISK_USAGE

#echo "$message" | mailx -s "High Disk usage" sumatinikam1999@gmail.com

#how to call other scripts from your current script
sh mail.sh sumatinikam1999@gmail.com "High Disk Usage" "$message" $DEVOPS TEAM" "HIGH Disk Usage"
