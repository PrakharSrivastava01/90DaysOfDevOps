# Day 26 – GitHub CLI Notes

## Task 1: Install and Authenticate

### Installation
```bash

# Ubuntu/Debian
sudo apt install gh

# Windows (winget)
winget install --id GitHub.cli
```

### Authentication
```bash
gh auth login
# Follow interactive prompts: select GitHub.com, HTTPS, browser/token auth

# Verify login
gh auth status
```

### What authentication methods does `gh` support?

`gh` supports two main authentication methods:

1. **Web browser (OAuth)** — `gh auth login` opens a browser and authenticates via GitHub OAuth. Easiest for interactive use.
2. **Personal Access Token (PAT)** — Paste a token directly; ideal for headless/CI environments (`gh auth login --with-token < token.txt`).
3. **GitHub Enterprise Server** — Both methods above work against a GHE instance using `gh auth login --hostname your.ghe.host`.
4. **Environment variable** — Set `GH_TOKEN` (or `GITHUB_TOKEN`) and `gh` will use it automatically without interactive login. Perfect for CI/CD pipelines.

---

## Task 2: Working with Repositories

### Commands used

```bash
# Create a new public repo with README
gh repo create my-test-repo --public --add-readme --description "CLI test repo"

# Clone a repo using gh
gh repo clone owner/repo-name

# View repo details
gh repo view owner/repo-name

# List all your repos
gh repo list

# List with more detail and limit
gh repo list --limit 50 --json name,description,isPrivate

# Open repo in browser
gh repo view --web

# Delete test repo
gh repo delete my-test-repo --yes
```

### Observations
- `gh repo create` handles repo creation AND initial push in one command — no need to go to github.com.
- `gh repo clone` is just a thin wrapper around `git clone` but saves typing the full URL.
- `gh repo view` gives a clean terminal summary: description, stars, forks, open issues, language.
- `--json` flag combined with `jq` makes output scriptable: `gh repo list --json name,url | jq '.[].url'`

---

## Task 3: Issues

### Commands used

```bash
# Create issue with title, body, and label
gh issue create --title "Fix login bug" --body "Users cannot log in with SSO enabled." --label bug

# List open issues
gh issue list

# View a specific issue
gh issue view 1

# Close an issue
gh issue close 1

# Reopen an issue
gh issue reopen 1
```

### How could you use `gh issue` in scripts/automation?

Scripting potential is huge:

- **Auto-create issues from failed tests/monitors** — a CI job or alerting webhook can call `gh issue create` when a threshold is breached, keeping engineering teams in the loop without manual work.
- **Bulk triage** — loop over `gh issue list --json number,labels` and `gh issue edit` to relabel/close stale issues programmatically.
- **Release tracking** — after merging, auto-close related issues with `gh issue close $(gh issue list --label "in-release" --json number -q '.[].number')`.
- **Reporting dashboards** — `gh issue list --json title,createdAt,assignees --repo org/repo` piped to a script generates metrics without hitting the API rate limit manually.
- **Cross-repo syncing** — mirror issues between a public and private repo using `gh issue list` + `gh issue create`.

---

## Task 4: Pull Requests

### Commands used

```bash
# Full PR workflow from terminal
git checkout -b feat/my-feature
echo "# change" >> README.md
git add . && git commit -m "feat: add new section to README"
git push -u origin feat/my-feature

# Create PR (auto-fill title/body from commit)
gh pr create --fill

# Or with explicit fields
gh pr create --title "feat: add README section" --body "Adds new content" --base main

# List open PRs
gh pr list

# View PR details (status, checks, reviewers)
gh pr view 1

# Check PR status (CI checks)
gh pr checks 1

# Merge PR
gh pr merge 1 --merge      # merge commit
gh pr merge 1 --squash     # squash and merge
gh pr merge 1 --rebase     # rebase and merge

# Auto-merge when checks pass
gh pr merge 1 --squash --auto
```

### What merge methods does `gh pr merge` support?

Three methods, matching GitHub's UI options:
1. **`--merge`** — Creates a merge commit (preserves full branch history).
2. **`--squash`** — Squashes all branch commits into one commit on the base branch (clean history).
3. **`--rebase`** — Replays commits on top of the base branch with no merge commit (linear history).

