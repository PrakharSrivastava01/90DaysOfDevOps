# Day 10 Challenge - File Permissions & File Operations

---

## Task 1: Create Files (10 minutes)

### Files Created

1. **devops.txt** - Created using `touch`
   
   touch devops.txt
   
   - Initial permissions: `-rw-r--r--` (644)
   - Empty file created successfully

2. **notes.txt** - Created using `echo` with content
   
   echo "This is my DevOps learning journey
   I am mastering Linux file operations
   Permissions are key to system security" > notes.txt
   
   - Initial permissions: `-rw-r--r--` (644)
   - Contains 3 lines of text

3. **script.sh** - Created with bash script content
   
   cat > script.sh << 'EOF'
   #!/bin/bash
   echo "Hello DevOps"
   EOF
   
   - Initial permissions: `-rw-r--r--` (644)
   - Contains shebang and echo command

### Verification

$ ls -l
-rw-r--r-- 1 root root   0 Feb  3 12:41 devops.txt
-rw-r--r-- 1 root root 111 Feb  3 12:41 notes.txt
-rw-r--r-- 1 root root  32 Feb  3 12:41 script.sh


---

## Task 2: Read Files (10 minutes)

### 2.1 Read notes.txt using cat

$ cat notes.txt
This is my DevOps learning journey
I am mastering Linux file operations
Permissions are key to system security


### 2.2 View script.sh

$ cat script.sh
#!/bin/bash
echo "Hello DevOps"

**Note:** Could also use `vim -R script.sh` for read-only mode in vim

### 2.3 Display first 5 lines of /etc/passwd

$ head -n 5 /etc/passwd
root:x:0:0:root:/root:/bin/bash
daemon:x:1:1:daemon:/usr/sbin:/usr/sbin/nologin
bin:x:2:2:bin:/bin:/usr/sbin/nologin
sys:x:3:3:sys:/dev:/usr/sbin/nologin
sync:x:4:65534:sync:/bin:/bin/sync


### 2.4 Display last 5 lines of /etc/passwd

$ tail -n 5 /etc/passwd
ubuntu:x:1000:1000:Ubuntu:/home/ubuntu:/bin/bash
systemd-network:x:998:998:systemd Network Management:/:/usr/sbin/nologin
messagebus:x:100:101::/nonexistent:/usr/sbin/nologin
polkitd:x:997:997:User for polkitd:/:/usr/sbin/nologin
testuser:x:1001:1001::/home/testuser:/bin/sh


---

## Task 3: Understand Permissions (10 minutes)

### Permission Format: `rwxrwxrwx`
- **Position 1-3:** Owner permissions (user)
- **Position 4-6:** Group permissions
- **Position 7-9:** Others permissions

### Permission Values
- `r` = read (4)
- `w` = write (2)
- `x` = execute (1)

### Initial Permissions Analysis

#### devops.txt: `-rw-r--r--` (644)
- **Owner:** read + write (6)
- **Group:** read only (4)
- **Others:** read only (4)
- **Who can read?** Owner, group, others
- **Who can write?** Owner only
- **Who can execute?** Nobody

#### notes.txt: `-rw-r--r--` (644)
- **Owner:** read + write (6)
- **Group:** read only (4)
- **Others:** read only (4)
- **Who can read?** Owner, group, others
- **Who can write?** Owner only
- **Who can execute?** Nobody

#### script.sh: `-rw-r--r--` (644)
- **Owner:** read + write (6)
- **Group:** read only (4)
- **Others:** read only (4)
- **Who can read?** Owner, group, others
- **Who can write?** Owner only
- **Who can execute?** Nobody (cannot run as script yet)

---

## Task 4: Modify Permissions (20 minutes)

### 4.1 Make script.sh Executable

**Before:**

$ ls -l script.sh
-rw-r--r-- 1 root root 32 Feb  3 12:41 script.sh


**Command:**

$ chmod +x script.sh


**After:**

$ ls -l script.sh
-rwxr-xr-x 1 root root 32 Feb  3 12:41 script.sh


**Execute the script:**

$ ./script.sh
Hello DevOps


