#!/bin/bash

# Set current directory
current_dir="$(cd "$(dirname "$0")" && pwd)"

# Initialize result variable
result=0

# Define logging function
log() {
    echo "$1"
}

# Function to check USB ports
check_usb_ports() {
    port_number=$1

    log "Checking Port $port_number"

    # Run 'lsusb -t' and filter for the specific port
    usb_info=$(lsusb -t | grep "Port $port_number:")

    if [ -z "$usb_info" ]; then
        log "Port $port_number: No information found."
        result=1
    else
        log "Port $port_number: $usb_info"
    fi
}

# Start testing
log "Testing USB TYPE-A (4 ports)"

# Test each port
for port in {1..4}; do
    # Wait for user to connect the device
    log "Please connect a USB device to Port $port and press Enter."
    read -r

    # Check USB ports for the specified port number
    check_usb_ports $port
done

log "USB TYPE-A (4 ports) test done"
exit $result
