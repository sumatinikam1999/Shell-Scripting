#### Linux Server is Slow due to High CPU Utilization. How you will fix it?

#### 📝Short Explanation 
## I would begin by identifying which processes are consuming more cpu using tools like `top`,`htop`,`pidstat`, then analyse it's due to mishaving of application , runway process or scheduled job. Based on findings I had take action either by killing process, adjusting resource limits or scaling the workload.##

#### 📘Detailed Explanation
✅**Step 1: Check the load average**
`uptime`

## Example:
` 13:58:49 up 3 days,  4:34,  2 users,  load average: 0.15, 0.08, 0.02`

## A load average consistently higher than the number of CPU cores indicates overutilization ##

✅**Step 2: Identify CPU Heavy Processes**
`top -i %CPU or htop`

## This shows which processes are consuming more CPU ##

✅**Step 3: Drill Down with `ps` or `pidstat`
`ps -eo pid,ppid,cmd,%cpu,%mem --sort=-%cpu | head` or
`pidstat -u 1 5`

## These gives detailed insights of CPU consumption over time

✅**Step 4: Investigate the Cause**
- Based on what you see ask:
  1. Is it a specific app?
  2. Is there a cron job or batch script is running?
  3. Is a service misconfigured and looping?
  4. Is it caused by a known bug?

✅**Step 5: Take Corrective Action**
- kill or restart runway process
`kill -9 <pid>`
`systemctl restart <service>`
- scale the application or move workloads
- Limit cpu usage using `nice`, `cpulimits` or `cgroups`
- Tune app performance(DB queries, memory leaks)

✅**Step 6: Check Logs**
```
journalctl -xe
tail -f /var/log/syslog
```
- Logs may reveal:
  - App crashes
  - High retry loops
  - Configuration issues

✅**Step 7: Implement Preventive Measures**
- Set CPU/memory limit in containerized apps
- Use monitoring tools like `Prometheus + Grafana`
- Configure alerts for high CPU
- Refactor long-running or expensive tasks

#### 🧠Examples
- A cron script looping due to a bad condition
- A Java app stuck in infinite recursion
- Docker containers running unbounded scraping jobs
- Antivirus or audit daemon consuming CPU after log floods

#### Summary: 
## Use `top`,`htop`,`ps`,`pidstat` to identify heavy processes. Fix the root cause and add monitoring to avoid similar issues in the future.