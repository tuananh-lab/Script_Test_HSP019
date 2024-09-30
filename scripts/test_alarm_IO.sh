#!/bin/bash

# Set current directory
current_dir="$(cd "$(dirname "$0")" && pwd)"
parent_dir="$(dirname "$current_dir")"

# Initialize result variable
result=0

# Define GPIO pins
gpio_pins=("457" "459")

# Define logging function
log() {
    echo "$1"
}

# Function to export GPIO if not already exported
export_gpio() {
    local gpio_pin="$1"
    if [ ! -d "/sys/class/gpio/gpio$gpio_pin" ]; then
        log "Exporting GPIO $gpio_pin"
        if ! echo "$gpio_pin" > "/sys/class/gpio/export"; then
            log "/sys/class/gpio/export: Permission denied"
            result=1
        fi
        sleep 1
    fi
}

# Function to set GPIO direction
set_gpio_direction() {
    local gpio_pin="$1"
    local direction="$2"
    log "Setting GPIO $gpio_pin direction to $direction"
    if ! echo "$direction" > "/sys/class/gpio/gpio$gpio_pin/direction"; then
        log "/sys/class/gpio/gpio$gpio_pin/direction: No such file or directory"
        result=1
    fi
}

# Function to set GPIO value
set_gpio_value() {
    local gpio_pin="$1"
    local value="$2"
    log "Setting $gpio_pin to $value"
    if ! echo "$value" > "/sys/class/gpio/gpio$gpio_pin/value"; then
        log "/sys/class/gpio/gpio$gpio_pin/value: No such file or directory"
        result=1
    fi
}

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Start testing
log "Testing Alarm IO"

# Check GPIO pins and prepare them
for gpio_pin in "${gpio_pins[@]}"; do
    export_gpio "$gpio_pin"
    set_gpio_direction "$gpio_pin" "out"
done

# Test GPIO values
for gpio_pin in "${gpio_pins[@]}"; do
    set_gpio_value "$gpio_pin" 1
    sleep 1
    set_gpio_value "$gpio_pin" 0
    sleep 1
done

log "Alarm IO test completed. Listen for relay clicks."

# Set result and print final result with color and bold
if [ $result -eq 1 ]; then
    echo -e "Test result: ${RED}${BOLD}FAIL${NC}"
else
    echo -e "Test result: ${GREEN}${BOLD}PASS${NC}"
fi

exit $result
