#!/bin/bash

# Set current directory
current_dir="$(cd "$(dirname "$0")" && pwd)"
parent_dir="$(dirname "$current_dir")"
result_dir="$parent_dir/result"

# Create the "result" directory if it doesn't exist
mkdir -p "$result_dir"

# Define log file location
log_file="$result_dir/test_usb_type_a_results.txt"

# Initialize result variables
result=0
test_result="FAIL"  # Default to FAIL

# Define logging function
log() {
    echo "$1" | tee -a "$log_file"
}

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Function to display USB information for all ports
display_usb_info() {
    # Run 'lsusb -t' to get detailed USB device information
    usb_info=$(lsusb -t)

    if [ -z "$usb_info" ]; then
        log "No USB information found."
        result=1
    else
        log "$usb_info"  # Always log the full output of 'lsusb -t'

        # Check if there is at least one line matching the required pattern
        if echo "$usb_info" | grep -qE "Driver=usb-storage, (5000M|480M)"; then
            test_result="PASS"
            echo -e "Test result: ${GREEN}${BOLD}PASS${NC}"
        else
            log "No USB 2.0 or 3.0 device found."
            echo -e "Test result: ${RED}${BOLD}FAIL${NC}"
            result=1
        fi
    fi
}

# Start testing
log "Testing USB TYPE-A (4 ports)"

# Display USB information
display_usb_info

exit $result
