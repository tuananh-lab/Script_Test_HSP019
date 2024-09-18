#!/bin/bash

# Set current directory
current_dir="$(cd "$(dirname "$0")" && pwd)"
parent_dir="$(dirname "$current_dir")"
result_dir="$parent_dir/result"

# Create the "result" directory if it doesn't exist
mkdir -p "$result_dir"

# Define log file location
log_file="$result_dir/test_lan7800_results.txt"

# Initialize result variable
result=0

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
log "Testing LAN7800"

# Check network connectivity by pinging Google's DNS server with a 2-second timeout
if timeout 2 ping -c 1 8.8.8.8 &>/dev/null; then
    log "Network connectivity OK."

    # Run the 'ifconfig' command and store the output in a variable
    ifconfig_output=$(ifconfig eth0 2>/dev/null)

    # Check if 'ifconfig' command succeeded and contains data
    if [ -z "$ifconfig_output" ]; then
        log "Network interface eth0 not found or has no data."
        echo -e "${RED}${BOLD}FAIL${NC}"
        result=1
    else
        log "Network interface eth0 found:"
        log "$ifconfig_output"
        echo -e "${GREEN}${BOLD}PASS${NC}"
    fi
else
    log "No network connectivity, check plug cable or network configuration."
    echo -e "${RED}${BOLD}FAIL${NC}"
    result=1
fi

exit $result
