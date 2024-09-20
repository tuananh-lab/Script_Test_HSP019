#!/bin/bash

# Set current directory
current_dir="$(cd "$(dirname "$0")" && pwd)"
parent_dir="$(dirname "$current_dir")"
result_dir="$parent_dir/result"

# Create the "result" directory if it doesn't exist
mkdir -p "$result_dir"

# Define log file location
log_file="$result_dir/test_ram_results.txt"

# Initialize result variable
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
log "Testing RAM"

# Run the 'free -h' command and store the output in a variable
if ! free_output=$(free -h); then
    log -e "${RED}Error: Failed to run 'free -h' command.${NC}"
    result=1
else
    # Extract the total memory using awk
    total_memory=$(echo "$free_output" | awk '/^Mem:/ {print $2}')
    if [ -z "$total_memory" ]; then
        log -e "${RED}Error: Failed to extract total memory.${NC}"
        result=1
    else
        # Print the total memory
        log "Total Memory: $total_memory"
        test_result="PASS"
    fi
fi

# Print the result with color and bold
if [ "$test_result" == "FAIL" ]; then
    echo -e "Test result: ${RED}${BOLD}FAIL${NC}"
else
    echo -e "Test result:${GREEN}${BOLD}PASS${NC}"
fi

exit $result
