#!/bin/bash

# Function to log messages
log() {
    local log_msg="$1"
    local timestamp="$(date +'%Y-%m-%d %H:%M:%S')"

    # Print the message to the console
    echo "[$timestamp] $log_msg"
}

logcat() {
    local file="$1"
    local timestamp="$(date +'%Y-%m-%d %H:%M:%S')"

    # Store the file contents in cat_output
    cat_output="$(cat $file)"  # Replace "file.txt" with the actual file name

    # Use echo and command substitution to iterate through lines
    while IFS= read -r line; do
        # Print the message to the console
        echo "[$timestamp] $line"
    done <<< "$cat_output"
}

# Check folder exist
folder_exists() {
    if [ -d "$1" ]; then
        return 0  # Folder exists
    else
        return 1  # Folder does not exist
    fi
}

# Check folder exist
file_exists() {
    if [ -f "$1" ]; then
        return 0  # File exists
    else
        return 1  # File does not exist
    fi
}

# @func: check packagas
check_package() {
    package=$1
    log "$package checking"
    if command -v $package &>/dev/null; then
        log "$package installed"
    else
        log "$package command not found"
        log "Please install: sudo apt install $package"
        exit 1
    fi
}

# Function to check if a string is a valid IPv4 address
is_valid_ipv4() {
    if [[ $1 =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
        return 0 # valid ip
    fi
    return 1 # invalid ip
}

# Function to perform a ping test
ping_test() {
    local host="$1"
    local count=1  # Number of ping packets to send (adjust as needed)

    # Perform the ping test
    if ping -c "$count" "$host" >/dev/null 2>&1; then
        return 0 # echo "Host $host is reachable."
    else
        return 1 # echo "Host $host is not reachable."
    fi
}

# get $0 dir
get_current_dir() {
    # Get the directory of the currently executing script
    current_dir="$(cd "$(dirname "$1")" && pwd)"
    echo "$current_dir"
}

update_path() {
    # Define the directories to check for in the PATH
    required_dirs=("/usr/local/sbin" "/usr/sbin" "/sbin")

    # Check if each required directory is in the PATH
    for dir in "${required_dirs[@]}"; do
        if [[ ":$PATH:" != *":$dir:"* ]]; then
            # Directory is missing from the PATH, so add it
            export PATH="$PATH:$dir"
            log "Added $dir to PATH"
        fi
    done

    # Optionally, you can print the updated PATH
    log "Updated PATH: $PATH"
}