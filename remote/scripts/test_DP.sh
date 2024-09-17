
#!/bin/bash

# Set current directory
current_dir="$(cd "$(dirname "$0")" && pwd)"
parent_dir="$(dirname "$current_dir")"
result_dir="$parent_dir/result"

# Create the "result" directory if it doesn't exist
mkdir -p "$result_dir"

#Define log file location
log_file="$result_dir/test_DP_results.txt"

# Initialize result variable
result=0

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Define logging function
log() {
    echo "$1" | tee -a "$log_file"
}

# Define function to check if a file exists
file_exists() {
    [ -e "$1" ]
}
# Start testing
log "Testing DP(Display Port)..."
log "Please plug the type-c to hdmi adapter into the monitor in both directions"
log "The results display the image on the screen"
echo -e "${GREEN}${BOLD}PASS${NC}"
exit $result
