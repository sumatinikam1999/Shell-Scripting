#Attach EBS volumes to running EC2 instance

create volume

**NOTE:**
* EBS volume should be in a same availability zone

### Steps
- By default you can't see the volume in the Linux server, we need to do some configurations.
**Step 1:** you can check volume available or not using below command
`lsblk: to see attached volumes`

```
[root@ip-172-31-12-240 ec2-user]# lsblk
NAME          MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
nvme0n1       259:0    0    8G  0 disk 
├─nvme0n1p1   259:1    0    8G  0 part /
├─nvme0n1p127 259:2    0    1M  0 part 
└─nvme0n1p128 259:3    0   10M  0 part /boot/efi
nvme1n1       259:4    0  100G  0 disk 
```
## in above output if you see part means it is available to linux server and if you see disk means it is available but not configured to linux server

Whenever we attach volume to linux server we need to configure that volume

To check filesystem available or not run below command
`sudo file -s /dev/nvme1n1`
[root@ip-172-31-12-240 ec2-user]# sudo file -s /dev/nvme1n1
/dev/nvme1n1: SGI XFS filesystem data (blksz 4096, inosz 512, v2 dirs)
[root@ip-172-31-12-240 ec2-user]# 

**Step 2:** create file system from volume(if filesystem not created create using below command but for this example file system is there so no need to use below command)
`sudo mkfs -t xfs /dev/nvme1n1`
`sudo yum install xfsprogs`

**Step 3:** create one directory(when we are mounting extra volume the we need to create one directory manually)
`sudo mkdir /data`

**Step 4:** mount created file system to the manually created directory
`sudo mount /dev/nvme1n1 /data`

**Step 5:** Now you need to send email to all the disks attached to EC2 instance
` df -hT|grep -vE 'tmpfs|vfat|Filesystem' `
-vE: it will exclude the lines containing above mentioned words

Need to use to loop lines one by one
[root@ip-172-31-12-240 ec2-user]# df -hT|grep -vE 'tmpfs|vfat|Filesystem'
/dev/nvme0n1p1   xfs       8.0G  1.6G  6.5G  20% /
/dev/nvme1n1     xfs       100G  747M  100G   1% /data

#### ** https://docs.aws.amazon.com/ebs/latest/userguide/ebs-using-volumes.html ** 

1. Determine whether there is a filesystem on volume or not. New volumes are raw block devices, and you must create a file system on them before you can mount and use them. Volumes that were created from snapshots likely have a file system on them already, if you create a new file system
on top of and existing system, the operation overwrites your data.

Use one for the following methods to determine whether there is a file system on the volume.
- Use file -s command to get information about specific device, such as its file system type. If the output shows simply data, then there is no file system on the device
```
[ec2-user ~]$ sudo file -s /dev/xvdf
/dev/xvdf: data
```
- If the device has a file system, the command shows information about the file system type, below output shows a root device with the XFS file system.
```
[ec2-user ~]$ sudo file -s /dev/xvda1
/dev/xvda1: SGI XFS filesystem data (blksz 4096, inosz 512, v2 dirs)
```
2. Use lsblk -f command [root@ip-172-31-12-240 ec2-user]# lsblk -f

NAME          FSTYPE FSVER LABEL UUID                                 FSAVAIL FSUSE% MOUNTPOINTS
nvme0n1                                                                              
├─nvme0n1p1   xfs          /     dccbc36d-6f9e-406d-bb7e-d12cbc962245    6.4G    19% /
├─nvme0n1p127                                                                        
└─nvme0n1p128 vfat   FAT16       3056-6B4C                               8.7M    13% /boot/efi
nvme1n1       xfs                a3001123-1d28-4814-9433-8716a3a9276f                
[root@ip-172-31-12-240 ec2-user]# to get information about all the devices attached to the instance.

For example, the following output shows it has two devices attached to the instance: nvme0n1, nvme1n1. The first column lists the devices and their partitions. The FSTYPE shows the file system type for each device. If the column is empty for a specific device, it means that the device does not have a file system. In this case, the device nvme1n1 and partition nvme0n1p1 on the device nvme0n1 both formatted using the XFS file system, while the partition nvme0n1p128 on the device nvme0n1 formatted using vfat file system and device nvme0n1 and partition nvme0n1p127 on device nvme0n1 does not have file system.

If the output from this command shows that there is no file system on this device then you have to create file system

3. If you discovered that there is a file systemon the device in the previous step, skip this step. If you have an empty volume , use the mkfs -t command to create a file system on the volume.

[ec2-user ~]$ sudo mkfs -t xfs /dev/xvdf

If you get an error that mkfs.xfs is not found use the following command to install the XFS tools and then repeat the previous command.

[ec2-user ~]$ sudo yum install xfsprogs

4. Use the mkdir command to create a mount point directory for the volume. The mount point is where the volume is located in the file system tree and where you can read and write files to after you mount the volume. The following example creates a directory named /data.

[ec2-user ~]$ sudo mkdir /data

5. Mount the volume or partition at the mount point directory you created in the previous step.
If the volume has no partitions use the following command and specify the device name to mount the entire volume.

[ec2-user ~]$ sudo mount /dev/xvdf /data

If the volume has partitions, use the following command and specify the partition name to mount a partition.

[ec2-user ~]$ sudo mount /dev/xvdf1 /data

6. Review the file permissions of your new volume mount to make sure that your users and applications can write to the volume.

7. The mount point is not automatically preserved after rebooting your instance. To automatically mount this EBS volume after reboot follow below steps.