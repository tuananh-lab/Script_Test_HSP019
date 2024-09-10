#!/bin/bash

# Set current directory
current_dir="$(cd "$(dirname "$0")" && pwd)"
gpio_path="/sys/class/gpio/gpio360/value"


# Initialize result variable
result=0

# Define logging function
log() {
    echo "$1"
}

# Define function to check if a file exists
file_exists() {
    [ -e "$1" ]
}

# Start testing
log "Testing Reset Button"

# Check if the GPIO file exists
if ! file_exists "$gpio_path"; then
    log "GPIO path $gpio_path does not exist."
    echo "GPIO_PATH_NOT_FOUND"
    result=1
    exit $result
fi

# Read initial value (should be 1)
initial_value=$(cat "$gpio_path")
log "Initial GPIO value: $initial_value"

if [ "$initial_value" -ne 1 ]; then
    log "Initial GPIO value is not 1. Check the button state."
    echo "INITIAL_VALUE_ERROR"
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
    echo "BUTTON_PRESS_ERROR"
    result=1
else
    log "Button functionality is correct. GPIO value after pressing the button is 0."
    echo "BUTTON_OK"
fi

log "Reset button test done"
exit $result