**Changes:**
- Owner: `rw-` → `rwx` (6 → 7)
- Group: `r--` → `r-x` (4 → 5)
- Others: `r--` → `r-x` (4 → 5)
- New permissions: 755

---

### 4.2 Set devops.txt to Read-Only

**Before:**

$ ls -l devops.txt
-rw-r--r-- 1 root root 0 Feb  3 12:41 devops.txt


**Command:**

$ chmod -w devops.txt


**After:**

$ ls -l devops.txt
-r--r--r-- 1 root root 0 Feb  3 12:41 devops.txt


**Changes:**
- Owner: `rw-` → `r--` (6 → 4)
- Group: `r--` → `r--` (4 → 4)
- Others: `r--` → `r--` (4 → 4)
- New permissions: 444 (read-only for all)

---

### 4.3 Set notes.txt to 640

**Before:**

$ ls -l notes.txt
-rw-r--r-- 1 root root 111 Feb  3 12:41 notes.txt


**Command:**

$ chmod 640 notes.txt


**After:**

$ ls -l notes.txt
-rw-r----- 1 root root 111 Feb  3 12:41 notes.txt


**Changes:**
- Owner: `rw-` → `rw-` (6 → 6) - unchanged
- Group: `r--` → `r--` (4 → 4) - unchanged
- Others: `r--` → `---` (4 → 0) - removed all permissions
- New permissions: 640 (owner can read/write, group can read, others have no access)

---

### 4.4 Create Directory with 755 Permissions

**Command:**

$ mkdir project
$ chmod 755 project


**Result:**

$ ls -ld project
drwxr-xr-x 2 root root 4096 Feb  3 12:42 project


**Permissions Breakdown:**
- `d` indicates directory
- Owner: `rwx` (7) - can read, write, and enter directory
- Group: `r-x` (5) - can read and enter directory
- Others: `r-x` (5) - can read and enter directory

---

### Final Verification


$ ls -l
-r--r--r-- 1 root root    0 Feb  3 12:41 devops.txt
-rw-r----- 1 root root  111 Feb  3 12:41 notes.txt
drwxr-xr-x 2 root root 4096 Feb  3 12:42 project
-rwxr-xr-x 1 root root   32 Feb  3 12:41 script.sh


---

## Task 5: Test Permissions (10 minutes)

### 5.1 Writing to a Read-Only File

**Test File:** devops.txt (permissions: 444)

**Command:**

$ echo "Trying to write" > devops.txt


**Error Message (for non-root users):**

bash: devops.txt: Permission denied


**Explanation:**
- The file has read-only permissions (444)
- Write bit is removed for owner, group, and others
- System prevents modification to protect file integrity
- **Note:** Root users can override this, but regular users cannot

---

### 5.2 Executing File Without Execute Permission

**Test File:** test_no_exec.sh (permissions: 644)

**Setup:**

$ cat > test_no_exec.sh << 'EOF'
#!/bin/bash
echo "Testing"
EOF
$ chmod 644 test_no_exec.sh
$ ls -l test_no_exec.sh
-rw-r--r-- 1 root root 25 Feb  3 12:42 test_no_exec.sh


**Command:**

$ ./test_no_exec.sh


**Error Message:**

/bin/sh: 5: ./test_no_exec.sh: Permission denied


**Exit Code:** 126 (command cannot execute)

**Explanation:**
- File lacks execute permission (no 'x' bit)
- Even though file contains valid shell code
- Operating system refuses to run it as a program
- **Solution:** Add execute permission with `chmod +x test_no_exec.sh`

---

## Commands Used

### File Creation

touch devops.txt                    # Create empty file
echo "content" > notes.txt          # Create file with content
cat > script.sh << 'EOF'            # Create file with heredoc


### File Reading

cat filename                        # Display entire file
head -n 5 /etc/passwd              # Show first 5 lines
tail -n 5 /etc/passwd              # Show last 5 lines
vim -R filename                     # Open in read-only mode (vim)


### Permission Management

ls -l                              # List files with permissions
ls -ld directory                   # List directory itself
chmod +x file                      # Add execute permission
chmod -w file                      # Remove write permission
chmod 644 file                     # Set specific permissions (numeric)
chmod 755 directory                # Set directory permissions


