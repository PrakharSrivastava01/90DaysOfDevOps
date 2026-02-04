## THE BASICS

### What is File Ownership?
Every file/directory in Linux has:
- **OWNER** → A specific user who owns it
- **GROUP** → A group of users who can access it

**Format:** -rw-r--r-- 1 owner group size date filename
                         👆      👆
                       user    group

---

## 👤 OWNER vs GROUP - What's the Difference?

**OWNER (User):**
- Single user who "owns" the file
- Usually the person who created it
- Has primary control over permissions
- Example: `tokyo`, `berlin`, `professor`

**GROUP:**
- Collection of users
- Multiple people can share access
- Good for team collaboration
- Example: `heist-team`, `vault-team`, `planners`

**Why Both?**
- Owner → Individual responsibility
- Group → Team collaboration
- Others → Everyone else on the system

---

## 🔧 ESSENTIAL COMMANDS

### 1. VIEW OWNERSHIP


ls -l filename              # See owner & group
ls -ld directory/           # See directory ownership
ls -lR directory/           # Recursive view


### 2. CHANGE OWNER (chown)


chown newowner file         # Change owner only
chown owner:group file      # Change both
chown :group file           # Change group only (alt method)
chown -R owner:group dir/   # Recursive (whole directory tree)


### 3. CHANGE GROUP (chgrp)

chgrp newgroup file         # Change group only
chgrp -R newgroup dir/      # Recursive


---

## ⚡ QUICK COMMAND PATTERNS

### Single File Operations

chown tokyo file.txt                    # Owner only
chgrp heist-team file.txt              # Group only
chown tokyo:heist-team file.txt        # Both at once ⭐


### Directory Operations


chown -R professor:planners project/   # Everything inside
chgrp -R vault-team backup/            # All files & subdirs


### Creating Users & Groups

useradd username                       # Create user
groupadd groupname                     # Create group
id username                            # Check user exists


---

## 📋 STEP-BY-STEP EXAMPLES

### Example 1: Single File Ownership

# Create file
touch devops-file.txt
ls -l devops-file.txt
# Output: -rw-r--r-- 1 root root 0 Feb 4 12:09 devops-file.txt

# Change owner
chown tokyo devops-file.txt
# Output: -rw-r--r-- 1 tokyo root 0 Feb 4 12:09 devops-file.txt

# Change owner again
chown berlin devops-file.txt
# Output: -rw-r--r-- 1 berlin root 0 Feb 4 12:09 devops-file.txt


### Example 2: Change Group Only

# Create file and group
touch team-notes.txt
groupadd heist-team

# Change group
chgrp heist-team team-notes.txt
# Output: -rw-r--r-- 1 root heist-team 0 Feb 4 12:09 team-notes.txt


### Example 3: Combined Change (Owner + Group)


# Create file
touch project-config.yaml

# Change both in ONE command
chown professor:heist-team project-config.yaml
# Output: -rw-r--r-- 1 professor heist-team 0 Feb 4 12:09 project-config.yaml

# Works for directories too!
mkdir app-logs
chown berlin:heist-team app-logs
# Output: drwxr-xr-x 2 berlin heist-team 4096 Feb 4 12:09 app-logs


### Example 4: Recursive Ownership (IMPORTANT!)


# Create directory structure
mkdir -p heist-project/vault
mkdir -p heist-project/plans
touch heist-project/vault/gold.txt
touch heist-project/plans/strategy.conf

# Before: everything owned by root
ls -lR heist-project/
# heist-project/:
# drwxr-xr-x 2 root root 4096 plans
# drwxr-xr-x 2 root root 4096 vault

# Change EVERYTHING recursively with -R flag
chown -R professor:planners heist-project/

# After: everything owned by professor:planners
ls -lR heist-project/
# heist-project/:
# drwxr-xr-x 2 professor planners 4096 plans
# drwxr-xr-x 2 professor planners 4096 vault
# 
# heist-project/plans:
# -rw-r--r-- 1 professor planners 0 strategy.conf
#
# heist-project/vault:
# -rw-r--r-- 1 professor planners 0 gold.txt


---

## 🏆 PRACTICE CHALLENGE SOLUTION

### Setup:

# Create users
useradd tokyo
useradd berlin
useradd nairobi

# Create groups
groupadd vault-team
groupadd tech-team

# Create directory and files
mkdir bank-heist
touch bank-heist/access-codes.txt
touch bank-heist/blueprints.pdf
touch bank-heist/escape-plan.txt


### Set Different Ownership:

chown tokyo:vault-team bank-heist/access-codes.txt
chown berlin:tech-team bank-heist/blueprints.pdf
chown nairobi:vault-team bank-heist/escape-plan.txt


### Verify:


ls -l bank-heist/
# -rw-r--r-- 1 tokyo   vault-team 0 Feb 4 access-codes.txt
# -rw-r--r-- 1 berlin  tech-team  0 Feb 4 blueprints.pdf
# -rw-r--r-- 1 nairobi vault-team 0 Feb 4 escape-plan.txt


---

## 💡 KEY CONCEPTS TO REMEMBER

### 1. **Ownership is Hierarchical**

Permission Check Order:
1. Is user the OWNER? → Use owner permissions
2. Is user in GROUP? → Use group permissions
3. Everyone else → Use others permissions


### 2. **Recursive Flag -R is Powerful**
- Changes directory AND everything inside
- Affects all subdirectories and files
- Use carefully! Can change 1000s of files
- Always verify with `ls -lR` after

