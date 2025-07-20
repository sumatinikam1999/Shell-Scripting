seeing this error while running `ansible-playbook -i inventory web.yaml`
[ansible@ip-172-31-5-31 ansible-roboshop]$ ansible-playbook -i inventory mongodb.yaml 

PLAY [Install MongoDB component] *************************************************************************************************************************************************************

TASK [Gathering Facts] ***********************************************************************************************************************************************************************
fatal: [mongodb.yaml.devopslearner.space]: UNREACHABLE! => {"changed": false, "msg": "Failed to connect to the host via ssh: ansible@mongodb.yaml.devopslearner.space: Permission denied (publickey,gssapi-keyex,gssapi-with-mic).", "unreachable": true}

PLAY RECAP ***********************************************************************************************************************************************************************************
mongodb.yaml.devopslearner.space : ok=0    changed=0    unreachable=1    failed=0    skipped=0    rescued=0    ignored=0   

[ansible@ip-172-31-5-31 ansible-roboshop]$ 


faced below issue when mongodb server name is different in route53 and inventory file
fatal: [web.devopslearner.space]: UNREACHABLE! => {"changed": false, "msg": "Failed to connect to the host via ssh: ssh: Could not resolve hostname web.devopslearner.space: Name or service not known", "unreachable": true}
If that still fails (which it is right now), then manually copy the key:


when trying to ssh managed node from control node
[ansible@ip-172-31-5-31 ~]$ ssh ansible@mongodb.yaml.devopslearner.space
The authenticity of host 'mongodb.yaml.devopslearner.space (52.201.231.144)' can't be established.
ED25519 key fingerprint is SHA256:h3tGBgLHG+ju+J45EY+F6hNgHAwelYiMfuIHxeLnuJk.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added 'mongodb.yaml.devopslearner.space' (ED25519) to the list of known hosts.
ansible@mongodb.yaml.devopslearner.space: Permission denied (publickey,gssapi-keyex,gssapi-with-mic).


missing `echo "ansible ALL=(ALL) NOPASSWD: ALL" | sudo tee -a /etc/sudoers` to faced below error
[ansible@ip-172-31-5-31 ansible-roboshop]$ ansible-playbook -i inventory mongodb.yaml 

PLAY [Install MongoDB component] *************************************************************************************************************************************************************

TASK [Gathering Facts] ***********************************************************************************************************************************************************************
fatal: [mongodb.yaml.devopslearner.space]: FAILED! => {"msg": "Missing sudo password"}

PLAY RECAP ***********************************************************************************************************************************************************************************
mongodb.yaml.devopslearner.space : ok=0    changed=0    unreachable=0    failed=1    skipped=0    rescued=0    ignored=0   

[ansible@ip-172-31-5-31 ansible-roboshop]$ 
-----

[ansible@ip-172-31-5-31 ansible-roboshop]$ ansible-playbook -i inventory mongodb.yaml  

PLAY [Install MongoDB component] *************************************************************************************************************************************************************

TASK [Gathering Facts] ***********************************************************************************************************************************************************************
fatal: [mongodb.yaml.devopslearner.space]: UNREACHABLE! => {"changed": false, "msg": "Failed to connect to the host via ssh: @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\r\n@    WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!     @\r\n@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\r\nIT IS POSSIBLE THAT SOMEONE IS DOING SOMETHING NASTY!\r\nSomeone could be eavesdropping on you right now (man-in-the-middle attack)!\r\nIt is also possible that a host key has just been changed.\r\nThe fingerprint for the ED25519 key sent by the remote host is\nSHA256:n/rILNiQVVYfz6CAx1bsJzUzlCDd7/hExpaRmzgT0XI.\r\nPlease contact your system administrator.\r\nAdd correct host key in /home/ansible/.ssh/known_hosts to get rid of this message.\r\nOffending ECDSA key in /home/ansible/.ssh/known_hosts:11\r\nHost key for mongodb.yaml.devopslearner.space has changed and you have requested strict checking.\r\nHost key verification failed.", "unreachable": true}

PLAY RECAP ***********************************************************************************************************************************************************************************
mongodb.yaml.devopslearner.space : ok=0    changed=0    unreachable=1    failed=0    skipped=0    rescued=0    ignored=0   

[ansible@ip-172-31-5-31 ansible-roboshop]$ 

## You need to remove the offending old SSH key from the known_hosts file for this particular domain.

Run this command from the ansible user's home:

ssh-keygen -R mongodb.yaml.devopslearner.space
This will remove the old fingerprint from /home/ansible/.ssh/known_hosts.

Then, try manually connecting to the server once:



----
On control node:
cat /home/ansible/.ssh/id_rsa.pub


managed node
sudo useradd ansible
echo "ansible ALL=(ALL) NOPASSWD: ALL" | sudo tee -a /etc/sudoers

# sudo vi /etc/sudoers
# ansible ALL=(ALL) NOPASSWD: ALL


sudo su -
mkdir -p /home/ansible/.ssh
chmod 700 /home/ansible/.ssh
vi /home/ansible/.ssh/authorized_keys
chmod 600 /home/ansible/.ssh/authorized_keys
chown -R ansible:ansible /home/ansible/.ssh


control node
[ansible@ip-172-31-5-31 ~]$ ssh ansible@web.yaml.devopslearner.space
-----

mongodb-yaml
unable to copy public key in managed node
sudo mkdir -p /home/ansible/.ssh
sudo touch /home/ansible/.ssh/authorized_keys
sudo chown -R ansible:ansible /home/ansible/.ssh
sudo chmod 700 /home/ansible/.ssh
sudo chmod 600 /home/ansible/.ssh/authorized_keys

sudo vi /home/ansible/.ssh/authorized_keys