#!/bin/bash

# Set current directory
current_dir="$(cd "$(dirname "$0")" && pwd)"

# Initialize result variable
result=0

# Define logging function
log() {
            echo "$1"
    }

# Start testing
log "Testing ROM"

# Extract the 'Size' column for the '/' mount point
total_flash=$(df -h | awk '$NF == "/" {print $2}')

# Print the total flash size 
log "Total Flash: ${total_flash}"

log "ROM test done"
exit $result
