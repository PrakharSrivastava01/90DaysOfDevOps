#!/bin/bash

echo "===== HEALTH CHECK : $(date) ====="

# CPU Load
echo "CPU Load:"
uptime

# Memory usage
echo "Memory Usage:"
free -h

# Disk usage
echo "Disk Usage:"
df -h /

# Check nginx
echo "Nginx Status:"
systemctl is-active nginx

echo "=================================="
echo ""
