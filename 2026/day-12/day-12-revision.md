SECTION 1: MINDSET & PLAN REVISIT
Original Day 01 Goals
Primary Objectives:

Master Linux fundamentals for DevOps work
Build confidence with command line
Understand system administration basics
Prepare for production server management
Develop troubleshooting skills

Progress After 11 Days
✅ Achieved:

Comfortable with essential navigation commands (cd, ls, pwd, cat)
File operations mastered (create, read, edit, copy, move)
Permission management confident (chmod numeric and symbolic)
Ownership changes comfortable (chown, chgrp)
User/group administration basics solid
Process viewing and monitoring understood

🎯 In Progress:

Service management (limited systemd access in practice env)
Log analysis and troubleshooting
Complex permission scenarios
Multi-step incident response

📌 Not Yet Started:

Network troubleshooting
Package management (apt/yum)
Shell scripting
Automation and CI/CD integration

Plan Adjustments
What's Working:
✓ Daily hands-on practice is highly effective
✓ Documentation helps retention significantly
✓ Structured challenges build skills systematically
✓ Combining theory + practice is the right approach
Tweaks Needed:
→ Need more practice in full systemd environments
→ Should add weekly "incident simulation" exercises
→ Want to start building personal runbook/playbook
→ Could benefit from timing myself (speed building)
→ Should practice explaining concepts (teaching = learning)
Revised Focus for Next Phase:

Continue systematic daily learning (foundation is solid)
Add realistic incident scenarios weekly
Build personal cheat sheet/runbook
Practice in production-like environments
Start combining multiple skills in complex tasks


🔧 SECTION 2: PROCESSES & SERVICES
Command 1: Process Monitoring by Memory Usage
Command Executed:
bashps aux --sort=-%mem | head -10
Output:
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root         1  1.5  0.2 352644 18900 ?        Ssl  12:27   0:00 /process_api
root        20  100  0.0  15996  7528 ?        R    12:27   0:00 ps aux
root        21  100  0.0  10756  4428 ?        S    12:27   0:00 head -10
What I Observed Today:

Main daemon (PID 1) using ~19MB resident memory (RSS)
Virtual memory (VSZ) much larger than physical (RSS) - this is normal
Short-lived commands show minimal memory footprint
System overall has very low memory pressure
Process states visible: Ssl (sleeping daemon), R (running), S (sleeping)

Key Learning:

RSS (Resident Set Size) = actual physical memory used
VSZ (Virtual Size) = total virtual memory (includes swapped/shared)
Focus on RSS for real memory usage
%MEM shows percentage of total system memory
Sorting by memory helps identify leaks quickly


Command 2: System Snapshot with Top
Command Executed:
bashtop -b -n 1 | head -20
Output:
top - 12:28:15 up 0 min,  0 user,  load average: 0.00, 0.00, 0.00
Tasks:   4 total,   1 running,   3 sleeping,   0 stopped,   0 zombie
%Cpu(s):   0.0 us,   0.0 sy,   0.0 ni, 100.0 id,   0.0 wa,   0.0 hi,   0.0 si
MiB Mem :   9216.0 total,   9200.2 free,     15.8 used,      8.6 buff/cache
MiB Swap:      0.0 total,      0.0 free,      0.0 used.   9200.2 avail Mem

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
    1 root      20   0  352644  19204      0 S   9.1   0.2   0:00.60 process_api
What I Observed Today:

Load Average: 0.00, 0.00, 0.00 (1, 5, 15 min) - completely idle system
Tasks: 4 total, 1 running, 3 sleeping, 0 zombies (healthy!)
CPU: 100% idle (id), 0% wait (wa) - no I/O bottlenecks
Memory: 9216 MB total, 9200 MB free (99%+ available)
Swap: Not in use (good - swap usage indicates memory pressure)
Top Process: Using only 9.1% CPU and 0.2% memory

Key Learning:

Load average < 1.0 = system not stressed (rule: load < CPU cores)
Zero zombie processes = clean process termination
"wa" (wait) metric critical - high wait = disk I/O problems
Idle CPU is good for servers (ready for workload spikes)
This snapshot represents a healthy, unloaded system
In production, watch for: load spikes, low free memory, high wait


Service Status Check Attempt
Command Attempted:
bashsystemctl status
systemctl list-units --type=service --state=running
Result:
System has not been booted with systemd as init system (PID 1). Can't operate.
Failed to connect to bus: Host is down
What I Observed:

Practice environment doesn't use systemd
PID 1 is process_api, not systemd init
Container/specialized environment with alternative init
systemctl commands unavailable

What I Would Check in Production:
bash# Check specific service
systemctl status nginx.service

# List all running services
systemctl list-units --type=service --state=running

