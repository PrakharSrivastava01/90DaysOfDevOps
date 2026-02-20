Day 25 – Git Reset vs Revert & Branching Strategies
🚀 Overview

Day 25 is about mastering one of the most important Git skills:

Undoing mistakes safely

Understanding destructive vs non-destructive operations

Learning how real engineering teams manage code using branching strategies

By the end of today, you’ll clearly understand:

git reset vs git revert

When to use each

How to recover lost commits using git reflog

Popular branching strategies used in production

📌 Task Summary
🔹 Task 1: Git Reset — Hands-On

You practiced:

git reset --soft

git reset --mixed

git reset --hard

🔹 Key Observations
Option	What It Does
--soft	Moves HEAD back but keeps changes staged
--mixed (default)	Moves HEAD back, unstages changes, keeps them in working directory
--hard	Moves HEAD back and deletes changes from working directory
🔥 Important

--hard is destructive

Never use reset on pushed/shared branches

Use it safely only on local branches

🔹 Task 2: Git Revert — Hands-On

You learned:

git revert <commit> creates a new commit

It reverses changes without deleting history

The original commit stays in the log

🛡 Why Revert is Safer

It preserves commit history

Safe for shared branches

Ideal for production fixes

🔹 Reset vs Revert Comparison
	git reset	git revert
What it does	Moves branch pointer backward	Creates new commit that undoes changes
Removes commit from history?	Yes	No
Safe for shared branches?	❌ No	✅ Yes
When to use	Local cleanup	Undo pushed commits
🔹 Task 3: Branching Strategies

You researched the following strategies:

1️⃣ GitFlow

Structure:

main
 ├── develop
 │    ├── feature/*
 │    └── release/*
 └── hotfix/*


Used for:

Large teams

Scheduled releases

Enterprise projects

Pros:

Structured workflow

Clear release management

Cons:

Complex

Slower delivery

2️⃣ GitHub Flow

Structure:

main
 └── feature-branch → Pull Request → Merge


Used for:

SaaS

Continuous deployment

Fast-moving teams

Pros:

Simple

Fast iteration

Cons:

Not ideal for versioned releases

3️⃣ Trunk-Based Development

Structure:

main (trunk)
 ├── short-lived branches
 └── frequent merges


Used for:

High-performing teams

CI/CD environments

Pros:

Minimal merge conflicts

Faster feedback

Cons:

Requires strong CI/CD

🎯 Strategy Decision Answers

🚀 Startup shipping fast → GitHub Flow

🏢 Large enterprise with scheduled releases → GitFlow

⚡ High-automation DevOps team → Trunk-Based Development

🔹 Task 4: Git Commands Updated (Days 22–25)

Your git-commands.md now includes:

Setup & Config

git config

git init

Basic Workflow

git add

git commit

git status

git log

git diff

Branching

git branch

git checkout

git switch

Remote

git clone

git push

git pull

git fetch

Merging & Rebasing

git merge

git rebase

Stash & Cherry Pick

git stash

git stash pop

git cherry-pick

Reset & Revert

git reset

git revert

git reflog

🧠 Key Takeaways

git reset rewrites history

git revert preserves history

git reflog can recover almost anything

Branching strategy depends on team size & release model

Never rewrite shared history without understanding consequences
