#### we need to delete log files more than 2 weeks
```
only .log files should be deleted, don't delete any other file
go to folder
get all the log files with extension .log
check the date
if date is more than two weeks old delete

make some directory and create files with some date
touch cart-2025-05-07.log
touch user-2025-06-07.log
touch mysql-2023-05-07.log
touch redis-2025-05-07.log
touch catalogue-2020-05-07.log
touch rabbitmq-2024-08-07.log
touch payment-2021-06-09.log

create file with old date
touch -d 20250507 cart-2025-05-07.log
touch -d 20250607 user-2025-06-07.log
touch -d 20230507 mysql-2023-05-07.log
touch -d 20250507 redis-2025-05-07.log
touch -d 20200507 catalogue-2020-05-07.log
touch -d 20240807 rabbitmq-2024-08-07.log
touch -d 20210609 payment-2021-06-09.log
```
---

## find the files with .log extension more than two week old
`find /var/log -name "*.log" -type f -mtime +14(-type f: type file, -mtime +14: older than 14 days)`

#### while loop: it will delete one by one file
```
while read line
  do 
    #write all statements here
done < $FILES_TO_DELETE
```

### <<< means passing the input here were are passing all logs file to delete
### > means passing output

```
crontab -e: to schedule shell script edit this file 
* * * * * : run every one minute
we always give absolute path in crontab
crontab -l
```
```
/var/log: tail -f cron
sh script-name: no need of execute permission
./<scriptname>: it should have execute permission
chmod +x scriptname
```
---

## disk usage
write a shell script that should check disk usage every one hour, and send alert email if is consuming more than 80%
df -hT
you need to have gmail installed in linux server
we don't have browse un linux everything is through command line
install 3rd party tools give gmail credentials, 3rd party tolls connect to gmail server and send email


#### steps to install gmail in amazon linux 2023

```
sudo dnf install -y mailx

sudo vi /etc/mail.rc

set smtp-use-starttls
set ssl-verify=ignore
set smtp=smtp://smtp.gmail.com:587
set smtp-auth=login
set smtp-auth-user=sumatinikam1999@gmail.com
set smtp-auth-password=mlrdhbzalatbieni
set from="sumatinikam1999@gmail.com"

add password to login from applications
mlrdhbzalatbieni
echo "This is a test email from Amazon Linux" | mailx -s "Test Mail" sumatinikam1999@gmail.com
```

---

For Shell script:
Stream line editor(sed)
temporary editor
if you want permanent then use -i option instead or -e

CRUD
creation of line
updation of line
deletion of line

#adding text after line 1
sed -e '1 a Good Morning' Passwd 
#adding text before line 1
sed -e '1 i Good Morning' Passwd 
#this will replace first occurance in every line
sed -e 's/<word-to-find>/<word-to-replace>' <file-name>
#if you want to replace all the ocurances then use g, g for global
sed -e 's/<word-to-find>/<word-to-replace>/g' <file-name>
#delete
sed -e '/<word-to-delete/ d' <file-name>


