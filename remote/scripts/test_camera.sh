#!/bin/bash

# Set current directory
current_dir="$(cd "$(dirname "$0")" && pwd)"

# Initialize result variable
result=0

# Set environment variable for GStreamer
export XDG_RUNTIME_DIR=/run/user/root

# Define status macros
STATUS_CAMERA_ERROR="camera error"
STATUS_CAMERA_OK="camera ok"

# Define logging function
log() {
    echo "$1"
    echo "$1"
}

# Define function to check if a file exists
file_exists() {
    [ -e "$1" ]
}

# Start testing
log "Testing Camera"

# Function to test IMX219 camera
test_imx219() {
    log "Testing IMX219 camera..."

    log "1. Viewing camera to screen..."
    if gst-launch-1.0 --gst-debug=2 qtiqmmfsrc camera=0 name=camsrc ! video/x-raw\(memory:GBM\),format=NV12,width=1920,height=1080,framerate=30/1 ! waylandsink fullscreen=true async=true sync=false; then
        log "$STATUS_CAMERA_OK: Viewing IMX219 camera to screen succeeded."
    else
        log "$STATUS_CAMERA_ERROR: Viewing IMX219 camera to screen failed."
    fi

    log "2. Recording Stream: 1920x1080..."
    if gst-launch-1.0 -e qtiqmmfsrc name=camsrc camera=0 ! video/x-raw\(memory:GBM\),format=NV12,width=1920,height=1080,framerate=30/1 ! queue ! qtic2venc min-quant-i-frames=20 min-quant-p-frames=20 max-quant-i-frames=30 max-quant-p-frames=30 quant-i-frames=20 quant-p-frames=20 target-bitrate=6000000 ! queue ! h264parse ! mp4mux ! queue ! filesink location="/data/mux_imx219.mp4"; then
        log "$STATUS_CAMERA_OK: Recording IMX219 camera stream 1920x1080 succeeded."
    else
        log "$STATUS_CAMERA_ERROR: Recording IMX219 camera stream 1920x1080 failed."
    fi
}

# Function to test IMX477 camera
test_imx477() {
    log "Testing IMX477 camera..."

    log "1. Viewing camera to screen..."
    if gst-launch-1.0 --gst-debug=2 qtiqmmfsrc camera=0 name=camsrc ! video/x-raw\(memory:GBM\),format=NV12,width=3840,height=2160,framerate=30/1 ! waylandsink fullscreen=true async=true sync=false; then
        log "$STATUS_CAMERA_OK: Viewing IMX477 camera to screen succeeded."
    else
        log "$STATUS_CAMERA_ERROR: Viewing IMX477 camera to screen failed."
    fi

    log "2. Recording Stream: 3840x2160..."
    if gst-launch-1.0 -e qtiqmmfsrc name=camsrc camera=0 ! video/x-raw\(memory:GBM\),format=NV12,width=3840,height=2160,framerate=30/1 ! queue ! qtic2venc min-quant-i-frames=20 min-quant-p-frames=20 max-quant-i-frames=30 max-quant-p-frames=30 quant-i-frames=20 quant-p-frames=20 target-bitrate=6000000 ! queue ! h264parse ! mp4mux ! queue ! filesink location="/data/mux_imx477_4k.mp4"; then
        log "$STATUS_CAMERA_OK: Recording IMX477 camera stream 3840x2160 succeeded."
    else
        log "$STATUS_CAMERA_ERROR: Recording IMX477 camera stream 3840x2160 failed."
    fi

    log "3. Recording Stream: 1920x1080..."
    if gst-launch-1.0 -e qtiqmmfsrc name=camsrc camera=0 ! video/x-raw\(memory:GBM\),format=NV12,width=1920,height=1080,framerate=30/1 ! queue ! qtic2venc min-quant-i-frames=20 min-quant-p-frames=20 max-quant-i-frames=30 max-quant-p-frames=30 quant-i-frames=20 quant-p-frames=20 target-bitrate=6000000 ! queue ! h264parse ! mp4mux ! queue ! filesink location="/data/mux_imx477_1080p.mp4"; then
        log "$STATUS_CAMERA_OK: Recording IMX477 camera stream 1920x1080 succeeded."
    else
        log "$STATUS_CAMERA_ERROR: Recording IMX477 camera stream 1920x1080 failed."
    fi
}

# Main script logic
log "Select camera module to test:"
log "1. IMX219"
log "2. IMX477"
read -p "Enter your choice (1-2): " choice

case $choice in
    1) test_imx219 ;;
    2) test_imx477 ;;
    *) log "Invalid choice. Please select 1 or 2." ;;
esac

log "Camera test done"
