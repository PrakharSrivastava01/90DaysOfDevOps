# Git Commands Reference

## Setup & Config

### git --version

Check installed Git version.

```bash
git --version
```

### git config --global user.name

Set your Git username.

```bash
git config --global user.name "Your Name"
```

### git config --global user.email

Set your Git email.

```bash
git config --global user.email "you@example.com"
```

### git config --list

View current Git configuration.

```bash
git config --list
```

---

## Repository Setup

### git init

Initialize a new Git repository.

```bash
git init
```

### git status

Show working directory and staging status.

```bash
git status
```

---

## Basic Workflow

### git add

Stage changes for commit.

```bash
git add file.txt
git add .
```

### git commit

Save staged changes to repository.

```bash
git commit -m "Initial commit"
```

---

## Viewing Changes & History

### git diff

Show unstaged changes.

```bash
git diff
```

### git diff --staged

Show staged changes.

```bash
git diff --staged
```

### git log

View commit history.

```bash
git log
```

### git log --oneline

Compact commit history view.

```bash
git log --oneline
```

---

## Help

### git help <command>

Open manual for a command.

```bash
git help commit
```

