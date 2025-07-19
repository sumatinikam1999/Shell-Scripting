#!/bin/bash
set -x
NAMES=$@
INSTANCE_TYPE=""
SECURITY_GROUP_ID=sg-07ee13d80d2ebe05a
DOMAIN_NAME=devopslearner.space
HOSTED_ZONE_ID=Z00027373O2OKHY987PPU
AMI_LINUX2=ami-0c2b8ca1dad447f8a
AMI_LINUX2023=ami-0150ccaf51ab55a51
PUB_KEY=$(cat ~/.ssh/new.pub)
#if mysql or mongodb instance_type should be t3.medium, for all others is is t2.micro

for i in $@
 do
# Check if instance with name $i already exists
  EXISTING_INSTANCE=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=$i" "Name=instance-state-name,Values=pending,running,stopping,stopped"  --query 'Reservations[*].Instances[*].InstanceId' --output text)

  if [ -n "$EXISTING_INSTANCE" ]; then
    echo "[SKIP] Instance '$i' already exists (ID: $EXISTING_INSTANCE)"
    continue
  fi
   if [[ $i == "mongodb" || $i == "mysql" ]]
   then
     INSTANCE_TYPE="t3.medium"
    else
     INSTANCE_TYPE="t2.micro"
   fi
   if [[ $i == *"mongodb"* || $i == *"web"* || $i == *"redis"* ]]
   then
     AMI_ID=$AMI_LINUX2
   else
     AMI_ID=$AMI_LINUX2023
   fi
echo "creating $i instance"

INSTANCE_ID=$(aws ec2 run-instances \
  --image-id $AMI_ID \
  --count 1 \
  --instance-type $INSTANCE_TYPE \
  --key-name new \
  --security-group-ids $SECURITY_GROUP_ID \
  --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$i}]" \
  --query 'Instances[0].InstanceId' \
  --output text)

echo "Waiting for $i instance ($INSTANCE_ID) to enter running state..."
aws ec2 wait instance-running --instance-ids $INSTANCE_ID

IP_ADDRESS=$(aws ec2 describe-instances \
  --instance-ids $INSTANCE_ID \
  --query "Reservations[0].Instances[0].PublicIpAddress" \
  --output text)

echo "creating $i instance: $IP_ADDRESS"

# Wait for SSH to be available
echo "Waiting for SSH to be available on $IP_ADDRESS..."
until ssh -o StrictHostKeyChecking=no -i ~/.ssh/new.pem ec2-user@$IP_ADDRESS 'echo "SSH is ready"' &>/dev/null; do
  sleep 5
done

# Create ansible user, add SSH key, and set passwordless sudo
ssh -o StrictHostKeyChecking=no -i ~/.ssh/new.pem ec2-user@$IP_ADDRESS <<EOF
chmod 400 /home/ansible/.ssh/new.pem

  # Create ansible user if not exists
  id ansible &>/dev/null || sudo useradd -m -s /bin/bash ansible

  # Create .ssh folder and authorized_keys
  sudo mkdir -p /home/ansible/.ssh
  echo "$PUB_KEY" | sudo tee /home/ansible/.ssh/authorized_keys

  # Set permissions
  sudo chown -R ansible:ansible /home/ansible/.ssh
  sudo chmod 700 /home/ansible/.ssh
  sudo chmod 600 /home/ansible/.ssh/authorized_keys

  # Add passwordless sudo for ansible user
  echo "ansible ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/ansible
EOF


  # Check if Route53 record already exists
  RECORD_EXISTS=$(aws route53 list-resource-record-sets \
    --hosted-zone-id "$HOSTED_ZONE_ID" \
    --query "ResourceRecordSets[?Name == '$i.$DOMAIN_NAME.']" --output json | grep -c '"Name"')

  if [ "$RECORD_EXISTS" -gt 0 ]; 
  then
  # If record exists → UPSERT (update or insert), else → CREATE.
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
    "Action": "UPSERT",
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

#improvements
#check instance already created or not
#check route 53 record already exists or not, if exist then update route 53 record