Add `--auto` to any of these to enable auto-merge, which waits for required status checks to pass before merging automatically.

### How would you review someone else's PR using `gh`?

```bash
# Check out the PR locally for testing
gh pr checkout 42

# View diff in terminal
gh pr diff 42

# Leave a review comment
gh pr review 42 --comment --body "Looks good, just one nit."

# Approve the PR
gh pr review 42 --approve

# Request changes
gh pr review 42 --request-changes --body "Please add unit tests for the new function."
```

---

## Task 5: GitHub Actions & Workflows

### Commands used

```bash
# List workflow runs on a repo
gh run list --repo cli/cli

# View a specific run (get ID from list output)
gh run view 12345678

# Watch a run in real time
gh run watch 12345678

# View logs of a run
gh run view 12345678 --log

# List workflows
gh workflow list

# Manually trigger a workflow
gh workflow run deploy.yml --field environment=staging
```

### How could `gh run` and `gh workflow` be useful in a CI/CD pipeline?

- **Pipeline chaining** — Trigger a downstream deploy workflow after a build completes: `gh workflow run deploy.yml --ref main --field env=prod`. Replaces complex webhook setups.
- **Status polling** — In a script, poll `gh run list --workflow=ci.yml --json status,conclusion -q '.[0].conclusion'` until it's `success` before proceeding to the next deployment stage.
- **Incident response** — During an outage, quickly rerun the last failed workflow: `gh run rerun $(gh run list --status failure --limit 1 --json databaseId -q '.[0].databaseId')`.
- **Audit trail** — Export run history to JSON: `gh run list --limit 100 --json name,status,conclusion,createdAt` for reporting.
- **Manual gates** — Use `gh workflow run` to trigger environment-specific deployments as manual approval steps instead of building UI approval flows.

---

## Task 6: Useful `gh` Tricks

### `gh api` — Raw API calls
```bash
# GET request to any GitHub API endpoint
gh api repos/cli/cli/releases/latest

# POST (create a label)
gh api repos/OWNER/REPO/labels \
  --method POST \
  --field name=urgent \
  --field color=ff0000

# Use with jq for filtering
gh api /user/repos --paginate --jq '.[].full_name'
```
**Best use:** When `gh` doesn't have a subcommand for something, `gh api` gives you the full GitHub REST API with your auth already wired in. Also supports GraphQL via `gh api graphql -f query='...'`.

### `gh gist` — Manage Gists
```bash
# Create a gist from a file
gh gist create script.sh --public --desc "Useful deployment script"

# Create from stdin
echo "export PATH=\$PATH:/usr/local/bin" | gh gist create --filename .bashrc_snippet

# List your gists
gh gist list

# View a gist
gh gist view <gist-id>
```

### `gh release` — Manage Releases
```bash
# Create a release with auto-generated notes
gh release create v1.2.0 --generate-notes

# Upload artifacts
gh release create v1.2.0 ./dist/app-linux ./dist/app-darwin --title "v1.2.0"

# List releases
gh release list

# Download a release asset
gh release download v1.2.0 --pattern "*.tar.gz"
```

### `gh alias` — Custom Shortcuts
```bash
# Create alias
gh alias set prc 'pr create --fill'
gh alias set ilist 'issue list --assignee @me'

# List aliases
gh alias list

# Delete alias
gh alias delete prc
```

### `gh search` — Search GitHub
```bash
# Search repos
gh search repos "kubernetes operator" --language go --stars ">1000"

# Search issues across GitHub
gh search issues "memory leak" --repo cli/cli --state open

# Search code
gh search code "TODO: fixme" --language python --owner myorg
```

---

## Key Takeaways

- `gh` eliminates browser context-switching — the whole PR review cycle (create branch → push → open PR → check CI → merge) stays in the terminal.
- The `--json` flag + `jq` turns every `gh` command into a scriptable data source.
- `gh api` is an escape hatch to the full GitHub REST/GraphQL API with zero auth setup.
- For DevOps, `gh workflow run` + `gh run watch` enables powerful pipeline orchestration from scripts or Makefiles.
- `GH_TOKEN` env var makes `gh` fully CI-native — no interactive login needed in pipelines.
