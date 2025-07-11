#we need to delete log files more than 2 weeks
#only .log files should be deleted, don't delete any other file
#go to folder
#get all the log files with extension .log
#check the date
#if date is more than two weeks old delete

#!/bin/bash
APP_LOGS_DIR=/home/ec2-user/app-logs
DATE=$(date +%F:%H:%M:%S)
SCRIPT_NAME=$0
LOGDIR=/home/ec2-user/shellscript-logs

#this will define log file name which will be stored inside LOGDIR path
LOGFILE=$LOGDIR/$SCRIPT_NAME-$DATE.log

#find command will gather file with .log extension older than two weeks
FILES_TO_DELETE=$(find $APP_LOGS_DIR -name "*.log" -type f -mtime +14)
echo "$FILES_TO_DELETE"
echo "script started executing $DATE" &>> $LOGFILE
while read line
 do
  #write all statements here
  echo "Deleteing $line" &>> $LOGFILE
  rm -rf $line
done <<< $FILES_TO_DELETE # < means passing the input here were are passing all logs file to delete
# > means passing output