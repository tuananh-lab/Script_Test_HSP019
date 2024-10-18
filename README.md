# Guide for Using the HSP019_Test Directory to Test AIBOX Functionality

## Table of Contents
1. [Introduction](#introduction)
2. [Directory Structure](#directory-structure)
3. [Usage Instructions](#usage-instructions)
4. [Function List](#function-list)
5. [Notes When Testing Functions](#notes-when-testing-functions)

---

## Introduction

The `HSP019_Test` directory provides scripts and resources necessary for testing the functionalities of the AIBOX device. Use the files in this directory to conduct tests and verify the operation of various AIBOX functions.

## Directory Structure

- **`scripts/`**: Contains scripts testing specific functions and contains the `common.sh` file, which defines shared macros used during testing and contains the `error.sh` file, which defines macros related to errors during testing.
- **`testfull.sh`**: The executable file used to test full functions of AIBOX via all specific scripts.

---

## Usage Instructions

### I. Test Each Function

1. **Access the box via SSH using the IP address**:
    ```bash
    ssh IP_of_box
    ```

2. **Navigate to the `Test` directory**:
    ```bash
    cd /dir/Test
    ```

3. **Run each test script function in 'scripts' directory**:


### II. Test Full Function

1. **Access the box via SSH**:
    ```bash
    ssh IP_of_box
    ```

2. **Navigate to the `Test` directory**:
    ```bash
    cd /dir/Test
    ```

3. **Grant execution permission to the `testfull.sh` file**:
    ```bash
    chmod +x testfull.sh
    ```

4. **Run the `testfull.sh` file**:
    ```bash
    ./testfull.sh
    ```

## Function List

- **Power**: Tests the functionality of the power system.
- **DP (Display Port)**: Checks the Display Port functionality.
- **Serial Port**: Checks the operation of the serial port.
- **RAM**: Tests the system memory.
- **ROM**: Verifies the read-only memory.
- **USB HUB 3.0**: Tests the USB hub functionality.
- **SD Card**: Tests the SD card slot.
- **NVMe**: Tests the NVMe storage.
- **RTC**: Checks the real-time clock.
- **LTE 4G**: Tests LTE 4G connectivity.
- **LAN7800**: Verifies the LAN7800 Ethernet functionality.
- **GPIO**: Tests the general-purpose input/output pins.
- **Alarm IO**: Tests the alarm input/output.
- **USB TYPE-A (4 ports)**: Checks the four TYPE-A USB ports.
- **Factory Reset Button**: Verifies the factory reset functionality.
- **Camera**: Verifies the operation of the camera.

---

## Notes When Testing Functions

Some functions require physical actions to verify:

- **Power**: Supply power for the board and check the boot log via console. Log in with `root/oelinux123`.
- **DP (DisplayPort)**: Connect a Type-C to HDMI adapter to a monitor and check the display.

For others, a combination of scripts and physical actions is needed:

- **USB TYPE-A**: Insert USB 2.0 and 3.0 drives into the four ports and check the results on the terminal.
- **SD Card**: Insert an SD card into the slot and check the terminal. Note that the SDcard does not accept hot plugging
- **NVMe**: Insert an SSD NVMe into the slot and verify via terminal.
- **Factory Reset Button**: Run the script, press the button, and check the terminal output.
- **Alarm IO**: The relay will click on/off when running the script.
- **GPIO**: Measure the voltage on pins 2, 3, 4, and 5 of J1101 (should reach 1.8V).
- **Camera**: Run view screen camera 0 first , send interrupt(Ctrl +C) then view screen camera 1 and send interupt(Ctrl + C) to complete.
  - **View Mode**: Requires a display port connection.
  - **Record Mode**: The recorded MP4 will be saved in `/data` on the board. Verify with VLC or `ffplay`.
---

Make sure to follow these steps accurately for successful AIBOX testing.
