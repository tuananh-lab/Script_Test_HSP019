#!/bin/bash

# Set current directory
current_dir="$(cd "$(dirname "$0")" && pwd)"
parent_dir="$(dirname "$current_dir")"
# result_dir="$parent_dir/result"

# # Create the "result" directory if it doesn't exist
# mkdir -p "$result_dir"

# Define USB ID of the LTE 4G device
usb_id="2c7c:6005"

# # Define log file location
# log_file="$result_dir/test_lte_results.txt"

# Initialize result variable
result=0
test_result="FAIL"  # Default to FAIL

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Define logging function
log() {
    echo "$1"
}

# Start testing
log "Testing LTE 4G"

# Run the 'lsusb' command and store the output in a variable
lsusb_output=$(lsusb)

# Check for the LTE 4G device in the output
if echo "$lsusb_output" | grep -q "$usb_id"; then
    log "LTE 4G DEVICE FOUND:"
    test_result="PASS"
else
    log "LTE 4G DEVICE NOT FOUND"
    test_result="FAIL"
    result=1
fi

# Print the result with color and bold
if [ "$test_result" == "FAIL" ]; then
    echo -e "Test result: ${RED}${BOLD}FAIL${NC}"
else
    echo -e "Test result: ${GREEN}${BOLD}PASS${NC}"
fi

exit $result