### Directory Operations

mkdir directory                    # Create directory


---

---

## What I Learned

### 1. **Permission Structure and Numeric Notation**
Linux permissions use a three-tier system (owner-group-others) with three types of access (read-write-execute). The numeric notation (e.g., 755, 644) is calculated by adding permission values: read=4, write=2, execute=1. This makes permission management precise and efficient. For example, 755 means owner has full access (7=4+2+1), while group and others can read and execute (5=4+1).

### 2. **Execute Permission is Essential for Scripts**
A file containing valid shell code cannot run as a script without the execute permission bit set. Even with a proper shebang (`#!/bin/bash`) and correct syntax, the system will return "Permission denied" (exit code 126) when attempting to execute. The `chmod +x` command grants this permission, transforming a text file into an executable program.

### 3. **Read-Only Protection is Fundamental to Security**
Setting files to read-only (444 or using `chmod -w`) provides protection against accidental or unauthorized modification. This is crucial for configuration files, logs, and critical system data. Regular users cannot override read-only permissions, ensuring data integrity. Combined with proper ownership and group permissions (like 640), you can create fine-grained access control for multi-user systems.

---

## Screenshots Reference

**Note:** Screenshots would typically show:
1. Initial `ls -l` output showing all files with 644 permissions
2. Permission changes in progress with before/after `ls -l` comparisons
3. Successful execution of `./script.sh` after adding execute permission
4. Error messages from permission tests (read-only write attempt, non-executable execution)
5. Final `ls -l` showing all modified permissions

---

## Additional Notes

### Best Practices Learned
- Always verify permissions with `ls -l` after changes
- Use numeric notation (755, 644) for precise control
- Test permissions to understand behavior
- Default file creation: 644 (rw-r--r--)
- Default directory creation: 755 (rwxr-xr-x)

### Common Permission Patterns
- **644** - Regular files (owner can modify, others can read)
- **755** - Executable files and directories
- **640** - Sensitive files (no public access)
- **600** - Private files (owner only)
- **444** - Read-only files (cannot be modified)

### Security Considerations
- Minimize execute permissions on files
- Restrict write access to the owner when possible
- Remove "others" permissions for sensitive data
- Regular audit of file permissions
- Use groups effectively for team access

---


** screenshots **

- <img width="396" height="1093" alt="Screenshot 2026-02-03 152527" src="https://github.com/user-attachments/assets/e9b39393-e4c3-4b94-afd8-c6bd7d8731b6" />
- <img width="897" height="1000" alt="Screenshot 2026-02-03 152909" src="https://github.com/user-attachments/assets/a1116d50-1d1b-4ac3-9dc1-f300e2e3bdf6" />
- <img width="1372" height="716" alt="Screenshot 2026-02-03 153016" src="https://github.com/user-attachments/assets/fc0cb9e7-69dc-4752-925d-e54ac2e6b6e5" />
- <img width="1484" height="1016" alt="Screenshot 2026-02-03 153054" src="https://github.com/user-attachments/assets/4b09b782-3ac7-4823-abee-ac93ff8bb3ed" />
- <img width="980" height="1094" alt="Screenshot 2026-02-03 154652" src="https://github.com/user-attachments/assets/2d6f6867-619d-48cb-9cb4-ed024b1528e0" />
- <img width="1147" height="419" alt="Screenshot 2026-02-03 161011" src="https://github.com/user-attachments/assets/8091e2f7-c9c3-478a-a66b-bcbecfae5659" />
- <img width="674" height="1118" alt="Screenshot 2026-02-03 180829" src="https://github.com/user-attachments/assets/e53d4a8b-40c9-46b6-af6d-1bf49cb1fd7b" />
- <img width="915" height="876" alt="Screenshot 2026-02-03 181929" src="https://github.com/user-attachments/assets/4de4d6d8-fd9b-4b52-bdf2-4d06845fc7ce" />
- <img width="674" height="1118" alt="Screenshot 2026-02-03 180829" src="https://github.com/user-attachments/assets/169ce6fe-db5e-426b-9d91-d2cb0b3e15b6" />







