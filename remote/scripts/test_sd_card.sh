#!/bin/bash

# Set current directory
current_dir="$(cd "$(dirname "$0")" && pwd)"
sd_device="/dev/mmcblk1p1"

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
log "Testing SD Card"

# Check if the SD device exists
if ! file_exists "$sd_device"; then
    log "SD device $sd_device does not exist."
    echo "SD_DEVICE_NOT_FOUND"
    result=1
else
    # Get detailed information about the SD device
    sd_info=$(ls -l "$sd_device")

    if [ -z "$sd_info" ]; then
        log "No information available for $sd_device."
        echo "SD_DEVICE_INFO_ERROR"
        result=1
    else
        log "SD Device Information:"
        log "$sd_info"
    fi
fi

log "SD Card test done"
exit $result
