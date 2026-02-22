#!/bin/bash

set -e

REPO_NAME="auto-gh-demo-$(date +%s)"
BRANCH_NAME="feature/update-readme"

echo "🚀 Creating repository..."
gh repo create "$REPO_NAME" --public --clone --add-readme

cd "$REPO_NAME"

echo "🛠 Adding GitHub Actions workflow..."

mkdir -p .github/workflows

cat <<EOF > .github/workflows/ci.yml
name: CI

on:
  pull_request:
  push:
    branches:
      - main

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Simulate CI
        run: echo "CI Passed"
EOF

git add .
git commit -m "Add CI workflow"
git push origin main

echo "🌿 Creating feature branch..."
git checkout -b "$BRANCH_NAME"

echo "Updating README..."
echo "Updated automatically via script." >> README.md

git add README.md
git commit -m "Update README via automation"
git push -u origin "$BRANCH_NAME"

echo "📬 Creating Pull Request..."
PR_URL=$(gh pr create \
  --title "Automated PR" \
  --body "This PR was created automatically via script." \
  --base main \
  --head "$BRANCH_NAME")

echo "PR Created: $PR_URL"

echo "⏳ Waiting for CI to complete..."

sleep 10

RUN_ID=$(gh run list --limit 1 --json databaseId -q '.[0].databaseId')

gh run watch "$RUN_ID"

STATUS=$(gh run view "$RUN_ID" --json conclusion -q '.conclusion')

if [[ "$STATUS" == "success" ]]; then
    echo "✅ CI Passed. Merging PR..."
    gh pr merge --merge --delete-branch
else
    echo "❌ CI Failed. Creating Issue..."

    gh issue create \
      --title "🚨 CI Failed for Automated PR" \
      --body "The CI pipeline failed for PR: $PR_URL  
      
Run ID: $RUN_ID  
Please investigate the failure logs." \
      --label bug

    echo "📝 Issue created for failed CI."
fi

echo "🎉 Automation Complete!"
