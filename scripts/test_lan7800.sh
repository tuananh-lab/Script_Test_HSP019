#!/bin/bash

# Set current directory
current_dir="$(cd "$(dirname "$0")" && pwd)"
parent_dir="$(dirname "$current_dir")"
# result_dir="$parent_dir/result"

# # Create the "result" directory if it doesn't exist
# mkdir -p "$result_dir"

# # Define log file location
# log_file="$result_dir/test_lan7800_results.txt"

# Initialize result variable
result=0
test_result="FAIL"  # Default to FAIL

# Define logging function
log() {
    echo "$1"
}

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Start testing
log "Testing LAN7800"

# Run the 'ifconfig' command and store the output in a variable
ifconfig_output=$(ifconfig eth0 2>/dev/null)

# Check if 'ifconfig' command succeeded and contains an IP address
if echo "$ifconfig_output" | grep -q "inet "; then
    log "Network interface eth0 has an IP address:"
    log "$ifconfig_output"
    test_result="PASS"
else
    log "Network interface eth0 does not have an IP address or is not found."
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


