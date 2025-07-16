Ansible

Disadvantages of Shell Script
1. Shell script is homogenous
useradd roboshop -> centos
adduser roboshop -> ubuntu
one shell script can only work one particular distro
2. Every time we need to do validations
3. If you have 1000 servers, you need to login and run the script
4. imperative vs declarative

imperative -> little tough syntax and follow in sequence
declarative -> easy syntax, no need to sequence, you can write anywhere whatever you write you will get it simple syntax

1. ansible can query the server, it can understand what os it is, based on it can change the command
2. you no need to write validations
3. ansible can connect any number of servers, no need to login to the server 
4. declarative, no need of sequence and easy syntax

Before Ansible
--------------
puppet
chef

Pull
----
Configuration server -> chef server
Nodes
-----
1. First nodes will connect to server
2. Pull the configuration
3. Run the configuration

we need to schedule how frequently nodes should connect to server, like once in 30 mins

Push
----
Configuration server -> Ansible server
1. Server will directly push and run the configuration

Push vs Pull
-------------
Pull mechanism will have additional software
there will not be change in configuration every time, change in configuration is very rare wastage of data

Ansible uses SSH

ansible command line to ping
ansible -i 43.204.147.123, all -e ansible_user=ec2-user -e ansible_password=DevOps@321 -m ping

shell script -> keeping all the commands in a file with variables, conditions, loops etc
playbook -> keeping all the ansible collections(i.e command in linux) and run it
YAML -> Yet Another Markup Language
vim /tmp/hosts
