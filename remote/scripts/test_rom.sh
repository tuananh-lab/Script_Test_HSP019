#!/bin/bash

# Set current directory
current_dir="$(cd "$(dirname "$0")" && pwd)"
parent_dir="$(dirname "$current_dir")"
result_dir="$parent_dir/result"

# Create the "result" directory if it doesn't exist
mkdir -p "$result_dir"

# Define log file location
log_file="$result_dir/test_rom_results.txt"

# Initialize result variable
result=0

# Define logging function
log() {
            echo "$1" | tee -a "$log_file"
    }

# Start testing
log "Testing ROM"

# Extract the 'Size' column for the '/' mount point
total_flash=$(df -h | awk '$NF == "/" {print $2}')

# Print the total flash size 
log "Total Flash: ${total_flash}"

log "ROM test done"
exit $result
