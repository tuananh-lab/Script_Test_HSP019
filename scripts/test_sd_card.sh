#!/bin/bash

# Set current directory
current_dir="$(cd "$(dirname "$0")" && pwd)"
parent_dir="$(dirname "$current_dir")"
# result_dir="$parent_dir/result"

# # Create the "result" directory if it doesn't exist
# mkdir -p "$result_dir"

# Define SD card device
sd_device="/dev/mmcblk1p1"

# # Define log file location
# log_file="$result_dir/test_sd_card_results.txt"

# Initialize result variable
result=0
test_result="FAIL"  # Default to FAIL

# Define logging function
log() {
    echo "$1"
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
log "Testing SD Card"

# Check if the SD device exists
if ! file_exists "$sd_device"; then
    log "SD device $sd_device does not exist."
    echo "SD_DEVICE_NOT_FOUND"
    echo -e "Test result: ${RED}${BOLD}FAIL${NC}"
    result=1
else
    # Get detailed information about the SD device
    sd_info=$(ls -l "$sd_device")

    if [ -z "$sd_info" ]; then
        log "No information available for $sd_device."
        echo "SD_DEVICE_INFO_ERROR"
        echo -e "Test result: ${RED}${BOLD}FAIL${NC}"
        result=1
    else
        log "SD Device Information:"
        log "$sd_info"
        test_result="PASS"
        echo -e "Test result: ${GREEN}${BOLD}PASS${NC}"
    fi
fi

exit $result
