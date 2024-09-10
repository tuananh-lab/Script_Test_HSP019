#!/bin/bash

# get dir
current_dir="$(cd "$(dirname "$0")" && pwd)"

# add libs
. ${current_dir}/../common/common.sh
. ${current_dir}/../error/error.sh

# set log file location
export log_file="${current_dir}/remote_test.log"
echo -n "" > $log_file

# ALARM_IO
${current_dir}/scripts/test_alarm_IO.sh

# CAMERA
${current_dir}/scripts/test_camera.sh

# DP(Dissplay Port)
${current_dir}/scripts/test_DP.sh

# GPIO
${current_dir}/scripts/test_GPIO.sh

# LAN7800
${current_dir}/scripts/test_lan7800.sh

# LTE
${current_dir}/scripts/test_lte.sh

# NVMe
${current_dir}/scripts/test_nvme.sh

# POWER_BUTTON
${current_dir}/scripts/test_power_button.sh

# RAM
${current_dir}/scripts/test_ram.sh

# ROM   
${current_dir}/scripts/test_rom.sh

# RTC
${current_dir}/scripts/test_rtc.sh

# SD_CARD
${current_dir}/scripts/test_sd_card.sh

# USB_HUB
${current_dir}/scripts/test_usb_hub.sh

# USB_TYPE_A
${current_dir}/scripts/test_usb_type_a.sh

# SERIAL
${current_dir}/scripts/test_serial.sh

# FACTORY_RESET_BUTTON
${current_dir}/scripts/test_reset_button.sh


# exit
exit 0