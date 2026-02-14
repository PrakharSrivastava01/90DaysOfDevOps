#!/bin/bash

source="$1"
destination="$2"
timestamp=$(date +"%Y-%m-%d-%H-%M")
archive="backup-$timestamp.tar.gz"

function create_backup() {

    if [ ! -d "$source" ]; then
        echo "Source directory not found"
        exit 1
    fi

    if [ ! -d "$destination" ]; then
        echo "Destination directory not found"
        exit 1
    fi

    echo "Creating backup..."

    tar -czf "$destination/$archive" "$source" 2>/dev/null

    if [ $? -eq 0 ]; then
        echo "Backup created successfully"
    else
        echo "Backup failed"
        exit 1
    fi
}

function verify_backup() {

    if [ -f "$destination/$archive" ]; then
        size=$(du -h "$destination/$archive" | cut -f1)
        echo "Backup file: $archive"
        echo "Backup size: $size"
    else
        echo "Backup verification failed"
        exit 1
    fi
}

function delete_old_backups() {

    echo "Deleting backups older than 14 days..."

    deleted=$(find "$destination" -name "backup-*.tar.gz" -mtime +14 | wc -l)

    find "$destination" -name "backup-*.tar.gz" -mtime +14 -delete

    echo "Old backups deleted: $deleted"
}

create_backup
verify_backup
delete_old_backups
