#!/bin/bash

# Set current directory
current_dir="$(cd "$(dirname "$0")" && pwd)"
parent_dir="$(dirname "$current_dir")"
result_dir="$parent_dir/result"

# Create the "result" directory if it doesn't exist
mkdir -p "$result_dir"

# Define USB ID of the LTE 4G device
usb_id="2c7c:6005"

# Define log file location
log_file="$result_dir/test_lte_results.txt"

# Initialize result variable
result=0

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Define logging function
log() {
    echo "$1" | tee -a "$log_file"
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
    log "LTE 4G DEVICE FOUND:"
    echo -e "${GREEN}${BOLD}PASS${NC}"
else
    echo "LTE_4G_DEVICE_NOT_FOUND"
    echo -e "${RED}${BOLD}FAIL${NC}"
    result=1
fi

exit $result
