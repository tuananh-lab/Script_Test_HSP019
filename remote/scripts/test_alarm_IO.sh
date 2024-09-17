#!/bin/bash

# Set current directory
current_dir="$(cd "$(dirname "$0")" && pwd)"
parent_dir="$(dirname "$current_dir")"
result_dir="$parent_dir/result"

# Create the "result" directory if it doesn't exist
mkdir -p "$result_dir"

# Log file location
log_file="$result_dir/test_alarm_IO_results.txt"

# Initialize result variable
result=0

# Define GPIO pins
gpio_pins=("gpio457" "gpio459")

# Define logging function
log() {
    echo "$1" | tee -a "$log_file"
}

# Define function to test GPIO value
test_gpio() {
    local gpio_pin="$1"
    local value="$2"

    log "Setting $gpio_pin to $value"
    echo "$value" > "/sys/class/gpio/$gpio_pin/value"
}

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Start testing
log "Testing Alarm IO"

# Check GPIO pins
for gpio_pin in "${gpio_pins[@]}"; do
    if [ ! -e "/sys/class/gpio/$gpio_pin/value" ]; then
        log "GPIO pin $gpio_pin does not exist."
        result=1
    fi
done

# Test GPIO values
if [ $result -eq 0 ]; then
    # Set and reset GPIO values
    for gpio_pin in "${gpio_pins[@]}"; do
        test_gpio "$gpio_pin" 1
        sleep 1
        test_gpio "$gpio_pin" 0
        sleep 1
    done

    log "Alarm IO test completed. Listen for relay clicks."

    # Print PASS message with color
    echo -e "${GREEN}${BOLD}PASS${NC}"
else
    # Print FAIL message with color
    echo -e "${RED}${BOLD}FAIL${NC}"
fi

exit $result
