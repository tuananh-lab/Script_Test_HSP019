#!/bin/bash

# Set current directory
current_dir="$(cd "$(dirname "$0")" && pwd)"
parent_dir="$(dirname "$current_dir")"
result_dir="$parent_dir/result"

# Create the "result" directory if it doesn't exist
mkdir -p "$result_dir"

# Define log file location
log_file="$result_dir/test_ram_results.txt"

# Initialize result variable
result=0

# Define logging function
log() {
    echo "$1" | tee -a "$log_file"
}

# Start testing
log "Testing RAM"

# Run the 'free -h' command and store the output in a variable
free_output=$(free -h)

# Extract the total memory using awk
total_memory=$(echo "$free_output" | awk '/^Mem:/ {print $2}')

# Print the total memory
log "Total Memory: $total_memory"

log "RAM test done"
exit $result
