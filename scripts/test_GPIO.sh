#!/bin/bash

# Set current directory
current_dir="$(cd "$(dirname "$0")" && pwd)"
parent_dir="$(dirname "$current_dir")"
# result_dir="$parent_dir/result"

# # Create the "result" directory if it doesn't exist
# mkdir -p "$result_dir"

# # Define log file location
# log_file="$result_dir/test_GPIO_results.txt"

# # Check for root privileges
# if [ "$EUID" -ne 0 ]; then
#   echo "Please run the script as root."
#   exit 1
# fi

# Initialize result variable
result=0

# Define GPIO pins
gpio_pins=("372" "373" "374" "375")

RED='\033[0;31m'
GREEN='\033[0;32m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Define logging function
log() {
    echo "$1"
}

# Define function to export GPIO
export_gpio() {
    local gpio_pin="$1"
    if [ ! -e "/sys/class/gpio/gpio${gpio_pin}" ]; then
        echo "$gpio_pin" > /sys/class/gpio/export
        if [ $? -ne 0 ]; then
            log "Failed to export GPIO pin $gpio_pin."
            result=1
        fi
    fi
}

# Define function to set GPIO direction and value
configure_gpio() {
    local gpio_pin="$1"
    echo "out" > "/sys/class/gpio/gpio${gpio_pin}/direction"
    if [ $? -ne 0 ]; then
        log "Failed to set direction for GPIO pin $gpio_pin."
        result=1
    fi
    echo "1" > "/sys/class/gpio/gpio${gpio_pin}/value"
    if [ $? -ne 0 ]; then
        log "Failed to set value for GPIO pin $gpio_pin."
        result=1
    fi
}

# Start testing
log "Testing GPIO"

# Check GPIO pins
for gpio_pin in "${gpio_pins[@]}"; do
    export_gpio "$gpio_pin"
    if [ ! -e "/sys/class/gpio/gpio${gpio_pin}/value" ]; then
        log "GPIO pin $gpio_pin export failed or does not exist."
        result=1
    fi
done

# Configure GPIO pins if no export failures
if [ $result -eq 0 ]; then
    for gpio_pin in "${gpio_pins[@]}"; do
        configure_gpio "$gpio_pin"
    done

    log "GPIO test completed. Please check the voltage on pins 2, 3, 4, 5 of J1101 for 1.8V."
    test_result="PASS"
else
    log "GPIO test failed."
    test_result="FAIL"
fi

# Print the result with color and bold
if [ "$test_result" == "FAIL" ]; then
    echo -e "Test result: ${RED}${BOLD}FAIL${NC}"
else
    echo -e "Test result: ${GREEN}${BOLD}PASS${NC}"
fi

exit $result
