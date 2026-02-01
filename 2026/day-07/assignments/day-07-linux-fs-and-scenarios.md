# Day 07 - Part 1: Linux File System Hierarchy

## Core Directories (Must Know)

### 1. `/` (root)
**What it contains:**
The root directory is the top-level directory of the entire Linux file system. Everything in Linux starts from here - all files, directories, and devices are organized under this single root.

**What I see when running `ls -l /`:**
```
drwxr-xr-x home
drwxr-xr-x etc
drwxr-xr-x var
drwx--S--- root
drwxr-xr-x opt
```

**I would use this when:**
I need to navigate to any major system directory or understand the overall structure of the Linux system. It's the starting point for all absolute paths.

---

### 2. `/home`
**What it contains:**
Contains personal directories for regular users. Each user gets their own folder here (e.g., /home/john, /home/sarah) where they can store personal files, documents, and configurations.

**What I see when running `ls -l /home`:**
```
drwxr-xr-x home
drwxr-x--- ubuntu
```

**I would use this when:**
I need to access a user's personal files, check user quotas, or backup user data. DevOps engineers often check here when troubleshooting user-specific issues.

---

### 3. `/root`
**What it contains:**
This is the home directory for the root user (system administrator). Unlike regular users who are in /home, the root user has a separate directory at the top level.

**What I see when running `ls -l /root` (requires sudo):**
```
Permission denied (this is expected - only root can access)
```

**I would use this when:**
I'm logged in as root or using sudo to perform administrative tasks. Root user's personal scripts and configs are stored here.

---

### 4. `/etc`
**What it contains:**
System-wide configuration files. This is where all the settings for your system and applications live. Think of it as the "settings" folder for Linux.

**What I see when running `ls -l /etc | head -15`:**
```
-rw-r--r-- adduser.conf
-rw-r--r-- bash.bashrc
drwxr-xr-x apt/
-rw-r--r-- ca-certificates.conf
drwxr-xr-x alternatives/
```

**Example config file - `/etc/os-release`:**
```
PRETTY_NAME="Ubuntu 24.04.3 LTS"
NAME="Ubuntu"
VERSION_ID="24.04"
```

**I would use this when:**
I need to configure services (like nginx, ssh, apache), modify system settings, or troubleshoot configuration issues. As a DevOps engineer, you'll spend a LOT of time here!

---

### 5. `/var/log`
**What it contains:**
System and application log files. This is THE most important directory for DevOps troubleshooting! Logs help you understand what went wrong.

**What I see when running `ls -l /var/log`:**
```
-rw-r--r-- alternatives.log
-rw-r--r-- bootstrap.log
-rw-r--r-- dpkg.log
drwxr-xr-x apt/
drwxr-sr-x journal/
```

**Largest log files (using `du -sh /var/log/* | sort -h | tail -5`):**
```
5.5K    fontconfig.log
20K     alternatives.log
60K     bootstrap.log
305K    apt/
575K    dpkg.log
```

**I would use this when:**
A service fails, application crashes, or I need to investigate what happened on the system. Example: checking `/var/log/nginx/error.log` when a website goes down.

---

### 6. `/tmp`
**What it contains:**
Temporary files created by applications and users. Files here are usually deleted on reboot (system cleanup).

**What I see when running `ls -l /tmp`:**
```
drwxr-xr-x hsperfdata_root/
drwxr-xr-x node-compile-cache/
drwxrwxrwx phantomjs/
-rwxrwxrwx uv-*.lock files
```

**I would use this when:**
Testing scripts that need temporary storage, or when an application needs a place to store temporary data. Also check here if disk space is running low - you can safely delete old temp files.

---

## Additional Directories (Good to Know)

### 7. `/bin` (Essential Command Binaries)
**What it contains:**
Essential command-line programs needed for system boot and repair. Contains basic commands like `ls`, `cp`, `mv`, `cat`, etc.

**What I see:**
```
lrwxrwxrwx /bin -> usr/bin
(Note: /bin is now a symbolic link to /usr/bin in modern Linux)
```

**I would use this when:**
Running basic shell commands. In modern systems, `/bin` and `/usr/bin` are merged for simplicity.

---

### 8. `/usr/bin` (User Command Binaries)
**What it contains:**
User-level command binaries and applications. Most of the commands you use daily live here (like `python`, `git`, `vim`, `gcc`, etc.).

**What I see when running `ls -l /usr/bin | head -10`:**
```
-rwxr-xr-x Xvfb
-rwxr-xr-x activate-global-python-argcomplete
-rwxr-xr-x add-apt-repository
-rwxr-xr-x addr2line
```

**I would use this when:**
I need to check if a specific command/tool is installed, or when troubleshooting "command not found" errors.

---

### 9. `/opt` (Optional/Third-Party Applications)
**What it contains:**
Optional software packages and third-party applications that aren't part of the default system. Companies often install custom software here.

**What I see when running `ls -l /opt`:**
```
drwxr-xr-x google/
drwxr-xr-x pw-browsers/
```

**I would use this when:**
Installing or managing third-party applications like Google Chrome, custom enterprise software, or manually installed programs that don't use package managers.

---

## Hands-On Practice Summary

### Command 1: Find largest log files
```bash
du -sh /var/log/* 2>/dev/null | sort -h | tail -5
```
**Result:** dpkg.log is the largest at 575K

### Command 2: View a config file
```bash
cat /etc/os-release
```
**Result:** Shows Ubuntu 24.04.3 LTS system information

### Command 3: Check home directory
```bash
ls -la ~
```
**Result:** Shows .bashrc, .profile, .cache, and .ssh directories

--
**DevOps Priority:** `/var/log` and `/etc` are your best friends!
