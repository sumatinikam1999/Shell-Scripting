### Even though you can use the root user in Ansible to run Ad-Hoc commands and playbooks, it’s definitely not recommended and is not considered best practice due to the security risks that can arise by allowing root user ssh access.

## For this reason, it’s recommended that you create a dedicated Ansible user with sudo privileges (to all commands) on all hosts (control and managed hosts).

# Ansible uses SSH and Python to do all the work behind the scenes and so here are the four steps you would have to follow after installing Ansible:
1. Create a new user on all hosts.
`useradd -m ansible`
`passwd ansible`
2. Grant sudo privileges to the new user on all nodes.
```
vi /etc/sudoers
ansible ALL=(ALL) NOPASSWD: ALL
```
3. Temporarily allow password authentication on managed node
```
sudo vi /etc/ssh/sshd_config
PasswordAuthentication yes
sudo systemctl restart sshd
```
4. Generate SSH keys for the new user on the control node.
```
sudo su - ansible 
ssh-keygen
```
5. Copy the SSH public key to the managed nodes from control node
`ssh-copy-id ansible@ip`

#### An Ansible inventory file is a basically a file that contains a list of servers, group of servers, or ip addresses that references that hosts that you want to be managed by Ansible (managed nodes).
#### The /etc/ansible/hosts is the default inventory file.

## **Control node**
## create directory(don't modify default directory /etc/ansible/hosts)
## /home/ansible/plays
## create a inventory file myhosts
## ansible all -i myhosts --list-hosts

## The -i option was used to specify the myhosts inventory file. If you omit the -i option, Ansible will look for hosts in the /etc/ansible/hosts inventory file instead.

#### creating host group
```
[ansible@ip-172-31-5-31 plays]$ cat myhosts 

[dev]
43.204.147.123

[prod]
43.204.147.123
[ansible@ip-172-31-5-31 plays]$ 

[ansible@ip-172-31-5-31 plays]$ ansible prod -i myhosts --list-hosts
  hosts (1):
    43.204.147.123
[ansible@ip-172-31-5-31 plays]$ 
```

## There are two default groups in Ansible:
1. all → contains all the hosts in the inventory
2. ungrouped → contains all the hosts that are not a member of any group
(aside from all).

#### creating host ungrouped
```
[ansible@ip-172-31-5-31 plays]$ cat myhosts 
43.204.147.123

[dev]
43.204.147.123

[prod]
43.204.147.123
[ansible@ip-172-31-5-31 plays]$ ansible ungrouped -i myhosts --list-hosts
[WARNING]: No hosts matched, nothing to do
  hosts (1):
    43.204.147.123
[ansible@ip-172-31-5-31 plays]$ 
```

## You can also create a group (parent) that contains subgroups (children).
```
[ansible@ip-172-31-5-31 plays]$ cat myhosts 

[dev]
43.204.147.123

[prod]
43.204.147.123

[development:children]
dev
prod

[production:children]
prod

[ansible@ip-172-31-5-31 plays]$ ansible development -i myhosts --list-hosts
  hosts (1):
    43.204.147.123
[ansible@ip-172-31-5-31 plays]$ 
```

#### Configuring Ansible
