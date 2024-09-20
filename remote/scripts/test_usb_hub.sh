#!/bin/bash

# Set current directory
current_dir="$(cd "$(dirname "$0")" && pwd)"
parent_dir="$(dirname "$current_dir")"
result_dir="$parent_dir/result"

# Create the "result" directory if it doesn't exist
mkdir -p "$result_dir"

# Define log file location
log_file="$result_dir/test_usb_hub_results.txt"

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

# Start testing
log "Testing USB Hub"

# Run 'lsusb' and filter for lines containing "Microchip Technology"
usb_devices=$(lsusb | grep "Microchip Technology")

# Check if any results were found
if [ -z "$usb_devices" ]; then
    log "No Microchip Technology devices found."
    echo "NO_MICROCHIP_DEVICES_FOUND"
    echo -e "Test result: ${RED}${BOLD}FAIL${NC}"
    result=1
else
    log "Microchip Technology Devices Found:"
    echo "$usb_devices"
    test_result="PASS"
    echo -e "Test result: ${GREEN}${BOLD}PASS${NC}"
fi

exit $result
