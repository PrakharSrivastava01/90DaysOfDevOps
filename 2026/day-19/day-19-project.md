# Day 19 – Shell Scripting Project: Log Rotation, Backup & Crontab

## Project Overview
This project implements automated system maintenance tasks including log rotation, server backups, and scheduled task execution using shell scripts and crontab.

---

## Task 1: Log Rotation Script

### Sample Output - Successful Execution
```
$ ./log_rotate.sh test_logs
Starting log rotation for: test_logs
==========================================
Compressing .log files older than 7 days...
Deleting .gz files older than 30 days...
==========================================
Log rotation completed!
Files compressed: 2
Files deleted: 0
```

### Sample Output - Error Handling (No Arguments)
```
$ ./log_rotate.sh
Error: No log directory specified
Usage: ./log_rotate.sh <log_directory>
```

### Sample Output - Error Handling (Invalid Directory)
```
$ ./log_rotate.sh /nonexistent/path
Error: Directory '/nonexistent/path' does not exist
```

### Features Implemented
- ✅ Accepts log directory as argument
- ✅ Compresses `.log` files older than 7 days using gzip
- ✅ Deletes `.gz` files older than 30 days
- ✅ Prints count of compressed and deleted files
- ✅ Exits with error if directory doesn't exist
- ✅ Validates input arguments

---

## Task 2: Server Backup Script

### Sample Output - Successful Execution
```
$ ./backup.sh test_source test_backup
Starting backup process...
==========================================
Source: test_source
Destination: test_backup/backup-2026-02-14.tar.gz
==========================================
Backup successful!
Archive name: backup-2026-02-14.tar.gz
Archive size: 512
==========================================
Cleaning up old backups (older than 14 days)...
Deleted 0 old backup(s)
==========================================
Backup process completed successfully!
```

### Sample Output - Error Handling (Missing Arguments)
```
$ ./backup.sh test_source
Error: Missing arguments
Usage: ./backup.sh <source_directory> <backup_destination>
```

### Sample Output - Error Handling (Invalid Source)
```
$ ./backup.sh nonexistent_dir test_backup
Error: Source directory 'nonexistent_dir' does not exist
```

### Features Implemented
- ✅ Accepts source and destination as arguments
- ✅ Creates timestamped `.tar.gz` archives (format: `backup-YYYY-MM-DD.tar.gz`)
- ✅ Verifies archive creation success
- ✅ Prints archive name and size
- ✅ Deletes backups older than 14 days
- ✅ Comprehensive error handling
- ✅ Creates backup destination if it doesn't exist

---

## Task 3: Crontab Entries

### Cron Syntax Reference
```
* * * * * command
│ │ │ │ │
│ │ │ │ └── Day of week (0-7, where 0 and 7 are Sunday)
│ │ │ └──── Month (1-12)
│ │ └────── Day of month (1-31)
│ └──────── Hour (0-23)
└────────── Minute (0-59)
```

### Cron Entry #1: Run log_rotate.sh every day at 2 AM
```cron
0 2 * * * /path/to/log_rotate.sh /var/log/myapp
```
**Explanation:** 
- `0` = At minute 0
- `2` = At hour 2 (2 AM)
- `*` = Every day of month
- `*` = Every month
- `*` = Every day of week

### Cron Entry #2: Run backup.sh every Sunday at 3 AM
```cron
0 3 * * 0 /path/to/backup.sh /home/data /backups
```
**Explanation:**
- `0` = At minute 0
- `3` = At hour 3 (3 AM)
- `*` = Every day of month
- `*` = Every month
- `0` = Sunday (0 or 7 represents Sunday)

### Cron Entry #3: Run health check script every 5 minutes
```cron
*/5 * * * * /path/to/health_check.sh
```
**Explanation:**
- `*/5` = Every 5 minutes (divisible by 5: 0, 5, 10, 15, etc.)
- `*` = Every hour
- `*` = Every day of month
- `*` = Every month
- `*` = Every day of week

### How to View Current Crontab
```bash
crontab -l
```

### How to Edit Crontab
```bash
crontab -e
```

---

## Task 4: Combined Maintenance Script

### Sample Output - Maintenance Script Execution
```
2026-02-14 10:30:15: ==========================================
2026-02-14 10:30:15: Starting Maintenance Script
2026-02-14 10:30:15: ==========================================
2026-02-14 10:30:15: === Starting Log Rotation ===
2026-02-14 10:30:15: Log rotation completed: 3 compressed, 1 deleted
2026-02-14 10:30:15: === Starting Backup Operation ===
2026-02-14 10:30:16: Backup successful: backup-2026-02-14.tar.gz (2.4M)
2026-02-14 10:30:16: Deleted 2 old backup(s)
2026-02-14 10:30:16: ==========================================
2026-02-14 10:30:16: Maintenance Script Completed
2026-02-14 10:30:16: ==========================================
```

