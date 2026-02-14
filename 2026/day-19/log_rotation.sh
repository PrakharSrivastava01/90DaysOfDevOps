#!/bin/bash
<< help
This script will take a backup
help

source="$1"
destination="$2"
timestamp=$(date +"%Y%m%d%H%M%S")

function log_read() {

        zip -r "${destination}/backup_${timestamp}.zip" "${source}" 2> /dev/null

        if [ $? -eq 0 ];then

        echo "backup taken successfully..!"

        fi
}
function log_rotation() {

        backup=($(ls -t "${destination}/backup_"*.zip 2>/dev/null))
        echo "${backup[@]}"
}
log_rotation
log_read $1 $2