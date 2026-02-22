# Shell Scripting Cheat Sheet – Day 21

## Quick Reference Table

| Topic    | Key Syntax            | Example                          |
| -------- | --------------------- | -------------------------------- |
| Variable | VAR="value"           | NAME="DevOps"                    |
| Argument | $1, $2                | ./script.sh arg1                 |
| If       | if [ cond ]; then     | if [ -f file ]; then             |
| For      | for i in list; do     | for i in 1 2 3; do               |
| Function | name() { }            | greet() { echo Hi; }             |
| Grep     | grep pattern file     | grep -i error log.txt            |
| Awk      | awk '{print $1}' file | awk -F: '{print $1}' /etc/passwd |
| Sed      | sed 's/a/b/g' file    | sed -i 's/foo/bar/g' f.txt       |

---

## 1️⃣ Basics

### Shebang

```bash
#!/bin/bash
```

Tells system which interpreter to use.

### Run Script

```bash
chmod +x script.sh
./script.sh
bash script.sh
```

### Comments

```bash
# Single line
 echo "Hi"  # Inline comment
```

### Variables

```bash
NAME="DevOps"
echo $NAME
"$NAME"  # preserves spaces
'$NAME'  # literal
```

### Read Input

```bash
read -p "Enter name: " NAME
```

### Arguments

```bash
$0 script name
$1 first arg
$# total args
$@ all args
$? last exit code
```

---

## 2️⃣ Operators & Conditionals

### String

```bash
[ "$a" = "$b" ]
[ -z "$a" ]
[ -n "$a" ]
```

### Integer

```bash
[ $a -eq 5 ]
[ $a -gt 3 ]
```

### File Tests

```bash
-f file  # regular file
-d dir   # directory
-e file  # exists
-r file  # readable
-w file  # writable
-x file  # executable
-s file  # not empty
```

### If / Else

```bash
if [ cond ]; then
  echo yes
elif [ cond ]; then
  echo maybe
else
  echo no
fi
```

### Logical

```bash
cmd1 && cmd2
cmd1 || cmd2
! cmd
```

### Case

```bash
case $var in
  start) echo "Starting" ;;
  stop) echo "Stopping" ;;
  *) echo "Unknown" ;;
esac
```

---

## 3️⃣ Loops

### For

```bash
for i in 1 2 3; do echo $i; done
for ((i=0;i<5;i++)); do echo $i; done
```

### While

```bash
i=1
while [ $i -le 5 ]; do echo $i; ((i++)); done
```

### Until

```bash
until [ $i -gt 5 ]; do echo $i; ((i++)); done
```

### Control

```bash
break
continue
```

### Loop Files

```bash
for f in *.log; do echo $f; done
```

### Read Output

```bash
cat file | while read line; do echo $line; done
```

---

## 4️⃣ Functions

```bash
greet() {
  local name=$1
  echo "Hello $name"
}

greet DevOps
```

Return vs Echo:

```bash
return 0   # exit status
echo data  # output value
```

---

## 5️⃣ Text Processing

### Grep

```bash
grep -i pattern file
grep -r pattern dir
grep -c pattern file
grep -n pattern file
grep -v pattern file
grep -E "a|b" file
```

### Awk

```bash
awk '{print $1}' file
awk -F: '{print $1}' file
awk 'BEGIN{print "Start"} {print $1} END{print "End"}' file
```

### Sed

```bash
sed 's/old/new/g' file
sed -i 's/old/new/g' file
sed '3d' file
```

### Others

```bash
cut -d, -f1 file
sort -n file
uniq -c file
tr 'a-z' 'A-Z'
wc -l file
head -n 10 file
tail -f file
```

---

## 6️⃣ Useful One-Liners

```bash
find . -type f -mtime +7 -delete
wc -l *.log
sed -i 's/foo/bar/g' *.conf
systemctl is-active nginx
watch -n 5 df -h
```

---

## 7️⃣ Error Handling & Debugging

```bash
exit 0
exit 1
echo $?
set -e
set -u
set -o pipefail
set -x
trap 'echo Cleanup' EXIT
```
