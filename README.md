# Guide for Using the HSP019_Test Directory to Test AIBOX Functionality

## Table of Contents
1. [Introduction](#introduction)
2. [Directory Structure](#directory-structure)
3. [Usage Instructions](#usage-instructions)
4. [Function List](#function-list)
5. [Notes When Testing Functions](#notes-when-testing-functions)

## Introduction

The `HSP019_Test` directory provides scripts and resources necessary for testing the functionalities of the AIBOX device. Use the files in this directory to conduct tests and verify the operation of various AIBOX functions.

## Directory Structure

- **`asset/`**: Contains images related to function testing.
- **`common/`**: Contains the `common.sh` file, which defines shared macros used during testing.
- **`error/`**: Contains the `error.sh` file, which defines macros related to errors during testing.
- **`remote/`**: Include scripts directory contain scripts testing specific functions, result directory contain result file for each script file in scripts directory,  file `testfull.sh` for checking all functions and file `testfull.log` contain log result when run `testfull.sh`. 
- **`test.sh`**: The main executable file used to test functions.
- **`remote_test.sh`**: The executable file used to remote test function via IP address.
- **`remote_test.log`**: File contain log result when run `remote_test.log`.

## Usage Instructions

### I. Test Each Function

1. **Access the box via SSH using IP address:**
    ```bash
    ssh IP_of_box
    ```

2. **Navigate to the directory containing the `test.sh` file:**
    ```bash
    cd /dir/HSP019_Test
    ```

3. **Grant execution permission to the `test.sh` file:**
    ```bash
    chmod +x test.sh
    ```

4. **Run the `test.sh` file:**
    ```bash
    ./test.sh
    ```

   After running the executable, you will see a list of functions to test:

    ```
    1. Power
    2. Serial Port
    3. RAM
    4. ROM
    5. USB HUB 3.0
    6. USB TYPE-A (4 ports)
    7. SD Card
    8. Factory Reset Button
    9. NVMe
    10. RTC
    11. LTE 4G
    12. LAN7800
    13. Alarm IO
    14. DP (Display Port)
    15. GPIO
    16. Camera
    17. Exit
    ```

    Enter your choice (1-17):

## Example Result When Testing RAM

When you select the RAM test function, you will see the following result:

    ```
    Select a function to test:
    1. Power
    2. Serial Port
    3. RAM
    4. ROM
    5. USB HUB 3.0
    6. USB TYPE-A (4 ports)
    7. SD Card
    8. Factory Reset Button
    9. NVMe
    10. RTC
    11. LTE 4G
    12. LAN7800
    13. Alarm IO
    14. DP (Display Port)
    15. GPIO
    16. Camera
    17. Exit
    Enter your choice (1-17): 3
    Testing RAM
    Total Memory: 7.1Gi
    RAM test done
    ```

You just need to select the function you want to test by entering the corresponding number.

### II. Test Full Function

1. **Access the box via SSH using its IP address:**
    ```bash
    ssh IP_of_box
    ```

2. **Navigate to the `remote` directory:**
    ```bash
    cd /dir/HSP019_Test/remote
    ```

3. **Grant execution permission to the `testfull.sh` file:**
    ```bash
    chmod +x testfull.sh
    ```

4. **Run the `testfull.sh` file:**
    ```bash
    ./testfull.sh
    ```
5. All files result of each functions test have in result directory and it contained in `testfull.log`

### III. Test Remotely Through Box IP Address

1. **Install `sshpass`:**
    ```bash
    sudo apt update
    sudo apt install sshpass
    ```

2. **Navigate to the directory containing the `remote_test.sh` file:**
    ```bash
    cd /dir/HSP019_Test
    ```

3. **Grant execution permission to the `remote_test.sh` file:**
    ```bash
    chmod +x remote_test.sh
    ```

4. **Run the `remote_test.sh` file with the IP address of the box:**
    ```bash
    ./remote_test.sh IP_of_box
    ```

5. **Enter the password `oelinux123` and select the function to test from the list.**
6. Log result it contained in `remote_test.log`
## Function List

- **Power**: Tests the functionality of the power.
- **Serial Port**: Checks the operation of the serial port.
- **RAM**: Tests the system memory.
- **ROM**: Verifies the read-only memory.
- **USB HUB 3.0**: Tests the USB hub functionality.
- **USB TYPE-A (4 ports)**: Checks the four TYPE-A USB ports.
- **SD Card**: Tests the SD card slot.
- **Factory Reset Button**: Verifies the factory reset functionality.
- **NVMe**: Tests the NVMe storage.
- **RTC**: Checks the real-time clock.
- **LTE 4G**: Tests LTE 4G connectivity.
- **LAN7800**: Verifies the LAN7800 Ethernet functionality.
- **Alarm IO**: Tests the alarm input/output.
- **DP (Display Port)**: Checks the Display Port functionality.
- **GPIO**: Tests the general-purpose input/output pins.
- **Camera**: Verifies the operation of the camera.

## Notes When Testing Functions

When using remote testing, some testing functions may not be available:
- **Power**
- **Factory Reset Button**
- **DP (Display Port)**
- **Camera**

Some functions cannot be verified through scripts alone and require physical actions:
- **Power**: Supply power for board, and check the boot log via console. Log in with the account: `root/oelinux123`.
- **DP (DisplayPort)**: Plug a type-C to HDMI adapter into the monitor and check the display on the screen.

Some functions require a combination of running the script and performing physical actions:
- **USB TYPE-A**: Insert USB 2.0 and 3.0 drives into the 4 TYPE-A ports and check the results on the terminal.
- **SD Card**: Insert an SD card into the slot and check the results on the terminal.
- **NVMe**: Insert an SSD NVMe hard disk into the slot and check the results on the terminal.
- **Factory Reset Button**: Run the script, press the button, and check the results on the terminal.
- **Alarm IO**: When running the script, you will hear the relay click on/off.
- **GPIO**: Run the script and measure the voltage on pins 2, 3, 4, and 5 of J1101 to check if it reaches 1.8V.
- **Camera**: Select the type of camera to test, then choose between two modes:
    - **View Mode**: Ensure you have a display port connected to view the camera feed on the screen.
    - **Record Mode**: The recorded MP4 file will be stored in the `/data` directory on the board. Verify the recording by playing the MP4 file with VLC, `ffplay`, or any other media player.

Make sure to perform the testing steps accurately to ensure the AIBOX functions operate as required.
