#!/bin/bash

# Set current directory
current_dir="$(cd "$(dirname "$0")" && pwd)"
parent_dir="$(dirname "$current_dir")"
# result_dir="$parent_dir/result"

# # Create the "result" directory if it doesn't exist
# mkdir -p "$result_dir"

# # Define log file location
# log_file="$result_dir/test_usb_type_a_results.txt"

# Initialize result variables
result=0
test_result="FAIL"  # Default to FAIL

# Define logging function
log() {
    echo "$1"
}

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Function to display USB information for a specific type
check_usb_info() {
    local usb_type="$1"
    local pattern

    if [ "$usb_type" == "2.0" ]; then
        pattern="480M"
    elif [ "$usb_type" == "3.0" ]; then
        pattern="5000M"
    else
        log "Invalid USB type."
        return
    fi

    # Run 'lsusb -t' to get detailed USB device information
    usb_info=$(lsusb -t)

    if echo "$usb_info" | grep -qE "Driver=usb-storage, $pattern"; then
        echo -e "Test result for USB $usb_type: ${GREEN}${BOLD}PASS${NC}"
        return 0  # Success
    else
        echo -e "Test result for USB $usb_type: ${RED}${BOLD}FAIL${NC}"
        return 1  # Fail
    fi
}

# Function to test a specific USB port
test_port() {
    local port_num="$1"

    while true; do
        echo "Select test type for port $port_num:"
        echo "1. Test USB 2.0"
        echo "2. Test USB 3.0"
        echo "3. Back"
        read -p "Enter your choice (1-3): " choice

        case "$choice" in
            1)
                log "Testing USB 2.0 on port $port_num..."
                check_usb_info "2.0"
                ;;
            2)
                log "Testing USB 3.0 on port $port_num..."
                check_usb_info "3.0"
                ;;
            3)
                break  # Back to port selection
                ;;
            *)
                echo "Invalid selection. Please choose 1, 2, or 3."
                ;;
        esac
    done
}

# Main testing loop
while true; do
    echo "Select a USB port to test:"
    echo "1. Test Port 1"
    echo "2. Test Port 2"
    echo "3. Test Port 3"
    echo "4. Test Port 4"
    echo "5. Exit"
    read -p "Enter your choice (1-5): " port_choice

    case "$port_choice" in
        1|2|3|4)
            test_port "$port_choice"
            ;;
        5)
            echo "Exiting the program."
            exit 0
            ;;
        *)
            echo "Invalid selection. Please choose between 1 and 5."
            ;;
    esac
done

exit $result
