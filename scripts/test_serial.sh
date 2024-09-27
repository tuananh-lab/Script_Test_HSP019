#!/bin/bash

# Set current directory
current_dir="$(cd "$(dirname "$0")" && pwd)"
parent_dir="$(dirname "$current_dir")"
# result_dir="$parent_dir/result"

# # Create the "result" directory if it doesn't exist
# mkdir -p "$result_dir"

# Define function to check if a file exists
serial_file="/etc/adb_devid"

# # Define log file location
# log_file="$result_dir/test_serial_results.txt"

# Initialize result variables
result=0
test_result="FAIL"  # Default to FAIL

# Define logging function
log() {
    echo "$1"
}

# Check file existence
file_exists() {
    [ -f "$1" ]
}

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Start testing
log "Testing Serial Port"

# Check if the serial file exists
if ! file_exists "$serial_file"; then
    log "Serial file $serial_file does not exist."
    echo "SERIAL_FILE_NOT_FOUND"
    echo -e "Test result: ${RED}${BOLD}FAIL${NC}"
    result=1
else
    # Read serial number from the file
    serial_number=$(cat "$serial_file")

    # Check if the serial number is empty
    if [ -z "$serial_number" ]; then
        log "Serial number is empty."
        echo -e "Test result: ${RED}${BOLD}FAIL${NC}"
        result=1
    else
        test_result="PASS"
        # In addition to showing PASS, we also print the serial_number in a format that testfull.sh can easily parse
        echo -e "serial_number: $serial_number"  # This line will be captured by testfull.sh
        echo -e "Test result: ${GREEN}${BOLD}PASS${NC}"
    fi
fi

exit $result
