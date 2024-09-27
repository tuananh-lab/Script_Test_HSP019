#!/bin/bash
log_file="remote.log"
# Function to log messages
log() {
    local log_msg="$1"
    local timestamp="$(date +'%Y-%m-%d %H:%M:%S')"

    # Print the message to the console
    echo "[$timestamp] $log_msg" | tee -a "$log_file"
}

# Check folder exist
folder_exists() {
    if [ -d "$1" ]; then
        return 0  # Folder exists
    else
        return 1  # Folder does not exist
    fi
}

# Check file exist
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
