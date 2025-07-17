ansible -i inventory nginx --list-hosts

ansible -i inventory db --list-hosts

ansible -i inventory ungrouped --list-hosts

ansible -i inventory all --list-hosts

ansible -i inventory nginx -m ping -u ec2-user --ask-pass

ansible -i inventory nginx -m ping -u ansible_user=ec2-user ansible_password=DevOps@321