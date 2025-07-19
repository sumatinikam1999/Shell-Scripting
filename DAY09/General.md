If that still fails (which it is right now), then manually copy the key:

On control node:
cat /home/ansible/.ssh/id_rsa.pub

sudo su - ansible
mkdir -p ~/.ssh
vi ~/.ssh/authorized_keys
# Paste the content of id_rsa.pub here
chmod 600 ~/.ssh/authorized_keys
chmod 700 ~/.ssh
exit


Now from control node (as ansible user):

bash
Copy
Edit
sudo -u ansible ssh ansible@web.devopslearner.space