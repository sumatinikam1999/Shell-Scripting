#task: install multiple packages with single script
#user will pass the packages through command line
#user should have root access
#while installing store logs
#before installing it is always good to check package is installed or not
#if installed skip, otherwise proceed for installation
#check successfully installed or not
#implement colors

DATE=$(date +%F:%H:%M:%S)
SCRIPT_NAME=$0
LOGFILE=/tmp/$SCRIPT_NAME-$DATE
USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

#validate function will check previous command executed successfully or not means it check whether package execution command executed successfully or not if installed then success or else failure
VALIDATE() {
if [ $? -ne 0 ]
 then
  echo -e "$2....$R...Error while Installing package...$N"
else
  echo -e "$2....$G...package installation done successfully...$N"
fi
}

#it will check user logged in with root user or not
if [ $USERID -ne 0 ]
then
  echo "Login with root user"
else 
  echo "Please proceed with installation"
fi

#for loop will loop thorugh one by one argument user is passing through command line 
#first it will check package already installed or not if not installed then in if block i will check previous command status if not installed then install the package
for i in $@
 do
   yum list installed $i &>> $LOGFILE
     if [ $? -ne 0 ]
      then
        yum install $i -y &>> $LOGFILE
        VALIDATE $? "$G..Installing $i..$N"
     else
        echo -e "$Y...$i is already installed"
     fi
done