### 3. **Why You Need sudo (or be root)**
- Only root or file owner can change ownership
- Most times you'll need `sudo chown`
- In production: Be careful with sudo!
- Security measure to prevent unauthorized changes

---

## 🚨 COMMON MISTAKES & FIXES

### Mistake 1: User Doesn't Exist

chown fakeusr file.txt
# Error: chown: invalid user: 'fakeusr'

# FIX: Create user first
useradd fakeusr


### Mistake 2: Group Doesn't Exist

chgrp fakegroup file.txt
# Error: chgrp: invalid group: 'fakegroup'

# FIX: Create group first
groupadd fakegroup


### Mistake 3: Permission Denied

chown tokyo file.txt
# Error: chown: changing ownership of 'file.txt': Operation not permitted

# FIX: Use sudo (if not root)
sudo chown tokyo file.txt


### Mistake 4: Forgot -R for Directory

chown tokyo:team project/
# Only changes project/ directory, NOT files inside!

# FIX: Add -R flag
chown -R tokyo:team project/


---

## 🎓 LEARNING POINTS

### 1. **Ownership ≠ Permissions**
- **Ownership** → WHO owns the file (user & group)
- **Permissions** → WHAT they can do (rwx)
- They work TOGETHER for access control
- Example: tokyo owns file BUT might not have write permission

### 2. **Groups Enable Collaboration**
- Single file, multiple users need access
- Add users to same group
- Set file group ownership to that group
- Example: heist-team group for project files

### 3. **Recursive Changes Save Time**
- Deploying apps → Set ownership for entire app directory
- Log rotation → Change all logs at once
- Backups → Ensure backup user owns all backup files
- Use -R flag but VERIFY after!

---

## 🔥 REAL DEVOPS SCENARIOS

### Scenario 1: Web Application Deployment

# Deploy app owned by 'webapp' user in 'www-data' group
chown -R webapp:www-data /var/www/myapp/
# Now webapp user can modify, www-data group can read


### Scenario 2: Shared Team Directory

# Create shared space for dev team
mkdir /opt/devteam-shared
groupadd devteam
chown -R :devteam /opt/devteam-shared/
chmod -R 775 /opt/devteam-shared/
# All devteam members can read/write/execute


### Scenario 3: Container Volume Permissions

# Docker volume owned by specific user
chown -R 1000:1000 /docker/volumes/appdata/
# Matches UID inside container


### Scenario 4: CI/CD Pipeline Artifacts

# Build artifacts owned by jenkins user
chown -R jenkins:jenkins /var/lib/jenkins/workspace/
# Jenkins can manage its own build files


### Scenario 5: Log File Management

# Application logs readable by syslog group
chown -R appuser:syslog /var/log/myapp/
chmod -R 640 /var/log/myapp/
# App writes, syslog can read, others can't access


---

## 📊 QUICK REFERENCE TABLE

| Command | Purpose | Example |
|---------|---------|---------|
| `chown user file` | Change owner | `chown tokyo notes.txt` |
| `chgrp group file` | Change group | `chgrp team notes.txt` |
| `chown user:group file` | Change both | `chown tokyo:team notes.txt` |
| `chown -R user:group dir/` | Recursive | `chown -R tokyo:team project/` |
| `ls -l` | View ownership | `ls -l file.txt` |
| `ls -ld` | View dir ownership | `ls -ld /home/tokyo/` |
| `useradd name` | Create user | `useradd berlin` |
| `groupadd name` | Create group | `groupadd heist-team` |
| `id username` | Check user info | `id tokyo` |

---

## 🎯 SYNTAX PATTERNS TO MEMORIZE


# Owner only
chown USER file

# Group only (two ways)
chgrp GROUP file
chown :GROUP file

# Both together
chown USER:GROUP file

# Recursive
chown -R USER:GROUP directory/

# Keep owner, change group only
chown :GROUP file


---

## ✅ VERIFICATION CHECKLIST

After any ownership change, ALWAYS verify:


✓ ls -l file              # Check single file
✓ ls -ld directory/       # Check directory itself
✓ ls -lR directory/       # Check all contents
✓ id username             # Confirm user exists
✓ getent group groupname  # Confirm group exists


---

## 🚀 PRO TIPS

1. **Use chown for both** → `chown user:group` faster than separate commands
2. **Verify before recursive** → Check a few files before `-R` on huge directories
3. **Document ownership** → Keep notes on who should own what
4. **Plan group structure** → Design groups before creating files
5. **Test with non-root** → Use `su - username` to test actual access

---

## 📝 HOMEWORK / PRACTICE

Try these to master ownership:

1. Create 3 users and 2 groups
2. Create a project directory with subdirectories
3. Assign different owners to different subdirectories
4. Use recursive change on parent
5. Verify all files changed correctly
6. Try accessing files as different users

---

## 🔗 RELATIONSHIP WITH OTHER CONCEPTS


File Ownership works with:
├── Permissions (rwx) → WHO can do WHAT
├── sudo/su → HOW to change ownership
├── User Management → Creating users/groups
├── File System → Where files are stored
└── Security → Access control strategy


---

## 💭 REMEMBER

**"Ownership defines WHO, Permissions define WHAT"**

- chown → Change owner/group
- chmod → Change permissions (yesterday's lesson!)
- Together they control file access completely

**The DevOps Mantra:**
- Right user, right group, right permissions
- Test changes before production
- Document your ownership strategy
- Audit regularly for security

---

**End of Notes** ✨
*Day 11 Complete - File Ownership Mastered!*
