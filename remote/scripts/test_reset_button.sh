#!/bin/bash

# Set current directory
current_dir="$(cd "$(dirname "$0")" && pwd)"
parent_dir="$(dirname "$current_dir")"
result_dir="$parent_dir/result"

# Create the "result" directory if it doesn't exist
mkdir -p "$result_dir"

# Define GPIO path for the reset button
gpio_path="/sys/class/gpio/gpio360/value"

# Define log file location
log_file="$result_dir/test_reset_button_results.txt"

# Initialize result variable
result=0

# Define logging function
log() {
    echo "$1" | tee -a "$log_file"
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
log "Testing Reset Button"

# Check if the GPIO file exists
if ! file_exists "$gpio_path"; then
    log "GPIO path $gpio_path does not exist."
    echo "GPIO_PATH_NOT_FOUND"
    echo -e "${RED}${BOLD}FAIL${NC}"
    result=1
    exit $result
fi

# Read initial value (should be 1)
initial_value=$(cat "$gpio_path")
log "Initial GPIO value: $initial_value"

if [ "$initial_value" -ne 1 ]; then
    log "Initial GPIO value is not 1. Check the button state."
    echo "INITIAL_VALUE_ERROR"
    echo -e "${RED}${BOLD}FAIL${NC}"
    result=1
    exit $result
fi

# Wait for user to press the reset button
log "Please press the reset button and then press Enter."
read -r

# Read value after pressing the button (should be 0)
pressed_value=$(cat "$gpio_path")
log "GPIO value after pressing the button: $pressed_value"

if [ "$pressed_value" -ne 0 ]; then
    log "GPIO value after pressing the button is not 0. Check the button functionality."
    echo -e "${RED}${BOLD}FAIL${NC}"
    result=1
else
    log "Button functionality is correct. GPIO value after pressing the button is 0."
    echo -e "${GREEN}${BOLD}PASS${NC}"
fi

exit $result
