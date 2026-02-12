#!/bin/bash

set -euo pipefail

# set -e ( it will throw an error as 2nd statement will fail )
mkdir file
mkdir file
touch hello

# set -u ( it will throw an error as variable is not defined )
echo $name

# set -o pipefail ( it will throw an error as 2nd statement will fail )

ls -l | grep "file"
