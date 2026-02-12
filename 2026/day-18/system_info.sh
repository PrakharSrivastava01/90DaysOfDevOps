#!/bin/bash
set -euo pipefail

host() {
        hostname_info=$(hostname)
        os_info=$(uname -a)
echo "$hostname_info & $os_info"
}
sys_uptime() {
        uptime=$(uptime)
        echo "$uptime"
}
disc_usage_size() {
        disc_usage=$(df -h | sort -rh | head -5)
        echo "$disc_usage"
}
memory_usage() {
        mem_use=$(free -h)
        echo "$mem_use"
}
cpu_cons() {
        cpu_consumption=$(ps aux --sort=-%cpu | head -n 5)
        echo "$cpu_consumption"
}
main() {
host
sys_uptime
disc_usage_size
memory_usage
cpu_cons
}
main