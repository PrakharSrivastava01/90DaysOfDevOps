## TASK 1: My First Script

### What I Did
- Created a file `hello.sh`
- Added shebang (`#!/bin/bash`) at the top to tell the kernel which shell interpreter to use
- Printed "Hello, DevOps!" using `echo`
- Made it executable using `chmod 754/764`
- Ran the script successfully

### Key Learning
**What happens without the shebang?**
The script may run using the default shell instead of bash, which could lead to unexpected behavior if shell-specific syntax is used.

---

## TASK 2: Variables

### What I Did
- Created `variables.sh` with variables for NAME and ROLE
- Printed a formatted message using variable interpolation
- Tested the difference between single and double quotes

### Key Learning: Single Quotes vs Double Quotes
- **Single quotes (`'`)**: Treats everything as literal text — variables are NOT expanded
- **Double quotes (`"`)**: Allows variable expansion and displays the actual variable values

**Result**: When using single quotes, no variable values were displayed; with double quotes, all variables expanded correctly.

---

## TASK 3: User Input with `read`

### What I Did
- Created `greet.sh` that prompts for user's name and favorite tool
- Used `read -p` command to combine prompt and input collection
- Displayed a personalized greeting with the collected information

### Key Learning
The `read -p` command makes scripts interactive by combining the prompt and input in one line, creating a better user experience.

---

## TASK 4: If-Else Conditions

### 4.1: Number Checker (`check_number.sh`)

**What I Did:**
- Created a script that takes a number as input
- Used if-elif-else to check if the number is positive, negative, or zero
- Printed the appropriate result based on the condition

### 4.2: File Existence Checker (`file_check.sh`)

**What I Did:**
- Created a script that asks for a filename
- Used the `-f` test operator to check if the file exists
- Displayed appropriate messages based on file existence

### Key Learning
**Syntax precision is critical!**
- Proper spacing around brackets is mandatory: `[ condition ]` not `[condition]`
- Indentation improves readability and helps avoid errors
- Test operators like `-gt` (greater than), `-lt` (less than), and `-f` (file exists) enable conditional logic
- Commas, brackets, and quotes placement matters significantly

---

## TASK 5: Combine It All - Service Status Checker

### What I Did
- Created `server_check.sh` with a stored service name variable (nginx)
- Asked user if they want to check the service status (y/n)
- If 'y': Used `systemctl is-active` to check if service is running and printed whether it's active or not
- If 'n': Printed "Skipped"

*** Key Learning
- Nested conditionals allow for more sophisticated decision-making
- `systemctl is-active --quiet` efficiently checks service status without verbose output
- Proper variable quoting prevents issues with word-splitting and special characters
- User input validation makes scripts more robust

---

## Top 3 Key Takeaways

1. **Syntax Precision**: Spacing, brackets, quotes, and operators must be exact — shell scripting is unforgiving of syntax errors. Even a single missing space can break the entire script.

2. **Quote Behavior**: Single quotes preserve literal strings, while double quotes enable variable expansion — this is critical for displaying dynamic content and variable values.

3. **Conditionals Enable Logic**: `if-else` statements combined with test operators (`-f`, `-gt`, `-lt`) allow scripts to make intelligent decisions based on input and system state, making automation possible.

---

Screenshots are attached below for reference:-


<img width="846" height="376" alt="Screenshot 2026-02-09 232730" src="https://github.com/user-attachments/assets/7763a16e-ea07-4f8d-8d1a-6dc43875b7b2" />
<img width="530" height="269" alt="Screenshot 2026-02-09 231325" src="https://github.com/user-attachments/assets/1e30e6ed-1ea5-449c-a9b8-d0488a3afdaa" />
<img width="886" height="683" alt="Screenshot 2026-02-09 215214" src="https://github.com/user-attachments/assets/847d6f47-207b-41d9-bd27-76ba0ad566d3" />
<img width="887" height="769" alt="Screenshot 2026-02-09 213440" src="https://github.com/user-attachments/assets/bfdee48c-b607-4eec-a0ab-07fbb6f29fbf" />
<img width="948" height="246" alt="Screenshot 2026-02-09 174624" src="https://github.com/user-attachments/assets/4db0d674-fbed-4375-adc9-5a7912624778" />
<img width="1114" height="394" alt="Screenshot 2026-02-09 174425" src="https://github.com/user-attachments/assets/9646f0d3-9241-4f8c-ad05-2df47e965d39" />
<img width="1694" height="1029" alt="Screenshot 2026-02-09 003921" src="https://github.com/user-attachments/assets/2084f055-7a11-4742-8d6e-d29040c94b8f" />