# Check for failed services
systemctl --failed

# View service logs
journalctl -u nginx.service -n 50

# Follow logs in real-time
journalctl -u nginx.service -f
Key Learning:

Not all Linux systems use systemd (containers, embedded systems)
Always verify init system first (check PID 1: ps -p 1)
Alternative tools: service, /etc/init.d/, supervisorctl
In production, systemctl is standard for service management


📁 SECTION 3: FILE SKILLS PRACTICE
Operation 1: Append to File
Commands:
bashecho "Initial line" > practice.txt
cat practice.txt

echo "Appended line 1" >> practice.txt
echo "Appended line 2" >> practice.txt
cat practice.txt
Result:
Initial line
Appended line 1
Appended line 2
Checkpoint: ✅ Append operator (>>) works correctly, preserves existing content

Operation 2: Directory Creation
Commands:
bashmkdir -p app/src app/docs app/tests
ls -R app/
Result:
app/:
docs  src  tests

app/docs:
app/src:
app/tests:
Checkpoint: ✅ Nested directory creation successful with -p flag

Operation 3: Permission Management
Commands:
bashtouch script.sh
chmod 755 script.sh
ls -l script.sh

touch config.conf
chmod 640 config.conf
ls -l config.conf
Result:
-rwxr-xr-x 1 root root 0 Feb  4 12:28 script.sh
-rw-r----- 1 root root 0 Feb  4 12:28 config.conf
Checkpoint: ✅ Permissions set correctly:

755 = rwxr-xr-x (executable, public read)
640 = rw-r----- (readable by group, private to others)


Operation 4: Copy Files
Commands:
bashcp practice.txt practice-backup.txt
ls -l practice*
Result:
-rw-r--r-- 1 root root 45 Feb  4 12:28 practice-backup.txt
-rw-r--r-- 1 root root 45 Feb  4 12:28 practice.txt
Checkpoint: ✅ File copied successfully, both files identical size

Operation 5: Ownership Change
Commands:
bashtouch devops-file.txt
ls -l devops-file.txt

chown devuser:devops devops-file.txt
ls -l devops-file.txt
Result:
# Before:
-rw-r--r-- 1 root root 0 Feb  4 12:28 devops-file.txt

# After:
-rw-r--r-- 1 devuser devops 0 Feb  4 12:28 devops-file.txt
Checkpoint: ✅ Ownership changed correctly (owner: root→devuser, group: root→devops)

🛡️ SECTION 4: CHEAT SHEET - TOP 5 INCIDENT COMMANDS
1. ps aux --sort=-%cpu | head
Why First: Immediately identifies CPU hogs
Use Case: High load alerts, sluggish system
What to Look For: Processes using >50% CPU sustainably
Example: Server load is 8.0 on 4-core system - find the culprit
2. top (or htop if available)
Why First: Real-time system health overview
Use Case: Initial triage for any performance issue
What to Look For: Load avg, memory free, swap usage, CPU wait time
Example: Quick sanity check when alert fires
3. df -h
Why First: Disk space is #1 cause of mysterious failures
Use Case: Service won't start, write errors, general weirdness
What to Look For: Any filesystem at >90% capacity
Example: "No space left on device" - check this FIRST
4. systemctl status <service> or journalctl -u <service> -n 50
Why First: Direct service health check
Use Case: Service down alerts, post-deployment checks
What to Look For: Active/inactive state, recent errors in logs
Example: nginx down - check status and logs immediately
5. tail -f /var/log/syslog (or relevant service log)
Why First: See errors as they happen
Use Case: Intermittent issues, debugging running problems
What to Look For: Error patterns, stack traces, timestamp correlation
Example: App crashing repeatedly - watch logs during crash
Honorable Mentions (Next 5)

