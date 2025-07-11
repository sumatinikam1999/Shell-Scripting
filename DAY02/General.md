### Can you restore a pem file? If not, then how you can access EC2

- No, we can't store PEM. It is not stored in AWS or recoverable
- However, we can ragain access b y: create new key pair, attach it to a temporary EC2 instance via rescue process and restore SSH access.

📘 Explain
PEM file(private keys) are never retrievable from AWS, after initial creation. Losing the PEM file means you cannot SSH into the EC2 instance using the existing key pair.
But by following below steps you can regain access:

#### ✅ Recovery Steps

* Create a new key pair
`aws ec2 create-key-pair --key-name --query 'KeyMaterial' --output text > new-key.pem`

* Stop the affected instances through AWS console or CLI
`aws ec2 stop-instances --instance-ids instance`

* Detach the root EBS volume from stopped instance
```
Go to ec2 -> volumes
find volume attached to instances(usually /dev/xvda)
Detach it
```

* Attach the EBS volume to temporary(working) instance
`Attach it as a secondary volume(ex. /dev/sdf)`

* SSH into the temporary instance
- Mount the volume
```
sudo mkdir /mnt/recovery
sudo mount /dev/xvda1 /mnt/recovery
```
- Edit the authorized_keys file on the broken instance volume
` sudo nano /mnt/recovery/home/ec2-user/.ssh/authorized_keys`
- Add public key from new key pair(new-key.pub)
---
* Detach the volume from rescue instance
```
unmount the volume
Detach it and re-attach to original instance as /dev/xvda
```

#### 🧠 Prevention Tips:
- Always backup pem file in secure location
- Create a secondary user with a different key for backup access
- Use EC2 instance connect for temporary browser-based access(only works for amazon ec2 linux 2+ and enabled roles)

```
Summary: You can restore a PEM file, but you can regain access by editing authorized_keys, on the root volume through a temporary rescue EC2 instance
```