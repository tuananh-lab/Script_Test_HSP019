#!/bin/bash

# Set current directory
current_dir="$(cd "$(dirname "$0")" && pwd)"

# Initialize result variable
result=0

# Define paths
date_file="/sys/class/rtc/rtc0/date"
time_file="/sys/class/rtc/rtc0/time"

# Define logging function
log() {
    echo "$1"
}

# Define function to check if a file exists
file_exists() {
    [ -e "$1" ]
}

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
        result=1
    else
        log "RTC Date: $rtc_date"
    fi

    if [ -z "$rtc_time" ]; then
        log "Failed to read time from $time_file."
        echo "RTC_TIME_READ_ERROR"
        result=1
    else
        log "RTC Time: $rtc_time"
    fi
fi

log "RTC test done"
exit $result
