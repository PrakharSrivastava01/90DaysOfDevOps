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
# Git & GitHub CLI Command Reference

---

## Core Git Commands

```bash
git init                          # Initialize a new local repo
git clone <url>                   # Clone a remote repo
git status                        # Show working tree status
git add <file>                    # Stage a file
git add .                         # Stage all changes
git commit -m "message"           # Commit staged changes
git push origin <branch>          # Push branch to remote
git pull                          # Fetch + merge remote changes
git fetch                         # Fetch without merging
git merge <branch>                # Merge a branch into current
git rebase <branch>               # Rebase current onto branch
git log --oneline --graph         # Visual branch history
git diff                          # Show unstaged changes
git stash                         # Stash uncommitted changes
git stash pop                     # Restore stashed changes
git tag v1.0.0                    # Create a lightweight tag
git tag -a v1.0.0 -m "Release"   # Annotated tag
```

---

## GitHub CLI (`gh`) Commands

### Auth
```bash
gh auth login                     # Authenticate (browser or token)
gh auth status                    # Show active account
gh auth logout                    # Log out
# CI/CD: set GH_TOKEN env var — no interactive login needed
```

### Repos
```bash
gh repo create <name> --public --add-readme   # Create public repo with README
gh repo clone <owner/repo>                    # Clone a repo
gh repo view [owner/repo]                     # View repo details in terminal
gh repo view --web                            # Open repo in browser
gh repo list                                  # List your repos
gh repo list --limit 50 --json name,url       # List as JSON
gh repo delete <name> --yes                   # Delete a repo
```

### Issues
```bash
gh issue create --title "Title" --body "Body" --label bug   # Create issue
gh issue list                                               # List open issues
gh issue list --assignee @me                               # Issues assigned to you
gh issue view <number>                                      # View issue details
gh issue close <number>                                     # Close an issue
gh issue reopen <number>                                    # Reopen an issue
gh issue edit <number> --add-label priority                # Edit issue labels
# Scripting: pipe --json output to jq for bulk ops
```

### Pull Requests
```bash
gh pr create --fill                           # Create PR (auto-fill from commits)
gh pr create --title "Title" --base main      # Create PR with explicit fields
gh pr list                                    # List open PRs
gh pr view <number>                           # View PR details
gh pr checks <number>                         # View CI check status
gh pr diff <number>                           # View PR diff in terminal
gh pr checkout <number>                       # Check out PR branch locally
gh pr review <number> --approve               # Approve a PR
gh pr review <number> --request-changes --body "Feedback"  # Request changes
gh pr review <number> --comment --body "Comment"           # Leave a comment
gh pr merge <number> --merge                  # Merge commit
gh pr merge <number> --squash                 # Squash and merge
gh pr merge <number> --rebase                 # Rebase and merge
gh pr merge <number> --squash --auto          # Auto-merge when checks pass
```

### GitHub Actions & Workflows
```bash
gh run list                                   # List recent workflow runs
gh run list --repo owner/repo                 # Runs for a specific repo
gh run view <run-id>                          # View run details
gh run view <run-id> --log                    # View run logs
gh run watch <run-id>                         # Watch run in real time
gh run rerun <run-id>                         # Rerun a failed run
gh workflow list                              # List workflows
gh workflow run <workflow.yml>                # Trigger a workflow manually
gh workflow run <workflow.yml> --field env=prod  # Trigger with inputs
```

### Raw API
```bash
gh api /user                                  # GET current user
gh api repos/OWNER/REPO/releases/latest       # GET latest release
gh api repos/OWNER/REPO/labels \
  --method POST \
  --field name=urgent \
  --field color=ff0000                        # POST (create label)
gh api graphql -f query='{ viewer { login } }' # GraphQL query
gh api /user/repos --paginate --jq '.[].full_name'  # Paginate + filter
```

### Gists
```bash
gh gist create file.sh --public --desc "Description"  # Create gist
gh gist create --filename snippet.sh                   # Create from stdin
gh gist list                                           # List your gists
gh gist view <gist-id>                                 # View a gist
gh gist edit <gist-id>                                 # Edit a gist
```

### Releases
```bash
gh release create v1.0.0 --generate-notes             # Create release (auto-notes)
gh release create v1.0.0 ./dist/* --title "v1.0.0"    # Create with artifacts
gh release list                                        # List releases
gh release download v1.0.0 --pattern "*.tar.gz"        # Download release asset
```

### Aliases (Custom Shortcuts)
```bash
gh alias set prc 'pr create --fill'           # Create alias
gh alias set ilist 'issue list --assignee @me'
gh alias list                                 # List aliases
gh alias delete prc                           # Delete alias
```

### Search
```bash
gh search repos "kubernetes operator" --language go --stars ">1000"
gh search issues "memory leak" --repo cli/cli --state open
gh search code "TODO" --language python --owner myorg
```

---

## Useful Flags (Work with Most Commands)

| Flag | Purpose |
|------|---------|
| `--repo owner/repo` | Target a specific repo |
| `--json field1,field2` | Machine-readable JSON output |
| `--jq '.expression'` | Filter JSON output inline |
| `--web` | Open result in browser |
| `--limit N` | Limit number of results |

---

## Scripting Patterns

```bash
# Get latest run conclusion
gh run list --workflow=ci.yml --limit 1 --json conclusion -q '.[0].conclusion'

# Close all issues with a label
gh issue list --label stale --json number -q '.[].number' \
  | xargs -I{} gh issue close {}

# Create release after CI passes
gh run watch $(gh run list --limit 1 --json databaseId -q '.[0].databaseId')
gh release create v$(date +%Y%m%d) --generate-notes
```




## Help

### git help <command>

Open manual for a command.

```bash
git help commit
```

