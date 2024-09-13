#!/bin/bash

# Set current directory
current_dir="$(cd "$(dirname "$0")" && pwd)"

# Initialize result variable
result=0

# Define logging function
log() {
    echo "$1"
}

# Define function to check if a file exists
file_exists() {
    [ -e "$1" ]
}
# Start testing
log "Testing power"
log "Please plug in the power cord and check the console log"
log "Account to login is root, password is oelinux123"
log "Power test done"
exit $result