#!/bin/bash

# Set current directory
current_dir="$(cd "$(dirname "$0")" && pwd)"
parent_dir="$(dirname "$current_dir")"
result_dir="$parent_dir/result"

# Create the "result" directory if it doesn't exist
mkdir -p "$result_dir"

# Define log file location
log_file="$result_dir/test_rtc_results.txt"

# Initialize result variable
result=0
test_result="FAIL"  # Default to FAIL

# Define paths
date_file="/sys/class/rtc/rtc0/date"
time_file="/sys/class/rtc/rtc0/time"

# Define logging function
log() {
    echo "$1" | tee -a "$log_file"
}

# Define function to check if a file exists
file_exists() {
    [ -e "$1" ]
}

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Start testing
log "Testing RTC"

# Check if the date and time files exist
if ! file_exists "$date_file"; then
    log "Date file $date_file does not exist."
    echo "RTC_DATE_FILE_NOT_FOUND"
    result=1
fi

if ! file_exists "$time_file"; then
    log "Time file $time_file does not exist."
    echo "RTC_TIME_FILE_NOT_FOUND"
    result=1
fi

# Read date and time
if [ $result -eq 0 ]; then
    rtc_date=$(cat "$date_file")
    rtc_time=$(cat "$time_file")

    if [ -z "$rtc_date" ]; then
        log "Failed to read date from $date_file."
        echo "RTC_DATE_READ_ERROR"
        echo -e "${RED}${BOLD}FAIL${NC}"
        result=1
    else
        log "RTC Date: $rtc_date"
    fi

    if [ -z "$rtc_time" ]; then
        log "Failed to read time from $time_file."
        echo "RTC_TIME_READ_ERROR"
        echo -e "${RED}${BOLD}FAIL${NC}"
        result=1
    else
        log "RTC Time: $rtc_time"
        test_result="PASS"
    fi
fi

# Print the final result
echo -e "Test result: ${!test_result}${GREEN}${BOLD}PASS${NC}"

exit $result
