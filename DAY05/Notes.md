df -hT | grep tmpfs
df -hT | grep -v tmpfs -> it will act opposite of grep it will except lines with tmpfs

df -hT | grep -vE 'tmpfs|Filesystem' -> it don't want tmpfs and filesystem