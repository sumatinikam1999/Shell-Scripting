#!/bin/bash

NAMES=("mongodb" "redis" "mysql" "rabbitmq" "catalogue" "user" "cart" "shopping" "payment" "dispatch" "web")
INSTANCE_TYPE=""
IMAGE_ID=ami-0a1235697f4afa8a4
SECURITY_GROUP_ID=sg-02b7456262aa1e272
DOMAIN_NAME=devopslearner.space
#if mysql or mongodb instance_type should be t3.medium, for all others is is t2.micro

for i in "${NAMES[@]}"
 do
   if [[ $i == "mongodb" || $i == "mysql" ]]
   then
     INSTANCE_TYPE="t3.medium"
    else
     INSTANCE_TYPE="t2.micro"
   fi
   echo "creating $i instance"
   IP_ADDRESS=$(aws ec2 run-instances --image-id $IMAGE_ID --count 1 --instance-type $INSTANCE_TYPE --key-name new --security-group-ids $SECURITY_GROUP_ID --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$i}]" --query 'Instances[0].PrivateIpAddress' --output text) 
   echo "creating $i instance: $IP_ADDRESS"

   aws route53 change-resource-record-sets --hosted-zone-id Z00027373O2OKHY987PPU --change-batch 
   "
   {
           "Comment": "Creating DNS record for $i"",
           "Changes": [{
           "Action": "CREATE",
                       "ResourceRecordSet": {
                                     "Name": "$i.$DOMAIN_NAME",
                                     "TTL": 300,
                                     "ResourceRecords": [{
                                          "Value": "$IP_ADDRESS"}]
                        }}]
    }
    "
done

#improvements
#check instance already created or not
#update route53 record
