#!/bin/bash

# Initialize result variables
test_result="PASS"  # Default to PASS, will change to FAIL if any test fails
current_port=0  # Track the current port being tested

# Define logging function
log() {
    echo "$1"
}

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Handle Ctrl+C (SIGINT) signal
trap 'handle_interrupt' SIGINT

# Function to handle Ctrl+C (interrupt signal)
handle_interrupt() {
    echo -e "\nTest result: ${RED}${BOLD}FAIL${NC}"
    exit 1
}

# Function to check USB information for a specific port
check_usb_info() {
    local usb_type="$1"
    local port_num="$2"
    local expected_speed

    if [ "$usb_type" == "2.0" ]; then
        expected_speed="480M"
    elif [ "$usb_type" == "3.0" ]; then
        expected_speed="5000M"
    else
        log "Invalid USB type."
        return 1
    fi

    # Run 'lsusb -t' to get detailed USB device information
    usb_info=$(lsusb -t)

    # Check for the specific port and speed in the lsusb output
    if echo "$usb_info" | grep -qE "Port $port_num.*Driver=usb-storage,.*$expected_speed"; then
        echo -e "Test result for Port $port_num (USB $usb_type): ${GREEN}${BOLD}PASS${NC}"
        log "Port $port_num (USB $usb_type): PASS"
        return 0  # Success
    else
        return 1  # Fail
    fi
}

# Function to test a specific port for a specific USB type with timeout
test_port() {
    local port_num="$1"
    local usb_type="$2"
    local timeout=10  # Set timeout to 10 seconds
    local elapsed_time=0
    local result=1  # Default to fail if no success

    echo "Please plug in USB $usb_type to Port $port_num"
    current_port=$port_num  # Track the current port being tested

    # Wait and check for a maximum of 10 seconds
    while [ $elapsed_time -lt $timeout ]; do
        if check_usb_info "$usb_type" "$port_num"; then
            result=0  # Test passed, exit loop
            break
        fi
        sleep 1  # Wait for 1 second before checking again
        elapsed_time=$((elapsed_time + 1))
    done

    if [ $result -ne 0 ]; then
        # If USB is not detected or interrupted, report FAIL
        echo -e "Test result for Port $port_num (USB $usb_type): ${RED}${BOLD}FAIL${NC}"
        test_result="FAIL"  # Set global test result to FAIL
    fi

    return $result
}

# Main testing process
echo "Starting USB Type-A port testing..."

# Test all ports for USB 2.0 first, one by one
echo "Testing all ports for USB 2.0..."

for port in {1..4}; do
    test_port "$port" "2.0"
    sleep 3  # Pause for 3 seconds between port scans
done

# Test all ports for USB 3.0 next, one by one
echo "Testing all ports for USB 3.0..."

for port in {1..4}; do
    test_port "$port" "3.0"
    sleep 3  # Pause for 3 seconds between port scans
done

# Final test result
if [ "$test_result" == "PASS" ]; then
    echo -e "Test result: ${GREEN}${BOLD}PASS${NC}"
else
    echo -e "Test result: ${RED}${BOLD}FAIL${NC}"
fi

exit 0
