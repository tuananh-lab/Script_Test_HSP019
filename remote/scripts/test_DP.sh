
#!/bin/bash

# Set current directory
current_dir="$(cd "$(dirname "$0")" && pwd)"

# Initialize result variable
result=0

# Define logging function
log() {
    echo "$1"
}

# Define function to check if a file exists
file_exists() {
    [ -e "$1" ]
}
# Start testing
log "Testing DP(Display Port)..."
log "Please plug the type-c to hdmi adapter into the monitor in both directions"
log "The results display the image on the screen"
log "Display port test done"
exit $result
