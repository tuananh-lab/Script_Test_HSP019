#!/bin/bash

# Check if IP address is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <box_ip>"
  exit 1
fi

# Set the provided IP address
box_ip=$1

echo "[INFO] Testing on AIBOX QCS6490 with IP: $box_ip"

# Define the directory for the scripts
current_dir="$(cd "$(dirname "$0")" && pwd)"
scripts_dir="${current_dir}/remote/scripts"
result=0

# Source common functions and error handling
. ${current_dir}/common/common.sh
. ${current_dir}/error/error.sh

# Set executable permissions for all scripts in the scripts directory
chmod +x ${scripts_dir}/*.sh

# Prompt for password
read -sp "Enter password for root@$box_ip: " password
echo

# Check if the box is reachable
ping -c 1 $box_ip > /dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "[ERROR] Box with IP $box_ip is not reachable."
  exit 1
fi

# Check if ssh, scp, and ping commands are available
for cmd in ssh scp ping; do
  command -v $cmd > /dev/null 2>&1
  if [ $? -ne 0 ]; then
    echo "[ERROR] $cmd is not installed. Please install it before running the script."
    exit 1
  fi
done

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

# Execute the corresponding test script remotely
case $choice in
    1) echo "$password" | sshpass -p "$password" ssh root@$box_ip "bash -s" < ${scripts_dir}/test_power_button.sh ;;
    2) echo "$password" | sshpass -p "$password" ssh root@$box_ip "bash -s" < ${scripts_dir}/test_serial.sh ;;
    3) echo "$password" | sshpass -p "$password" ssh root@$box_ip "bash -s" < ${scripts_dir}/test_ram.sh ;;
    4) echo "$password" | sshpass -p "$password" ssh root@$box_ip "bash -s" < ${scripts_dir}/test_rom.sh ;;
    5) echo "$password" | sshpass -p "$password" ssh root@$box_ip "bash -s" < ${scripts_dir}/test_usb_hub.sh ;;
    6) echo "$password" | sshpass -p "$password" ssh root@$box_ip "bash -s" < ${scripts_dir}/test_usb_type_a.sh ;;
    7) echo "$password" | sshpass -p "$password" ssh root@$box_ip "bash -s" < ${scripts_dir}/test_sd_card.sh ;;
    8) echo "$password" | sshpass -p "$password" ssh root@$box_ip "bash -s" < ${scripts_dir}/test_reset_button.sh ;;
    9) echo "$password" | sshpass -p "$password" ssh root@$box_ip "bash -s" < ${scripts_dir}/test_nvme.sh ;;
    10) echo "$password" | sshpass -p "$password" ssh root@$box_ip "bash -s" < ${scripts_dir}/test_rtc.sh ;;
    11) echo "$password" | sshpass -p "$password" ssh root@$box_ip "bash -s" < ${scripts_dir}/test_lte.sh ;;
    12) echo "$password" | sshpass -p "$password" ssh root@$box_ip "bash -s" < ${scripts_dir}/test_lan7800.sh ;;
    13) echo "$password" | sshpass -p "$password" ssh root@$box_ip "bash -s" < ${scripts_dir}/test_alarm_IO.sh ;;
    14) echo "$password" | sshpass -p "$password" ssh root@$box_ip "bash -s" < ${scripts_dir}/test_DP.sh ;;
    15) echo "$password" | sshpass -p "$password" ssh root@$box_ip "bash -s" < ${scripts_dir}/test_GPIO.sh ;;
    16) echo "$password" | sshpass -p "$password" ssh root@$box_ip "bash -s" < ${scripts_dir}/test_camera.sh ;;
    17) echo "Exiting..."; exit 0 ;;
    *) echo "[ERROR] Invalid choice. Please select a number between 1 and 17." ;;
esac

exit $result
