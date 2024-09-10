#!/bin/bash

current_dir="$(cd "$(dirname "$0")" && pwd)"
result=0

scripts_dir="${current_dir}/remote/scripts"

. ${current_dir}/common/common.sh
. ${current_dir}/error/error.sh

# Main script
echo "Select a function to test:"
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
echo "14. DP(Dissplay Port)"
echo "15. GPIO"
echo "16. Camera"
echo "17. Exit"
read -p "Enter your choice (1-17): " choice


case $choice in
    1) ${scripts_dir}/test_power_button.sh ;;
    2) ${scripts_dir}/test_serial.sh ;;
    3) ${scripts_dir}/test_ram.sh ;;
    4) ${scripts_dir}/test_rom.sh ;;
    5) ${scripts_dir}/test_usb_hub.sh ;;
    6) ${scripts_dir}/test_usb_type_a.sh ;;
    7) ${scripts_dir}/test_sd_card.sh ;;
    8) ${scripts_dir}/test_reset_button.sh ;;
    9) ${scripts_dir}/test_nvme.sh ;;
    10) ${scripts_dir}/test_rtc.sh ;;
    11) ${scripts_dir}/test_lte.sh ;;
    12) ${scripts_dir}/test_lan7800.sh ;;
    13) ${scripts_dir}/test_alarm_IO.sh ;;
    14) ${scripts_dir}/test_DP.sh ;;
    15) ${scripts_dir}/test_GPIO.sh ;;
    16) ${scripts_dir}/test_camera.sh ;;
    17) echo "Exiting..."; exit 0 ;;
    *) echo "Invalid choice. Please select a number between 1 and 17." ;;
esac

exit $result
