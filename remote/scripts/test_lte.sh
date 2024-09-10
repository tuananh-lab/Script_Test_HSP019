#!/bin/bash

# Set current directory
current_dir="$(cd "$(dirname "$0")" && pwd)"
usb_id="2c7c:6005"

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
log "Testing LTE 4G"

# Run the 'lsusb' command and store the output in a variable
lsusb_output=$(lsusb)

# Check for the LTE 4G device in the output
if echo "$lsusb_output" | grep -q "$usb_id"; then
    log "LTE 4G device found:"
else
    echo "LTE_4G_DEVICE_NOT_FOUND"
    result=1
fi

log "LTE 4G test done"
exit $result
