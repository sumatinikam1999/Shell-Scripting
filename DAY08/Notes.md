# ansible -i inventory nginx --list-hosts

# ansible -i inventory db --list-hosts

# ansible -i inventory ungrouped --list-hosts

# ansible -i inventory all --list-hosts

# ansible -i inventory nginx -m ping -u ec2-user --ask-pass

# ansible -i inventory nginx -m ping -u ansible_user=ec2-user ansible_password=DevOps@321

# Install nginx
```
yum install nginx -y -> command
ansible -> module/collection
command-name <option><input>
cp <source><destination>
```

# module/collection name <paramerters>

# ansible -i inventory nginx -e ansible_user=ec2-user -e ansible_password=DevOps@321

# ansible -i inventory nginx -b -e ansible_user=ec2-user -e ansible_password=DevOps@321 -m ansible.builtin.yum -a "name=nginx state=installed"
# -b -> become root

# ansible -i inventory nginx -b -e ansible_user=ec2-user -e ansible_password=DevOps@321 -m ansible.builtin.systemd -a "name=nginx state=started"
# sudo systemctl start nginx

# installed roboshop manually through commands one by one
# placed all the commands in a file i.e shell script and ran at once -> reuse

# playbook-> keep all ansible modules/collections in a YAML file and run that file

# yaml syntax
# yet another markup language
# HTML -> hyper text markup language

# XML -> extensible markup language

# bank -> deposit money

# PERSON-1
--------
# name
# ac no
# date
# amount
# branch
# denomination

# PERSON-2
--------
# ac no
# name
# date
# denomination
# date

# template/form
-------------
# eash for cashier to find the fields

# Name
# Ac No
# Amount
# Date Branch

# DTO -> Data Transfer Objects
----------------------------
# signup

# you need to take user info and send user component in backend

# key -> value
# nested 
# key
#   key -> value


# Playbook -> YAML

# ansible-playbook -i inventory -e ansible_user=ec2-user -e ansible_pass playbook.yaml
