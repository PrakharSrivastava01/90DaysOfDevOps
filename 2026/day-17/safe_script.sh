#!/bin/bash

set -e  # Exit immediately if any command fails

DIR="/tmp/devops-test"
FILE="test-file.txt"

# Create directory
mkdir -p "$DIR" || { echo "Failed to create directory"; exit 1; }

# Navigate into directory
cd "$DIR" || { echo "Failed to enter directory"; exit 1; }

# Create file
touch "$FILE" || { echo "Failed to create file"; exit 1; }

echo "Script completed successfully"