free -h - Quick memory check
netstat -tulpn or ss -tulpn - Check listening ports/connections
last - Who logged in (security incidents)
grep -i error /var/log/* - Search all logs for errors
ls -lh /var/log/ | tail - Find recent log files


👥 SECTION 5: USER/GROUP SCENARIO
Scenario: Create DevOps User with Proper File Access
Step 1: Create User
bashuseradd -m devuser
✅ User created with home directory
Step 2: Create Group
bashgroupadd devops
✅ Group created
Step 3: Verify User Creation
bashid devuser
Output:
uid=1006(devuser) gid=1010(devuser) groups=1010(devuser)
✅ Verified: UID=1006, primary group created automatically
Step 4: Create File with Ownership
bashtouch devops-file.txt
ls -l devops-file.txt
Initial:
-rw-r--r-- 1 root root 0 Feb  4 12:28 devops-file.txt
Step 5: Change Ownership
bashchown devuser:devops devops-file.txt
ls -l devops-file.txt
Final:
-rw-r--r-- 1 devuser devops 0 Feb  4 12:28 devops-file.txt
Verification Checklist:

 User exists (verified with id)
 Group exists (verified in ownership)
 File owner changed correctly
 File group changed correctly
 Permissions maintained (644)

Key Takeaway: Always verify with id username and ls -l filename after changes

📝 MINI SELF-CHECK ANSWERS
Question 1: Which 3 commands save you the most time right now, and why?
1. ls -lh
Why: Single command shows permissions, ownership, size, and timestamp
Time Saved: Eliminates need for separate permission/owner checks
Example: Instead of running ls, then stat, then checking permissions separately, one command gives complete file info
2. ps aux --sort=-%cpu (or --sort=-%mem)
Why: Instantly identifies problem processes without manual scanning
Time Saved: No need to scroll through hundreds of processes or use top interactively
Example: During high CPU alert, immediately see top offender in first line
3. chown user:group file
Why: Changes both owner and group in one command instead of two
Time Saved: Eliminates separate chown and chgrp calls
Example: Setting up deployed application - chown -R webapp:www-data /var/www/app sets everything at once

Question 2: How do you check if a service is healthy? List exact 2-3 commands you'd run first.
Command 1: Check Service Status
bashsystemctl status nginx.service
What to Look For:

Active: active (running) ✅ vs inactive (dead) ❌
Main PID present and not changing
Recent log entries show normal operation
No error messages in status output

Command 2: View Recent Logs
bashjournalctl -u nginx.service -n 50 --no-pager
What to Look For:

No ERROR or CRITICAL level messages
Normal startup/connection messages
Timestamps are recent (service not stalled)
No repeated restart attempts

Command 3 (if needed): Check Process Existence
bashps aux | grep nginx
# or
pgrep -a nginx
What to Look For:

Master and worker processes both running
Process not consuming excessive CPU/memory
Multiple workers (if configured)

Quick Health Check Pattern:

systemctl status - Is it running?
journalctl -u - Are there errors?
curl localhost or actual functionality test - Does it work?


Question 3: How do you safely change ownership and permissions without breaking access? Give one example command.
Principle: Always verify current state, make targeted changes, verify after
Step-by-Step Safe Process:
1. Check Current State
bashls -l /var/www/myapp/config.php
Before: -rw-r--r-- 1 root root 1234 Feb 4 config.php
2. Make Targeted Change
bashchown webapp:www-data /var/www/myapp/config.php
chmod 640 /var/www/myapp/config.php
3. Verify After Change
bashls -l /var/www/myapp/config.php
After: -rw-r----- 1 webapp www-data 1234 Feb 4 config.php
Why This is Safe:

Owner (webapp) can read/write the config
Group (www-data) can read (webserver needs to read config)
Others cannot access (security - config often has passwords)
Application process running as webapp user can modify config
Web server running as www-data can read config

Example Command for Directory (Production Deployment):
bash# Safe ownership change for entire app
chown -R webapp:www-data /var/www/myapp/

# Set safe permissions
find /var/www/myapp/ -type f -exec chmod 640 {} \;  # Files: rw-r-----
find /var/www/myapp/ -type d -exec chmod 750 {} \;  # Dirs: rwxr-x---

# Verify critical files
ls -l /var/www/myapp/config.php
ls -ld /var/www/myapp/

Safety Checklist:

 Know who needs access (user, group, others)
 Test on single file first, then use -R
 Verify with ls -l after each change
 Keep executable bit on directories (needed for access)
 Don't give write to others unless absolutely necessary
 Consider using 750/640 instead of 777/666


Question 4: What will you focus on improving in the next 3 days?
Day 13: Network Troubleshooting

Practice: netstat, ss, ping, traceroute, dig, nslookup
Learn to diagnose connectivity issues
Understand ports and listening services
Check firewall rules (iptables/ufw basics)

Day 14: Log Analysis & Debugging

Master grep, awk, sed for log parsing
Practice journalctl with various filters
Learn to correlate events across log files
Build patterns for common error identification

Day 15: Complex Scenarios & Speed Drills

Combine multiple skills in realistic incidents
Time-based challenges (solve in under 5 minutes)
Build personal incident response runbook
Practice explaining solutions (teaching = learning)

Specific Skills to Strengthen:

Speed - Muscle memory for common commands (reduce thinking time)
Patterns - Recognize common issues faster (high CPU, disk full, service down)
Systemd - Practice in full systemd environment
Scripting - Automate repetitive tasks

Metrics for Improvement:

Can I diagnose and fix common issue in < 5 minutes?
Can I explain what I'm doing without looking at notes?
Can I handle 3 simultaneous issues without panic?
Do I have a go-to command for each scenario?


📊 KEY TAKEAWAYS FROM REVISION
Skills That Are Solid ✅

File operations (create, edit, copy, move, delete)
Permission management (chmod numeric and symbolic)
Ownership changes (chown, chgrp)
Basic process monitoring (ps, top)
User/group creation and verification
Directory navigation and structure creation

Skills That Need More Practice 🎯

systemd service management (need full environment)
journalctl log filtering and analysis
Complex permission scenarios (ACLs, special bits)
Speed of execution under pressure
Combining multiple commands in pipelines
Scripting common tasks
🎓 REFLECTION: WHAT'S CHANGED SINCE DAY 1
Mindset Shifts
Before:

Intimidated by command line
Afraid to break things
Relied heavily on GUI tools
Needed to Google every command

Now:

Comfortable experimenting in terminal
Understand what commands do before running
Prefer CLI for many tasks (faster!)
Have mental models for common operations

Practical Impact
Week 1 (Days 1-7): Basic survival

Could navigate directories
Understood file permissions conceptually
Knew commands existed but needed reference

Week 2 (Days 8-12): Building confidence

Can solve real problems
Understand why commands work
Making connections between concepts
Starting to think in "Linux patterns"

What Success Looks Like Now
Can Do Without Hesitation:

Check system health quickly
Modify file permissions correctly
Create users and set ownership
Find processes and understand states
Navigate and manipulate files

Can Do With Reference:

Complex permission scenarios
Service management with systemd
Log analysis and correlation
Network troubleshooting

Need More Practice:

Speed under pressure
Complex multi-step incidents
Scripting and automation
Advanced tools and flags


📋 RETENTION CHECKLIST
Commands I Can Execute From Memory

 ls -lh - detailed file listing
 cd /path/to/dir - change directory
 pwd - print working directory
 cat filename - view file contents
 echo "text" >> file - append to file
 chmod 755 file - change permissions
 chown user:group file - change ownership
 ps aux - view all processes
 top - interactive process viewer
 df -h - disk space usage
 mkdir -p path/to/dir - create directories
 cp source dest - copy files

Concepts I Understand Clearly

 File permissions (rwx, 755, 644)
 Ownership (user:group)
 Process states (running, sleeping, zombie)
 Memory metrics (RSS, VSZ, %MEM)
 CPU metrics (%CPU, load average)
 Permission hierarchy (owner > group > others)
 File system navigation
 User and group relationships

Areas Still Developing

 systemd service management (need environment access)
 journalctl advanced filtering
 Log correlation across services
 Network diagnostics
 Performance tuning
 Shell scripting


🎯 ACTION ITEMS FOR NEXT 3 DAYS
Immediate (Today)

 Complete this revision document
 Practice all 5 incident response commands
 Verify user/group operations
 Review notes from days where I felt shaky

Tomorrow (Day 13)

 Network troubleshooting commands (netstat, ss, ping)
 Practice in systemd environment if possible
 Time myself on common tasks
 Build first version of personal runbook

Day After (Day 14)

 Log analysis deep dive
 Practice grep/awk/sed patterns
 Simulate 2-3 realistic incidents
 Document patterns I notice

Day 15

 Speed drills - common tasks under time pressure
 Complex multi-step scenarios
 Review all notes and identify gaps
 Plan next learning phase


💡 INSIGHTS & OBSERVATIONS
What Made Learning Stick

Hands-on practice immediately after theory
Documentation of what I observed (not just commands)
Real scenarios instead of abstract examples
Repetition of core commands across different contexts
Connecting concepts (permissions + ownership + processes)

What I'd Do Differently

Start building personal cheat sheet from Day 1
Practice speed drills earlier
Use production-like environments more
Do weekly reviews instead of waiting for Day 12
Explain concepts out loud (teaching to learn)

Unexpected Discoveries

ls -l is more powerful than I thought
Process states tell you so much about system health
Ownership and permissions work together, not separately
Top 5 commands handle 80% of incidents
Muscle memory develops faster than expected

What Excites Me About Next Phase

Building on solid foundation
Solving real problems
Speed improvement through practice
Starting to "think in Linux"
Ready for more advanced topics



=================================================================================


🚀 FINAL NOTES
This revision confirmed that the structured approach from Days 1-11 built a solid foundation. The fundamentals are now muscle memory:

File operations are natural
Permission concepts are clear
Process monitoring is comfortable
User/group management is confident

The next phase will build on this foundation with:

Network troubleshooting
Advanced log analysis
Complex incident scenarios
Speed and efficiency
Real-world application

Most Important Realization: I'm no longer afraid of the command line. I understand what I'm doing and why. That confidence shift is the biggest win from these 12 days.
Ready for Day 13..!!





