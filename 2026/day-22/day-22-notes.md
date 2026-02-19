# Day 22 – Introduction to Git (Notes)

## 1️⃣ Difference between `git add` and `git commit`

* `git add` moves changes from the working directory to the staging area.
* `git commit` permanently records staged changes in the repository with a message.

---

## 2️⃣ What is the Staging Area?

The staging area acts as a buffer between working directory and repository. It allows selective commits instead of committing everything at once.

---

## 3️⃣ What does `git log` show?

It displays commit history including:

* Commit hash
* Author name
* Date
* Commit message

---

## 4️⃣ What is the `.git/` folder?

It is the hidden directory where Git stores:

* Commit history
* Branch references
* Configuration
* Object database

If deleted, the project loses its version history and becomes a normal folder.

---

## 5️⃣ Working Directory vs Staging Area vs Repository

* **Working Directory** → Where you edit files.
* **Staging Area** → Where changes are prepared before commit.
* **Repository** → Where committed snapshots are permanently stored.

Workflow Summary:
Working Directory → Staging Area → Repository

---

## What I Understood Today

* Git tracks changes as snapshots, not file differences.
* Clean commit messages improve project readability.
* `git status` is the most important command while learning Git.
