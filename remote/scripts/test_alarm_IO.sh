#!/bin/bash

# Set current directory
current_dir="$(cd "$(dirname "$0")" && pwd)"

# Initialize result variable
result=0

# Define GPIO pins
gpio_pins=("gpio457" "gpio459")

# Define logging function
log() {
    echo "$1"
}

# Define function to test GPIO value
test_gpio() {
    local gpio_pin="$1"
    local value="$2"

    log "Setting $gpio_pin to $value"
    echo "$value" > "/sys/class/gpio/$gpio_pin/value"
}

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
else
    log "Alarm IO test failed."
fi

log "Alarm IO test done"
exit $result
