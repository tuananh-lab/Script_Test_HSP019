#!/bin/bash

# Set current directory
current_dir="$(cd "$(dirname "$0")" && pwd)"
parent_dir="$(dirname "$current_dir")"
result_dir="$parent_dir/result"

# Create the "result" directory if it doesn't exist
mkdir -p "$result_dir"

# Define log file location
log_file="$result_dir/test_usb_type_a_results.txt"

# Initialize result variable
result=0

# Define logging function
log() {
    echo "$1" | tee -a "$log_file"
}

# Function to display USB information for all ports
display_usb_info() {
    log "Displaying USB information for all ports"

    # Run 'lsusb -t' to get detailed USB device information
    usb_info=$(lsusb -t)

    if [ -z "$usb_info" ]; then
        log "No USB information found."
        result=1
    else
        log "$usb_info"
    fi
}

# Start testing
log "Testing USB TYPE-A (4 ports)"

# Display USB information
display_usb_info

log "USB TYPE-A (4 ports) test done"
exit $result
