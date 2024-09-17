#!/bin/bash

# Set current directory
current_dir="$(cd "$(dirname "$0")" && pwd)"
parent_dir="$(dirname "$current_dir")"
result_dir="$parent_dir/result"

# Create the "result" directory if it doesn't exist
mkdir -p "$result_dir"

# Log file location
log_file="$result_dir/test_camera_results.txt"

# Initialize result variable
result=0

# Set environment variable for GStreamer
export XDG_RUNTIME_DIR=/run/user/root

# Define status macros
STATUS_CAMERA_ERROR="camera error"
STATUS_CAMERA_OK="camera ok"

# Define logging function
log() {
    echo "$1" | tee -a "$log_file"
}

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# Function to view the camera feed
view_camera() {
    local camera_id=$1
    local width=$2
    local height=$3

    log "Viewing camera to screen..."
    if gst-launch-1.0 --gst-debug=2 qtiqmmfsrc camera=$camera_id name=camsrc ! video/x-raw\(memory:GBM\),format=NV12,width=$width,height=$height,framerate=30/1 ! waylandsink fullscreen=true async=true sync=false; then
        log "$STATUS_CAMERA_OK: Viewing camera to screen succeeded."
    else
        log "$STATUS_CAMERA_ERROR: Viewing camera to screen failed."
    fi
}

# Function to record the camera feed
record_camera() {
    local camera_id=$1
    local width=$2
    local height=$3
    local output_file=$4

    log "Recording Stream: ${width}x${height}..."
    if gst-launch-1.0 -e qtiqmmfsrc name=camsrc camera=$camera_id ! video/x-raw\(memory:GBM\),format=NV12,width=$width,height=$height,framerate=30/1 ! queue ! qtic2venc min-quant-i-frames=20 min-quant-p-frames=20 max-quant-i-frames=30 max-quant-p-frames=30 quant-i-frames=20 quant-p-frames=20 target-bitrate=6000000 ! queue ! h264parse ! mp4mux ! queue ! filesink location="$output_file"; then
        log "$STATUS_CAMERA_OK: Recording camera stream ${width}x${height} succeeded."
    else
        log "$STATUS_CAMERA_ERROR: Recording camera stream ${width}x${height} failed."
    fi
}

# Function for IMX219 camera options
test_imx219() {
    while true; do
        log "Testing IMX219 camera"
        log "1. View camera"
        log "2. Record camera"
        log "3. Back"
        read -p "Enter your choice (1-3): " imx219_choice
        case $imx219_choice in
            1) view_camera 0 1920 1080 ;;
            2) record_camera 0 1920 1080 "/data/mux_imx219.mp4" ;;
            3) return ;;
            *) log "Invalid choice. Please select 1, 2, or 3." ;;
        esac
    done
}

# Function for IMX477 camera options
test_imx477() {
    while true; do
        log "Testing IMX477 camera"
        log "1. View camera"
        log "2. Record camera 3840x2160"
        log "3. Record camera 1920x1080"
        log "4. Back"
        read -p "Enter your choice (1-4): " imx477_choice
        case $imx477_choice in
            1) view_camera 0 3840 2160 ;;
            2) record_camera 0 3840 2160 "/data/mux_imx477_4k.mp4" ;;
            3) record_camera 0 1920 1080 "/data/mux_imx477_1080p.mp4" ;;
            4) return ;;
            *) log "Invalid choice. Please select 1, 2, 3, or 4." ;;
        esac
    done
}

# Main menu logic
while true; do
    log "Select camera module to test:"
    log "1. IMX219"
    log "2. IMX477"
    log "3. Exit"
    read -p "Enter your choice (1-3): " choice

    case $choice in
        1) test_imx219 ;;
        2) test_imx477 ;;
        3) log "Exiting..."; exit 0 ;;
        *) log "Invalid choice. Please select 1, 2, or 3." ;;
    esac
done