### Features Implemented
- ✅ Calls log rotation function
- ✅ Calls backup function
- ✅ Logs all output to `/var/log/maintenance.log` with timestamps
- ✅ Uses timestamp format: `YYYY-MM-DD HH:MM:SS`
- ✅ Handles errors gracefully
- ✅ Modular function-based design

### Cron Entry for Daily Maintenance at 1 AM
```cron
0 1 * * * /path/to/maintenance.sh >> /var/log/maintenance.log 2>&1
```
**Explanation:**
- `0 1 * * *` = Every day at 1:00 AM
- `>> /var/log/maintenance.log` = Append stdout to log file
- `2>&1` = Redirect stderr to stdout (capture all output)

---

## Complete Crontab Configuration

Here's a complete crontab configuration for all maintenance tasks:

```cron
# Log Rotation - Daily at 2 AM
0 2 * * * /usr/local/bin/log_rotate.sh /var/log/myapp

# Server Backup - Every Sunday at 3 AM
0 3 * * 0 /usr/local/bin/backup.sh /home/data /backups

# Health Check - Every 5 minutes
*/5 * * * * /usr/local/bin/health_check.sh

# Complete Maintenance - Daily at 1 AM
0 1 * * * /usr/local/bin/maintenance.sh >> /var/log/maintenance.log 2>&1
```

---

## What I Learned (3 Key Points)

### 1. **Robust Error Handling is Critical for Production Scripts**
I learned that production scripts must validate all inputs and handle edge cases gracefully. Using conditional checks (`if [ ! -d "$DIR" ]`), proper exit codes, and clear error messages prevents scripts from failing silently or causing system issues. The scripts validate directory existence, argument counts, and operation success before proceeding.

### 2. **File Operations with Find Command are Powerful and Flexible**
The `find` command with `-mtime`, `-type`, and `-exec` flags provides precise control over file operations. Using `-print0` with `while read -r -d ''` handles filenames with spaces safely. The `+7` and `+30` day modifiers in `-mtime` enable time-based file management, which is essential for log rotation and backup cleanup.

### 3. **Cron Scheduling Requires Understanding System Context**
Crontab entries run in a minimal environment without the full user PATH or environment variables. This means:
- Always use absolute paths to scripts and commands
- Redirect output (`>>` and `2>&1`) to capture logs
- Consider system resource usage when scheduling (avoid peak hours)
- Test scripts manually before scheduling them
- The syntax `*/5` for intervals and specific values (like `0` for Sunday) enables flexible scheduling patterns

---

## Additional Best Practices Implemented

### Script Design
- **Modular functions** in maintenance.sh for reusability
- **Timestamped logging** for audit trails
- **Exit codes** (0 for success, 1 for errors) for monitoring
- **User feedback** with clear progress messages

### Security Considerations
- **Input validation** prevents directory traversal attacks
- **Quoted variables** (`"$VAR"`) prevent word splitting
- **Permission checks** could be added for sensitive operations

### Maintainability
- **Clear comments** explain script purpose and usage
- **Consistent formatting** improves readability
- **Help messages** guide users on proper syntax
- **Logging** enables troubleshooting and monitoring

---

## Testing Recommendations

### Before Production Deployment
1. **Test with sample data** in isolated directories
2. **Verify cron syntax** using online validators
3. **Check disk space** before running backups
4. **Monitor initial runs** to ensure proper execution
5. **Set up alerts** for script failures (email notifications)

### Monitoring
```bash
# Check if cron jobs are running
grep CRON /var/log/syslog

# View maintenance log
tail -f /var/log/maintenance.log

# Check cron execution
journalctl -u cron
```

---

## Project Structure
```
day-19-project/
├── log_rotate.sh          # Log rotation script
├── backup.sh              # Server backup script
├── maintenance.sh         # Combined maintenance script
└── day-19-project.md      # This documentation
```

---

## Conclusion

This project demonstrates practical DevOps automation using shell scripting. The combination of log rotation, backups, and scheduled execution via crontab forms the foundation of system maintenance automation. These scripts can be extended with features like email notifications, Slack webhooks, or integration with monitoring systems for production environments.