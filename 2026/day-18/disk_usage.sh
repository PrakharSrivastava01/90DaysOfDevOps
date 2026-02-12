#!/bin/bash

disk_check() {
 cd /
 space=$(df -h)
 echo " $space "
}

memory_check() {
    cd /
    memory=$(free -h)
    echo "$memory"
}

main() {
disk_check
memory_check
}

main