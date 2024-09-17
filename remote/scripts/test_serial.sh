#!/bin/bash

# Set current directory
current_dir="$(cd "$(dirname "$0")" && pwd)"
parent_dir="$(dirname "$current_dir")"
result_dir="$parent_dir/result"

# Create the "result" directory if it doesn't exist
mkdir -p "$result_dir"

# Define function to check if a file exists
serial_file="/etc/adb_devid"

# Define log file location
log_file="$result_dir/test_serial_results.txt"

# Initialize result variable
result=0

# Define logging function
log() {
    echo "$1" | tee -a "$log_file"
}

# Check file exist
file_exists() {
    if [ -f "$1" ]; then
        return 0  # File exists
    else
        return 1  # File does not exist
    fi
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
    echo -e "${RED}${BOLD}FAIL${NC}"
    result=1
    exit $result
fi

# Read serial number from the file
serial_number=$(cat "$serial_file")

# Check if the serial number is empty
if [ -z "$serial_number" ]; then
    log "Serial number is empty."
    echo -e "${RED}${BOLD}FAIL${NC}"
    result=1
else
    log "Serial Number: $serial_number"
    echo -e "${GREEN}${BOLD}PASS${NC}"
fi

exit $result
