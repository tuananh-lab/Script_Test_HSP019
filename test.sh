#!/bin/bash

current_dir="$(cd "$(dirname "$0")" && pwd)"
result=0

# Add libs
. ${current_dir}/common/common.sh
. ${current_dir}/error/error.sh

# Set the directory containing the test scripts
scripts_dir="$(get_current_dir "$0")/remote/scripts"

# Set executable permission for all scripts in the scripts directory
chmod +x ${scripts_dir}/*.sh

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

# Determine the script to run based on user choice
case $choice in
    1) ${scripts_dir}/test_power.sh ;;
    2) ${scripts_dir}/test_DP.sh ;;
    3) ${scripts_dir}/test_serial.sh ;;
    4) ${scripts_dir}/test_ram.sh ;;
    5) ${scripts_dir}/test_rom.sh ;;
    6) ${scripts_dir}/test_usb_hub.sh ;;
    7) ${scripts_dir}/test_sd_card.sh ;;
    8) ${scripts_dir}/test_nvme.sh ;;
    9) ${scripts_dir}/test_rtc.sh ;;
    10) ${scripts_dir}/test_lte.sh ;;
    11) ${scripts_dir}/test_lan7800.sh ;;
    12) ${scripts_dir}/test_GPIO.sh ;;
    13) ${scripts_dir}/test_alarm_IO.sh ;;
    14) ${scripts_dir}/test_usb_type_a.sh ;;
    15) ${scripts_dir}/test_reset_button.sh ;;
    16) ${scripts_dir}/test_camera.sh ;;
    17) echo "Exiting..."; exit 0 ;;
    *) echo "Invalid choice. Please select a number between 1 and 17." ;;
esac

exit $result
