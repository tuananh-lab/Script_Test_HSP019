#!/bin/bash

# Set current directory
current_dir="$(cd "$(dirname "$0")" && pwd)"
nvme_device="/dev/nvme0n1"

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
log "Testing NVMe"

# Check if the NVMe device exists
if ! file_exists "$nvme_device"; then
    log "NVMe device $nvme_device does not exist."
    echo "NVME_DEVICE_NOT_FOUND"
    result=1
    exit $result
fi

# Get detailed information about the NVMe device
nvme_info=$(ls -l "$nvme_device")

if [ -z "$nvme_info" ]; then
    log "No information available for $nvme_device."
    echo "NVME_INFO_ERROR"
    result=1
else
    log "NVMe Device Information:"
    echo "NVME_DEVICE_OK: $nvme_info"
fi

log "NVMe test done"
exit $result
