#!/bin/bash
echo "Enter the number with space"
 
read -a numbers
 
for ((i = 0; i < ${#numbers[@]}; i++)); do
    for ((j = i + 1; j < ${#numbers[@]}; j++)); do
        if ((numbers[i] > numbers[j])); then
            temp=${numbers[i]}
            numbers[i]=${numbers[j]}
            numbers[j]=$temp
        fi
    done
done
echo " sorted numbers are : " ${numbers[@]}



Create a script to add user in linux and password and check the username follows the regular standards.
 c43670, b57685,b56763,a34567
#!/bin/bash
USER=$1
echo $USER
EXISTING_USER=$(cat /etc/passwd | grep -i $USER | awk -F ":" '{print $1}')
 
if [[ $USER =~ ^[a-z]{1}[0-9]{5}$ ]]; then
    echo " Username is in required standards, create the if user didn't present on user"
    if [ "${USER}" == "${EXISTING_USER}" ]; then
        echo " User already present on the server"
    else
        echo "Let's add the user"
        useradd -m $USER --shell /bin/bash
        echo " User is created and create a password"
        SPEC=$(echo "@#$%^&*" | fold -w1 | shuf | head -1)
        PASSWORD="cOx${SPEC}${RANDOM}"
        echo "$USER:$PASSWORD" | chpasswd
        echo "The Temporary password is :" $PASSWORD
    fi
else
    echo " Please follow the organization standards"
fi
 