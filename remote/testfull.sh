#!/bin/bash

# get dir
current_dir="$(cd "$(dirname "$0")" && pwd)"

# add libs
. ${current_dir}/../common/common.sh
. ${current_dir}/../error/error.sh

# set log file location
export log_file="${current_dir}/remote_test.log"
echo -n "" > $log_file

# Ensure all scripts have executable permissions
chmod +x ${current_dir}/scripts/*.sh

# Function to run each test and add a line separator
run_test() {
    script_path="$1"
    echo "Running test: ${script_path}"
    ${script_path}
    echo 
}

# ALARM_IO
run_test "${current_dir}/scripts/test_alarm_IO.sh"

# CAMERA
run_test "${current_dir}/scripts/test_camera.sh"

# DP(Dissplay Port)
run_test "${current_dir}/scripts/test_DP.sh"

# GPIO
run_test "${current_dir}/scripts/test_GPIO.sh"

# LAN7800
run_test "${current_dir}/scripts/test_lan7800.sh"

# LTE
run_test "${current_dir}/scripts/test_lte.sh"

# NVMe
run_test "${current_dir}/scripts/test_nvme.sh"

# POWER_BUTTON
run_test "${current_dir}/scripts/test_power_button.sh"

# RAM
run_test "${current_dir}/scripts/test_ram.sh"

# ROM   
run_test "${current_dir}/scripts/test_rom.sh"

# RTC
run_test "${current_dir}/scripts/test_rtc.sh"

# SD_CARD
run_test "${current_dir}/scripts/test_sd_card.sh"

# USB_HUB
run_test "${current_dir}/scripts/test_usb_hub.sh"

# USB_TYPE_A
run_test "${current_dir}/scripts/test_usb_type_a.sh"

# SERIAL
run_test "${current_dir}/scripts/test_serial.sh"

# FACTORY_RESET_BUTTON
run_test "${current_dir}/scripts/test_reset_button.sh"


# exit
exit 0