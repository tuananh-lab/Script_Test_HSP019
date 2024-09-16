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

- **`asset/`**: Contains images related to function testing.
- **`common/`**: Contains the `common.sh` file, which defines shared macros used during testing.
- **`error/`**: Contains the `error.sh` file, which defines macros related to errors during testing.
- **`remote/`**: Includes the following:
  - **scripts directory**: Contains scripts testing specific functions.
  - **result directory**: Contains result files for each script file in the scripts directory.
  - **`testfull.sh`**: Checks all functions.
  - **`testfull.log`**: Logs results from running `testfull.sh`.
- **`test.sh`**: The main executable file used to test functions.
- **`remote_test.sh`**: The executable file used to remotely test functions via IP address.
- **`remote_test.log`**: Contains log results from running `remote_test.sh`.

---

## Usage Instructions

### I. Test Each Function

1. **Access the box via SSH using the IP address**:
    ```bash
    ssh IP_of_box
    ```

2. **Navigate to the directory containing the `test.sh` file**:
    ```bash
    cd /dir/HSP019_Test
    ```

3. **Grant execution permission to the `test.sh` file**:
    ```bash
    chmod +x test.sh
    ```

4. **Run the `test.sh` file**:
    ```bash
    ./test.sh
    ```

   After running the executable, a list of functions will appear:
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

    Enter your choice (1-17).

---

### Example Result When Testing RAM

When selecting the RAM test function, the following result will display:


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

1. **Access the box via SSH**:
    ```bash
    ssh IP_of_box
    ```

2. **Navigate to the `remote` directory**:
    ```bash
    cd /dir/HSP019_Test/remote
    ```

3. **Grant execution permission to the `testfull.sh` file**:
    ```bash
    chmod +x testfull.sh
    ```

4. **Run the `testfull.sh` file**:
    ```bash
    ./testfull.sh
    ```

5. All result files for each test function are in the `result` directory, and logs are in `testfull.log`.

---

### III. Test Remotely Through Box IP Address

1. **Install `sshpass`**:
    ```bash
    sudo apt update
    sudo apt install sshpass
    ```

2. **Navigate to the directory containing the `remote_test.sh` file**:
    ```bash
    cd /dir/HSP019_Test
    ```

3. **Grant execution permission to the `remote_test.sh` file**:
    ```bash
    chmod +x remote_test.sh
    ```

4. **Run the `remote_test.sh` file with the IP address of the box**:
    ```bash
    ./remote_test.sh IP_of_box
    ```

5. **Enter the password `oelinux123` and select the function to test from the list.**  
   Log results will be contained in `remote_test.log`.

---

## Function List

- **Power**: Tests the functionality of the power system.
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

---

## Notes When Testing Functions

Some functions are not available remotely:

- **Power**
- **Factory Reset Button**
- **DP (Display Port)**
- **Camera**

Some functions require physical actions to verify:

- **Power**: Supply power for the board and check the boot log via console. Log in with `root/oelinux123`.
- **DP (DisplayPort)**: Connect a Type-C to HDMI adapter to a monitor and check the display.

For others, a combination of scripts and physical actions is needed:

- **USB TYPE-A**: Insert USB 2.0 and 3.0 drives into the four ports and check the results on the terminal.
- **SD Card**: Insert an SD card into the slot and check the terminal.
- **NVMe**: Insert an SSD NVMe into the slot and verify via terminal.
- **Factory Reset Button**: Run the script, press the button, and check the terminal output.
- **Alarm IO**: The relay will click on/off when running the script.
- **GPIO**: Measure the voltage on pins 2, 3, 4, and 5 of J1101 (should reach 1.8V).
- **Camera**: Select the type of camera, and choose:
  - **View Mode**: Requires a display port connection.
  - **Record Mode**: The recorded MP4 will be saved in `/data` on the board. Verify with VLC or `ffplay`.

---

Make sure to follow these steps accurately for successful AIBOX testing.
