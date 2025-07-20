If that still fails (which it is right now), then manually copy the key:

On control node:
cat /home/ansible/.ssh/id_rsa.pub

sudo useradd ansible
sudo su - ansible
sudo vi /etc/sudoers
ansible ALL=(ALL) NOPASSWD: ALL
mkdir -p ~/.ssh
vi ~/.ssh/authorized_keys
# Paste the content of id_rsa.pub here
chmod 600 ~/.ssh/authorized_keys
chmod 700 ~/.ssh
exit

This means that the SSH host key of the remote server (web.devopslearner.space) has changed, but your Ansible control node (here, your root user on the EC2) still has the old key stored in /root/.ssh/known_hosts.

This usually happens if:

The server was re-created or its IP changed but domain remained same.

Someone is trying a man-in-the-middle attack (unlikely in your case, but SSH alerts for that)
## sudo ssh-keygen -R web.devopslearner.space

ansible_user=ec2-user

Now from control node (as ansible user):

bash
Copy
Edit
sudo -u ansible ssh ansible@web.devopslearner.space