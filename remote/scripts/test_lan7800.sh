#!/bin/bash

# Set current directory
current_dir="$(cd "$(dirname "$0")" && pwd)"
parent_dir="$(dirname "$current_dir")"
result_dir="$parent_dir/result"

# Create the "result" directory if it doesn't exist
mkdir -p "$result_dir"

# Define log file location
log_file="$result_dir/test_lan7800_results.txt"

# Initialize result variable
result=0

# Define logging function
log() {
    echo "$1" | tee -a "$log_file"
}

# Define function to check if a file exists
file_exists() {
    [ -e "$1" ]
}

# Start testing
log "Testing LAN7800"

# Run the 'ifconfig' command and store the output in a variable
ifconfig_output=$(ifconfig eth0 2>/dev/null)

# Check if 'ifconfig' command succeeded and contains data
if [ -z "$ifconfig_output" ]; then
    log "Network interface eth0 not found or has no data."
    result=1
else
    log "Network interface eth0 found:"
    log "$ifconfig_output"
fi

log "LAN7800 test done"
exit $result
