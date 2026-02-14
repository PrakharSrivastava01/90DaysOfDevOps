#!/bin/bash

function rotate_logs() {

    if [ ! -d "$1" ]; then
        echo "Directory not found"
        exit 1
    fi

    echo "Compressing logs older than 7 days..."
    find "$1" -type f -name "*.log" -mtime +7 -exec gzip {} \;

    echo "Deleting logs older than 30 days..."
    find "$1" -type f -name "*.gz" -mtime +30 -delete

    echo "Log rotation complete"
}

rotate_logs $1