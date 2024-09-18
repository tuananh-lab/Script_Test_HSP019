#!/bin/bash

# Set current directory
current_dir="$(cd "$(dirname "$0")" && pwd)"
parent_dir="$(dirname "$current_dir")"
result_dir="$parent_dir/result"

# Create the "result" directory if it doesn't exist
mkdir -p "$result_dir"

# Define log file location
log_file="$result_dir/test_rom_results.txt"

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
log "Testing ROM"

# Extract the 'Size' column for the '/' mount point
total_flash=$(df -h | awk '$NF == "/" {print $2}')

# Check if the extraction was successful
if [ -z "$total_flash" ]; then
    log -e "${RED}Error: Failed to extract total flash size.${NC}"
    result=1
    exit $result
fi

# Print the total flash size 
log "Total Flash: ${total_flash}"

echo -e "${GREEN}${BOLD}PASS${NC}"
exit $result
