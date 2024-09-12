#!/bin/bash

# Function to log messages with a specific timestamp format
log() {
  local message="$1"
  local timestamp
  timestamp=$(date +"[%Y-%m-%d %H:%M:%S]")
  echo "$timestamp $message" | tee -a remote_test_log.txt
}

# Check if IP address is provided
if [ -z "$1" ]; then
  log "Usage: ./remote_test.sh <box_ip>"
  exit 1
fi

# Set the provided IP address
box_ip=$1

log "==============================================="
log "TEST TOOLS"
log "==============================================="
log "Box IP: $box_ip"

# Define the directory for the scripts
current_dir="$(cd "$(dirname "$0")" && pwd)"
scripts_dir="${current_dir}/remote/scripts"
result=0

# Source common functions and error handling
. ${current_dir}/common/common.sh
. ${current_dir}/error/error.sh

# Set executable permissions for all scripts in the scripts directory
chmod +x ${scripts_dir}/*.sh

# Check if necessary commands are available
for cmd in ssh scp ping sshpass; do
  log "$cmd checking"
  command -v $cmd > /dev/null 2>&1
  if [ $? -ne 0 ]; then
    log "$cmd is not installed. Please install it before running the script."
    exit 1
  else
    log "$cmd installed"
  fi
done

# Prompt for password
read -sp "Enter password for root@$box_ip: " password
echo

# Check if the box is reachable
ping -c 1 $box_ip > /dev/null 2>&1
if [ $? -ne 0 ]; then
  log "Box with IP $box_ip is not reachable."
  exit 1
else
  log "Host $box_ip is reachable => Lan okie"
fi

# Display the menu for selecting the test function
echo "Select a function to test on AIBOX QCS6490:"
echo "1. Power Button"
echo "2. Serial Port"
echo "3. RAM"
echo "4. ROM"
echo "5. USB HUB 3.0"
echo "6. USB TYPE-A (4 ports)"
echo "7. SD Card"
echo "8. Factory Reset Button"
echo "9. NVMe"
echo "10. RTC"
echo "11. LTE 4G"
echo "12. LAN7800"
echo "13. Alarm IO"
echo "14. DP (Display Port)"
echo "15. GPIO"
echo "16. Camera"
echo "17. Exit"

# Get user input for the test choice
read -p "Enter your choice (1-17): " choice

# Function to check script existence
check_script() {
  if [ ! -f "$1" ]; then
    log "Script $1 not found."
    exit 1
  fi
}

# Execute the corresponding test script remotely
case $choice in
    1) script="${scripts_dir}/test_power_button.sh" ;;
    2) script="${scripts_dir}/test_serial.sh" ;;
    3) script="${scripts_dir}/test_ram.sh" ;;
    4) script="${scripts_dir}/test_rom.sh" ;;
    5) script="${scripts_dir}/test_usb_hub.sh" ;;
    6) script="${scripts_dir}/test_usb_type_a.sh" ;;
    7) script="${scripts_dir}/test_sd_card.sh" ;;
    8) script="${scripts_dir}/test_reset_button.sh" ;;
    9) script="${scripts_dir}/test_nvme.sh" ;;
    10) script="${scripts_dir}/test_rtc.sh" ;;
    11) script="${scripts_dir}/test_lte.sh" ;;
    12) script="${scripts_dir}/test_lan7800.sh" ;;
    13) script="${scripts_dir}/test_alarm_IO.sh" ;;
    14) script="${scripts_dir}/test_DP.sh" ;;
    15) script="${scripts_dir}/test_GPIO.sh" ;;
    16) script="${scripts_dir}/test_camera.sh" ;;
    17) log "Exiting..."; exit 0 ;;
    *) log "Invalid choice. Please select a number between 1 and 17." ;;
esac

# Check if the selected script exists
check_script "$script"

# Execute the selected script
log "Executing $script remotely"
echo "$password" | sshpass -p "$password" ssh root@$box_ip "bash -s" < "$script"

# Check if the remote command was successful
if [ $? -ne 0 ]; then
  log "Failed to execute $script on $box_ip."
  result=1
fi

exit $result
