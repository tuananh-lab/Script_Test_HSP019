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
log "Testing RAM"

# Run the 'free -h' command and store the output in a variable
free_output=$(free -h)

# Extract the total memory using awk
total_memory=$(echo "$free_output" | awk '/^Mem:/ {print $2}')

# Print the total memory
log "Total Memory: $total_memory"

log "RAM test done"
exit $result
