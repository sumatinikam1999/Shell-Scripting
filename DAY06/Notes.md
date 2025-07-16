Created instances automatically
Create route53 records
aws command line

Authentication - username and password
Autherization - but you don't have access to every project

AWS has 1000's of services, if you create user he can't get admin access, you will give limited access

i.e permission -> you will give certain permissions

User 
Group
Permissions

Roles -> for non humans, you should attach this role to aws services so that they can't create resources
AWS services also should have certain permissions, so that they can't create resources


aws command line to create ec2 instance
aws ec2 run-instances --image-id ami-0a1235697f4afa8a4 --count 1 --instance-type t2.micro --key-name new --security-group-ids sg-02b7456262aa1e272 --subnet-id subnet-033d688be356e8166 | jq -r '.Instances[0].PrivateIpAddress'

create all the instances mongodb redis mysql rabbitmq catalogue user cart shopping payment dispatch web and update route53 record