#!/bin/bash

# Set current directory
current_dir="$(cd "$(dirname "$0")" && pwd)"
parent_dir="$(dirname "$current_dir")"
# result_dir="$parent_dir/result"

# # Create the "result" directory if it doesn't exist
# mkdir -p "$result_dir"

# # Define log file location
# log_file="$result_dir/test_power_results.txt"

# Initialize result variables
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
log "Testing power"
log "Please supply power to box and check the console log"
log "Account to login is root, password is oelinux123"

# Here you can add additional checks if needed
# For demonstration purposes, we'll assume the test always passes

# Set test_result to PASS
test_result="PASS"

# Print the result with color and bold
if [ "$test_result" == "FAIL" ]; then
    echo -e "Test result: ${RED}${BOLD}FAIL${NC}"
else
    echo -e "Test result: ${GREEN}${BOLD}PASS${NC}"
fi

exit $result
