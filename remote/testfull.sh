#!/bin/bash

# Get current directory
current_dir="$(cd "$(dirname "$0")" && pwd)"

# Add common and error handling libraries
source "${current_dir}/../common/common.sh"
source "${current_dir}/../error/error.sh"

# Set log file and summary file locations
export log_file="${current_dir}/testfull.log"
summary_file="${current_dir}/test_summary.txt"
echo -n "" >"$log_file"
echo -n "" >"$summary_file"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Ensure all scripts have executable permissions
chmod +x "${current_dir}/scripts/"*.sh

# Function to run each test and add a line separator
run_test() {
    script_path="$1"
    test_name=$(basename "$script_path" .sh)

    # Display the name of the test being run
    echo -e "${BLUE}${BOLD}Running test: ${test_name}${NC}" | tee -a "$log_file"

    # Run the test script and capture the output live
    "${script_path}" 2>&1 | tee -a "$log_file"

    # Check the result from the log file by looking for "Test result: PASS" or "Test result: FAIL"
    test_result=$(grep -oP "(?<=Test result: ).*" "$log_file" | tail -1)

    # If the test is test_serial.sh, get the serial number from the output
    serial_number=""
    if [[ "$test_name" == "test_serial" ]]; then
        serial_number=$(grep -oP "(?<=serial_number: ).*" "$log_file" | tail -1)
    fi

    # If no result is found, set to UNKNOWN
    if [[ -z "$test_result" ]]; then
        test_result="UNKNOWN"
    fi

    # Append the test result to the summary file with serial_number if present
    if [[ -n "$serial_number" ]]; then
        echo "$test_name: $test_result | serial_number: $serial_number" >>"$summary_file"
    else
        echo "$test_name: $test_result" >>"$summary_file"
    fi

    echo "" | tee -a "$log_file"
}

# Display test header
echo -e "${BLUE}${BOLD}================================ TEST FULL FUNCTION TEST ================================${NC}"
echo -e "${BLUE}${BOLD}================================    RUNNING ALL TESTS    ================================${NC}"
echo

# List of test scripts to run
test_scripts=(
    "test_power.sh"
    "test_DP.sh"
    "test_serial.sh"
    "test_ram.sh"
    "test_rom.sh"
    "test_usb_hub.sh"
    "test_sd_card.sh"
    "test_nvme.sh"
    "test_rtc.sh"
    "test_lte.sh"
    "test_lan7800.sh"
    "test_GPIO.sh"
    "test_alarm_IO.sh"
    "test_usb_type_a.sh"
    "test_reset_button.sh"
    "test_camera.sh"
)

# Run all test scripts
for test_script in "${test_scripts[@]}"; do
    run_test "${current_dir}/scripts/${test_script}"
done

# Display the test results summary
echo -e "${BLUE}${BOLD}================================    TEST RESULTS SUMMARY    ================================${NC}"
while IFS= read -r line; do
    if [[ $line == *"PASS"* ]]; then
        echo -e "${GREEN}${line}${NC}"
    elif [[ $line == *"FAIL"* ]]; then
        echo -e "${RED}${line}${NC}"
    else
        echo -e "${line}"
    fi
done <"$summary_file"
echo -e "${BLUE}${BOLD}================================     ALL TESTS COMPLETED     ================================${NC}"

# Exit with status
exit 0
