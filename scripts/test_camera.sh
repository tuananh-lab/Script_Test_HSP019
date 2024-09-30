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

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Function to handle signal interruption
handle_interrupt() {
    log "Detected interruption (Ctrl+C)."
    echo -e "Test result: ${GREEN}${BOLD}$STATUS_PASS${NC}"
    exit 0
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
    if [[ $? -ne 0 ]]; then
        log "Camera view failed."
        test_result="$STATUS_FAIL"
    fi
}

# Function to record the camera feed
record_camera() {
    local camera_id=$1
    local width=$2
    local height=$3
    local output_file=$4

    log "Recording Stream from camera $camera_id: ${width}x${height}..."
    gst-launch-1.0 -e qtiqmmfsrc name=camsrc camera=$camera_id ! video/x-raw\(memory:GBM\),format=NV12,width=$width,height=$height,framerate=30/1 ! queue ! qtic2venc min-quant-i-frames=20 min-quant-p-frames=20 max-quant-i-frames=30 max-quant-p-frames=30 quant-i-frames=20 quant-p-frames=20 target-bitrate=6000000 ! queue ! h264parse ! mp4mux ! queue ! filesink location="$output_file"
    if [[ $? -ne 0 ]]; then
        log "Camera recording failed."
        test_result="$STATUS_FAIL"
    fi
}

# Sub-menu for testing single camera (view or record)
test_camera() {
    local camera_id=$1
    while true; do
        log "Testing Camera $camera_id"
        log "1. View camera"
        log "2. Record camera"
        log "3. Back"
        read -p "Enter your choice (1-3): " cam_choice
        case $cam_choice in
            1) view_camera $camera_id 1920 1080 ;;
            2) record_camera $camera_id 1920 1080 "/data/mux_camera${camera_id}.mp4" ;;
            3) break ;;
            *) log "Invalid choice. Please select 1, 2, or 3." ;;
        esac
        if [[ "$test_result" == "$STATUS_FAIL" ]]; then
            echo -e "Test result: ${RED}${BOLD}$STATUS_FAIL${NC}"
        fi
    done
}

# Function to test two cameras
test_two_cameras() {
    while true; do
        log "Testing Two Cameras"
        log "1. Test Camera 0"
        log "2. Test Camera 1"
        log "3. Back"
        read -p "Enter your choice (1-3): " cam_choice
        case $cam_choice in
            1) test_camera 0 ;;
            2) test_camera 1 ;;
            3) break ;;
            *) log "Invalid choice. Please select 1, 2, or 3." ;;
        esac
    done
}

# Main menu logic
while true; do
    log "Select test mode:"
    log "1. Test single camera"
    log "2. Test two cameras"
    log "3. Exit"
    read -p "Enter your choice (1-3): " choice

    case $choice in
        1) 
            log "Select camera:"
            log "1. Camera 0"
            log "2. Camera 1"
            read -p "Enter your choice (1-2): " camera_choice
            if [[ "$camera_choice" == "1" ]]; then
                test_camera 0
            elif [[ "$camera_choice" == "2" ]]; then
                test_camera 1
            else
                log "Invalid choice. Please select 1 or 2."
            fi
            ;;
        2) test_two_cameras ;;
        3) log "Exiting..."; exit 0 ;;
        *) log "Invalid choice. Please select 1, 2, or 3." ;;
    esac
done
