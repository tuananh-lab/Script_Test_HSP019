#!/bin/bash

# Log file path
export log_file="remote_test.log"

# Set the directory containing the test scripts
current_dir="$(cd "$(dirname "$0")" && pwd)"
scripts_dir="${current_dir}/remote/scripts"

# Add libs
. "${current_dir}/common/common.sh"
. "${current_dir}/error/error.sh"

result=0

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
# check_Box_IP
box_ip=$1
log "Box IP: $box_ip"

if is_valid_ipv4 $box_ip; then
  log "Valid IP address, continue"
else
  log "Invalid IP address. Please check again."
  exit 1
fi

# Check packages
log "Check packages"
check_package ssh
check_package scp
check_package ping
check_package sshpass

# Set executable permissions for all scripts in the scripts directory
chmod +x "${scripts_dir}"/*.sh

# Check if the box is reachable
if ping_test $box_ip ; then
  log "Host $box_ip is reachable => LAN okie"
else
  log "Host $box_ip is not reachable"
  echo $STATUS_LAN_ETH0_ERROR
  exit 1
fi

# Prompt for password
read -sp "Enter password for root@$box_ip: " password
echo

# Main script
echo "Select a function to test on AIBOX QCS6490:"
echo "1. Power"
echo "2. DP(Display Port)"
echo "3. Serial Port"
echo "4. RAM"
echo "5. ROM"
echo "6. USB HUB 3.0"
echo "7. SD Card"
echo "8. NVMe"
echo "9. RTC"
echo "10. LTE 4G"
echo "11. LAN7800"
echo "12. GPIO"
echo "13. Alarm IO"
echo "14. USB TYPE-A (4 ports)"
echo "15. Factory Reset Button"
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

# Determine the script to run based on user choice
case $choice in
    1) script="${scripts_dir}/test_power.sh" ;;
    2) script="${scripts_dir}/test_DP.sh" ;;
    3) script="${scripts_dir}/test_serial.sh" ;;
    4) script="${scripts_dir}/test_ram.sh" ;;
    5) script="${scripts_dir}/test_rom.sh" ;;
    6) script="${scripts_dir}/test_usb_hub.sh" ;;
    7) script="${scripts_dir}/test_sd_card.sh" ;;
    8) script="${scripts_dir}/test_nvme.sh" ;;
    9) script="${scripts_dir}/test_rtc.sh" ;;
    10) script="${scripts_dir}/test_lte.sh" ;;
    11) script="${scripts_dir}/test_lan7800.sh" ;;
    12) script="${scripts_dir}/test_GPIO.sh" ;;
    13) script="${scripts_dir}/test_alarm_IO.sh" ;;
    14) script="${scripts_dir}/test_usb_type_a.sh" ;;
    15)  log "Test Factory Reset button not support while test remote" ;
        log "Please run test.sh in the HSP019_Test folder directly on the device and check the function test." ; exit 0 ;;
    16)  log "Test camera not support while test remote" ; 
         log "Please run test.sh in the HSP019_Test folder directly on the device and check the function test." ; exit 0 ;;
    17) log "Exiting..."; exit 0 ;;
    *) log "Invalid choice. Please select a number between 1 and 17." ;;
esac

# Check if the selected script exists
check_script "$script"

#Execute the selected script remotely using sshpass and capture the output
log "Executing $script on $box_ip..."

remote_output=$(echo "$password" | sshpass -p "$password" ssh root@$box_ip "bash -s" < "$script" 2>&1)
result=$?

# Log the output of the remote execution
# log "Remote execution output:"
log "$remote_output"

# Log the result of the remote execution
# if [ $result -eq 0 ]; then
#     log "Remote script executed successfully."
# else
#     log "Remote script execution failed with exit code $result."
# fi

exit $result
