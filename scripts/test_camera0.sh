#!/bin/bash

# Set current directory
current_dir="$(cd "$(dirname "$0")" && pwd)"
parent_dir="$(dirname "$current_dir")"

# Initialize test result variable
test_result=""

# Set environment variable for GStreamer
export XDG_RUNTIME_DIR=/run/user/root

# Define status macros
STATUS_PASS="PASS"
STATUS_FAIL="FAIL"

# Define logging function
log() {
    echo "$1"
}

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Function to handle signal interruption
handle_interrupt() {
    log "Detected interruption (Ctrl+C). Returning to camera selection."
    echo -e "Test result: ${GREEN}${BOLD}$STATUS_PASS${NC}"
    test_result="$STATUS_PASS"
    return
}

# Trap the Ctrl+C signal
trap handle_interrupt SIGINT

# Function to view the camera feed
view_camera() {
    local camera_id=$1
    local width=$2
    local height=$3

    log "Viewing camera $camera_id to screen..."
    gst-launch-1.0 --gst-debug=2 qtiqmmfsrc camera=$camera_id name=camsrc ! video/x-raw\(memory:GBM\),format=NV12,width=$width,height=$height,framerate=30/1 ! waylandsink fullscreen=true async=true sync=false
    if [[ $? -eq 0 ]]; then
        test_result="$STATUS_PASS"
        echo -e "Test result: ${GREEN}${BOLD}$STATUS_PASS${NC}"
    else
        log "Camera view failed or camera not available."
        test_result="$STATUS_FAIL"
        echo -e "Test result: ${RED}${BOLD}$STATUS_FAIL${NC}"
    fi
}

# Automatically run the camera view without a menu
view_camera 0 1920 1080

# Exit with appropriate status code
if [[ "$test_result" == "$STATUS_FAIL" ]]; then
    exit 1
else
    exit 0
fi