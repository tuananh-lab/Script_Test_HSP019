#!/bin/bash

# Set current directory
current_dir="$(cd "$(dirname "$0")" && pwd)"
parent_dir="$(dirname "$current_dir")"
result_dir="$parent_dir/result"

# Create the "result" directory if it doesn't exist
mkdir -p "$result_dir"

# Define log file location
log_file="$result_dir/test_usb_type_a_results.txt"

# Initialize result variables
result=0
test_result="PASS"  # Default to PASS, will change to FAIL if any test fails

# Define logging function
log() {
    echo "$1" | tee -a "$log_file"
}

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Function to display USB information for a specific type
check_usb_info() {
    local usb_type="$1"
    local port_num="$2"
    local pattern

    if [ "$usb_type" == "2.0" ]; then
        pattern="480M"
    elif [ "$usb_type" == "3.0" ]; then
        pattern="5000M"
    else
        log "Invalid USB type."
        return 1
    fi

    # Run 'lsusb -t' to get detailed USB device information
    usb_info=$(lsusb -t)

    if echo "$usb_info" | grep -qE "Driver=usb-storage, $pattern"; then
        echo -e "Test result for Port $port_num (USB $usb_type): ${GREEN}${BOLD}PASS${NC}"
        log "Port $port_num (USB $usb_type): PASS"
        return 0  # Success
    else
        echo -e "Test result for Port $port_num (USB $usb_type): ${RED}${BOLD}FAIL${NC}"
        log "Port $port_num (USB $usb_type): FAIL"
        test_result="FAIL"  # If any test fails, set test_result to FAIL
        return 1  # Fail
    fi
}

# Function to test a specific port for a specific USB type
test_port() {
    local port_num="$1"
    local usb_type="$2"

    echo "Please insert a USB device into Port $port_num for USB $usb_type testing and press Enter to continue."
    read -p "Press Enter when ready to test Port $port_num (USB $usb_type)..."
    
    check_usb_info "$usb_type" "$port_num"
}

# Main testing process
echo "Starting USB Type-A port testing..."

# Test all ports for USB 2.0 first
echo "Testing all ports for USB 2.0..."
for port in {1..4}; do
    test_port "$port" "2.0"
done

# Test all ports for USB 3.0 next
echo "Testing all ports for USB 3.0..."
for port in {1..4}; do
    test_port "$port" "3.0"
done

# Final test result
if [ "$test_result" == "PASS" ]; then
    echo -e "Test result: ${GREEN}${BOLD}PASS${NC}"
else
    echo -e "Test result: ${RED}${BOLD}FAIL${NC}"
fi

exit $result
