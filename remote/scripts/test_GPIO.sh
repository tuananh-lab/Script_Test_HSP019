#!/bin/bash

# Set current directory
current_dir="$(cd "$(dirname "$0")" && pwd)"

# Check for root privileges
if [ "$EUID" -ne 0 ]; then
  echo "Please run the script as root."
  exit 1
fi

# Initialize result variable
result=0

# Define GPIO pins
gpio_pins=("372" "373" "374" "375")

# Define logging function
log() {
    echo "$1"
}

# Define function to export GPIO
export_gpio() {
    local gpio_pin="$1"
    if [ ! -e "/sys/class/gpio/gpio${gpio_pin}" ]; then
        echo "$gpio_pin" > /sys/class/gpio/export
    fi
}

# Define function to set GPIO direction and value
configure_gpio() {
    local gpio_pin="$1"
    echo "out" > "/sys/class/gpio/gpio${gpio_pin}/direction"
    echo "1" > "/sys/class/gpio/gpio${gpio_pin}/value"
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

# Configure GPIO pins
if [ $result -eq 0 ]; then
    for gpio_pin in "${gpio_pins[@]}"; do
        configure_gpio "$gpio_pin"
    done

    log "GPIO test completed. Please check the voltage on pins 2, 3, 4, 5 of J1101 for 1.8V."
else
    log "GPIO test failed."
fi

log "GPIO test done"
exit $result
