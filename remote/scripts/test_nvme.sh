#!/bin/bash

# Set current directory
current_dir="$(cd "$(dirname "$0")" && pwd)"
parent_dir="$(dirname "$current_dir")"
result_dir="$parent_dir/result"

# Create the "result" directory if it doesn't exist
mkdir -p "$result_dir"

# Define NVMe device
nvme_device="/dev/nvme0n1"

# Define log file location
log_file="$result_dir/test_nvme_results.txt"

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

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Start testing
log "Testing NVMe"

# Check if the NVMe device exists
if ! file_exists "$nvme_device"; then
    log "NVMe device $nvme_device does not exist."
    echo "NVME_DEVICE_NOT_FOUND"
    echo -e "${RED}${BOLD}FAIL${NC}"
    result=1
    exit $result
fi

# Get detailed information about the NVMe device
nvme_info=$(ls -l "$nvme_device")

if [ -z "$nvme_info" ]; then
    log "No information available for $nvme_device."
    echo "NVME_INFO_ERROR"
    echo -e "${RED}${BOLD}FAIL${NC}"
    result=1
else
    log "NVMe Device Information:"
    echo "NVME_DEVICE_OK: $nvme_info"
    echo -e "${GREEN}${BOLD}PASS${NC}"
fi

exit $result
