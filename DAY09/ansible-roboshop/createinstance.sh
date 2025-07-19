#!/bin/bash
set -x
NAMES=$@
INSTANCE_TYPE=""
SECURITY_GROUP_ID=sg-07ee13d80d2ebe05a
DOMAIN_NAME=devopslearner.space
HOSTED_ZONE_ID=Z00027373O2OKHY987PPU
AMI_LINUX2=ami-0c101f26f147fa7fd          # ✅ Valid Amazon Linux 2 for us-east-1
AMI_LINUX2023=ami-0150ccaf51ab55a51       # Amazon Linux 2023

for i in $@
do
  # Check if instance with name $i already exists
  EXISTING_INSTANCE=$(aws ec2 describe-instances \
    --filters "Name=tag:Name,Values=$i" "Name=instance-state-name,Values=pending,running,stopping,stopped" \
    --query 'Reservations[*].Instances[*].InstanceId' --output text)

  if [ -n "$EXISTING_INSTANCE" ]; then
    echo "[SKIP] Instance '$i' already exists (ID: $EXISTING_INSTANCE)"
    continue
  fi

  if [[ $i == "mongodb" || $i == "mysql" ]]; then
    INSTANCE_TYPE="t3.medium"
  else
    INSTANCE_TYPE="t2.micro"
  fi

  if [[ $i == *"mongodb"* || $i == *"web"* || $i == *"redis"* ]]; then
    AMI_ID=$AMI_LINUX2
  else
    AMI_ID=$AMI_LINUX2023
  fi

  echo "Creating $i instance..."

  INSTANCE_ID=$(aws ec2 run-instances \
    --image-id $AMI_ID \
    --count 1 \
    --instance-type $INSTANCE_TYPE \
    --key-name new \
    --security-group-ids $SECURITY_GROUP_ID \
    --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$i}]" \
    --query 'Instances[0].InstanceId' --output text)

  if [ -z "$INSTANCE_ID" ]; then
    echo "[ERROR] Failed to launch $i instance."
    exit 1
  fi

  echo "Waiting for $i ($INSTANCE_ID) to enter running state..."
  aws ec2 wait instance-running --instance-ids $INSTANCE_ID

  IP_ADDRESS=$(aws ec2 describe-instances \
    --instance-ids $INSTANCE_ID \
    --query "Reservations[0].Instances[0].PublicIpAddress" \
    --output text)

  if [ -z "$IP_ADDRESS" ] || [ "$IP_ADDRESS" == "None" ]; then
    echo "[ERROR] Could not retrieve IP for $i"
    exit 1
  fi

  echo "Creating $i instance: $IP_ADDRESS"

  # Check if Route53 record already exists
  RECORD_EXISTS=$(aws route53 list-resource-record-sets \
    --hosted-zone-id "$HOSTED_ZONE_ID" \
    --query "ResourceRecordSets[?Name == '$i.$DOMAIN_NAME.']" --output json | grep -c '"Name"')

  if [ "$RECORD_EXISTS" -gt 0 ]; then
    ACTION="UPSERT"
    echo "[INFO] DNS record exists. Updating Route53 record for $i.$DOMAIN_NAME"
  else
    ACTION="CREATE"
    echo "[INFO] Creating new Route53 record for $i.$DOMAIN_NAME"
  fi

  CHANGE_BATCH=$(cat <<EOF
{
  "Comment": "Creating DNS record for $i",
  "Changes": [{
    "Action": "$ACTION",
    "ResourceRecordSet": {
      "Name": "$i.$DOMAIN_NAME",
      "Type": "A",
      "TTL": 300,
      "ResourceRecords": [{"Value": "$IP_ADDRESS"}]
    }
  }]
}
EOF
)

  aws route53 change-resource-record-sets --hosted-zone-id $HOSTED_ZONE_ID --change-batch "$CHANGE_BATCH"

done
