#!/bin/bash

# Define status codes
STATUS_OK="ok"
STATUS_ERROR="error"

# ROM test
STATUS_ROM_SIZE_ERROR="rom size error"
STATUS_ROM_OK="rom ok"

# RAM test
STATUS_RAM_SIZE_ERROR="ram size error"
STATUS_RAM_OK="ram ok"

# LAN test
STATUS_LAN_ERROR="lan error"
STATUS_LAN_ETH0_ERROR="eth0 error"
STATUS_LAN_ETH1_ERROR="eth1 error"
STATUS_WAN_ERROR="wan error"
STATUS_LAN_OK="lan ok"
STATUS_LAN_ETH0_OK="eth0 ok"
STATUS_LAN_ETH1_OK="eth1 ok"
STATUS_WAN_OK="wan ok"

# USB test
STATUS_USB_HUB_ERROR="usb hub error"
STATUS_USB_HUB_OK="usb hub ok"
STATUS_USB_TYPE_A_ERROR="usb type-a error"
STATUS_USB_TYPE_A_OK="usb type-a ok"

# SD Card test
STATUS_SD_CARD_ERROR="sd card error"
STATUS_SD_CARD_OK="sd card ok"

# Reset Button test
STATUS_RESET_BUTTON_ERROR="reset button error"
STATUS_RESET_BUTTON_OK="reset button ok"

# NVMe test
STATUS_NVME_ERROR="nvme error"
STATUS_NVME_OK="nvme ok"

# RTC test
STATUS_RTC_ERROR="rtc error"
STATUS_RTC_OK="rtc ok"

# LTE 4G test
STATUS_LTE_ERROR="lte error"
STATUS_LTE_OK="lte ok"

# LAN7800 test
STATUS_LAN7800_ERROR="lan7800 error"
STATUS_LAN7800_OK="lan7800 ok"

# Alarm IO test
STATUS_ALARM_IO_ERROR="alarm io error"
STATUS_ALARM_IO_OK="alarm io ok"

# DP (Display Port) test
STATUS_DP_ERROR="dp error"
STATUS_DP_OK="dp ok"

# GPIO test
STATUS_GPIO_ERROR="gpio error"
STATUS_GPIO_OK="gpio ok"

# Camera test
STATUS_CAMERA_ERROR="camera error"
STATUS_CAMERA_OK="camera ok"


# Helper functions
log() {
    echo "$(date) - $1"
}

file_exists() {
    [ -e "$1" ]
}
