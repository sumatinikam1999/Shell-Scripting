### /var is almost 90% full. What will be your next steps?
`/var commonly used for logs, spools, caches and runtime data - so issues here can break system processes or fill up disks silently`

## ✅**Answer**
- My first step is to identify what's consuming the space inside /var. Then I will clean    up unnecessary files like rotated logs, caches or orphaned packages </br>

## 📘**Detailed Explanation**
✅**Step 1:**
- Inspect disk usage under /var
`sudo du -sh /var/* | sort -hr | head -10`
This will show which directories inside /var consuming more space - usually it's /var/logs, /var/cache, or /var/lib/docker </br>

✅**Step 2:**
- Clean Log Files
If `/var/log` consuming more space:
```
sudo journalctl --vaccum-size=200M
sudo rm -rf /var/log/*.gz /var/log/*.[0-9]
```
or
`sudo truncate -s 0 /var/log/syslog`

✅**Step 3:**
- Clear Package Cache
If using apt or yum, clear the package manager cache:
`sudo yum clean all` #RHEL/CentOS

✅**Step 4:**
- Check docker artifacts
If the server runs containers:
```
docker system df        #See what's taking space
docker system prune -a  #Remove unused containers/images
```
⚠️ **Prune removes unused images/volumes user carefully on production system** </br>

✅**Step 5:**
- Consider Moving or Archiving Data:
If data in `/var` needed but rarely accessed.
```
- Archieve old logs to `/home` or S3
- Use `logrotate` to compress and limit logs
`sudo nano /etc/logrotate.conf`

✅**Step 6:**
- Set Up Alerts & Monitoring:
- Instal `ncdu`, 'duf`, or setup Prometheus or Grafana alerts for disk usage thresholds
- Automcate cleanup with cron or systemd timers if appropriate

🧠**Why /var Fills Up**
- Verbose logging(failed cron jobs, app debug logs)
- Docker images/layers
- Orphaned cache files
- Emails spools or crash dumps 


`Summary: Quickly spin, clean and automate monitoring. Ensure critical services like journald, docker and package managers are not starved of space.`
