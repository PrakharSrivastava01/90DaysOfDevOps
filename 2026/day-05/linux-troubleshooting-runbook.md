🛠️ Linux Troubleshooting Runbook

Day 05 – CPU, Memory and logs

🎯 Target Service / Process

Service: ssh
Reason for selection: Always running, system-critical, easy to observe logs and network behavior.


🧾 Environment Basics

1. OS & Kernel
  >> uname -a
Observation:
Linux kernel version and architecture identified.
 >> cat /etc/os-release
Observation:
Confirmed OS distribution and version.

📁 Filesystem Sanity Check

2. Create temp workspace
 >> mkdir /tmp/runbook-demo
 >> cp /etc/hosts /tmp/runbook-demo/hosts-copy
 >> ls -l /tmp/runbook-demo
 Observation:
Filesystem is writable, permissions look normal.

⚙️ Snapshot: CPU & Memory

3. System-wide view
 >> top
 Observation:
CPU usage is low; no abnormal memory consumption.

4. Process-level view
 >> ps -o pid,pcpu,pmem,comm -C sshd
 Observation:
sshd is consuming minimal CPU and memory.

5. Memory summary
 >> free -h
 Observation:
Sufficient free memory available, no swap pressure.

💽 Snapshot: Disk & IO
6. Disk Usage
 >> df -h
 Observation:
Root filesystem has sufficient free space.

7. Log directory size
 >> du -sh /var/log
 Observation:
Log directory size is reasonable; no runaway logs.

🌐 Snapshot: Network

8. Listening ports
 >> ss -tulpn | grep ssh
 Observation:
SSH is listening on port 22.

9. Connectivity Check
 >> curl -I localhost
 Observation:
Local network stack responding normally.

📜 Logs Reviewed

10. systemd logs
 >> journalctl -u ssh -n 50
 Observation:
No recent errors or failed authentication attempts.

11. Auth logs
 >> tail -n 50 /var/log/auth.log
 Observation:
Normal login activity, no suspicious entries.

** Quick Findings **

SSH service is running and stable

CPU, memory, disk, and network usage are within normal limits

No recent error patterns found in logs

System appears healthy at this time



🚨 If This Worsens (Next Steps)
 
1. Restart safely
 >> systemctl restart ssh (Monitor CPU & logs immediately after restart)

2. Increase visibility
 >> journalctl -u ssh -f (Capture live logs)

3. Deeper Inspection
 >> strace -p <PID> (Capture process activity)


                  ** Practiced a structured Linux troubleshooting drill by capturing CPU, memory, disk, network, and log evidence for a running service.
Built a concise runbook to document observations and define clear next steps for faster, repeatable incident response **




























