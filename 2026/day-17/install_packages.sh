#!/bin/bash

# Define packages
packages=("nginx" "curl" "wget")

echo "Checking package status..."

# Update package lists once
echo "Updating package lists..."
sudo apt-get update >/dev/null 2>&1

# Install missing packages
for package in "${packages[@]}"; do
    if dpkg -s "$package" >/dev/null 2>&1; then
        echo "$package - Already installed"
	sudo systemctl status $package
    else
        echo "$package - Installing..."
        if sudo apt-get install -y "$package" >/dev/null 2>&1; then
            echo "$package - Installed successfully"
        else
            echo "$package - Installation failed"
        fi
    fi
done

echo "All packages processed!"

