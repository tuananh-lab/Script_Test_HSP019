# Guide for Using the Test_HSP019 Directory to Test AIBOX Functionality

## Table of Contents
1. [Introduction](#introduction)
2. [Directory Structure](#directory-structure)
3. [Usage Instructions](#usage-instructions)
4. [Function List](#function-list)
5. [Notes When Testing Functions](#notes-when-testing-functions)

## Introduction

The `Test_HSP019` directory provides scripts and resources necessary to test the functionalities of the AIBOX device. You can use the files in this directory to conduct tests and verify the operation of various functions of AIBOX.

## Directory Structure

- **`asset/`**: Contains images related to function testing.
- **`common/`**: Contains the `common.sh` file, defining shared macros used during testing.
- **`error/`**: Contains the `error.sh` file, defining macros related to errors during testing.
- **`remote/`**: Contains scripts used to test specific functions and file `testfull.sh` to check full function if you want
- **`test.sh`**: The main executable file you will use to test functions.

## Usage Instructions

1. Open the terminal and navigate to the directory containing the `test.sh` file:

    ```bash
    cd /home/Test_HSP019
    ```

2. Grant execution permission to the `test.sh` file:

    ```bash
    chmod +x test.sh
    ```

3. Run the `test.sh` file:

    ```bash
    ./test.sh
    ```

After running the executable file, you will see the following list of functions:

    1.Power Button
    2.Serial Port
    3.RAM
    4.ROM
    5.USB HUB 3.0
    6.USB TYPE-A (4 ports)
    7.SD Card
    8.Factory Reset Button
    9.NVMe
    10.RTC
    11.LTE 4G
    12.LAN7800
    13.Alarm IO
    14.DP(Display Port)
    15.GPIO
    16.Camera
    17.Exit
    Enter your choice (1-17):


## Example Result When Testing RAM

When you choose the RAM test function, you will see the following result:

Select a function to test:

    1.Power Button
    2.Serial Port
    3.RAM
    4.ROM
    5.USB HUB 3.0
    6.USB TYPE-A (4 ports)
    7.SD Card
    8.Factory Reset Button
    9.NVMe
    10.RTC
    11.LTE 4G
    12.LAN7800
    13.Alarm IO
    14.DP(Display Port)
    15.GPIO
    16.Camera
    17.Exit 
    Enter your choice (1-17): 3 
    Testing RAM 
    Total Memory: 7.1Gi 
    RAM test done


You just need to select the function you want to test by entering the corresponding number.

## Notes When Testing Functions

Some functions cannot be verified through scripts alone and require physical actions:

- **Power Button**: Unplug the power, press the button, and check the boot log via console. Log in with the account: `root/oelinux123`.
- **DP (DisplayPort)**: Plug a type-C to HDMI adapter into the monitor and check the display on the screen.

Some functions require a combination of running the script and performing physical actions:

- **USB TYPE-A**: Insert USB 2.0 and 3.0 drives into the 4 TYPE-A ports and check the results on the terminal.
- **SD Card**: Insert an SD card into the slot and check the results on the terminal.
- **Factory Reset Button**: Run the script, press the button, and check the results on the terminal.
- **Alarm IO**: When running the script, you will hear the relay click on/off.
- **GPIO**: Run the script and measure the voltage on pins 2, 3, 4, and 5 of J1101 to check if it reaches 1.8V.
- **Camera**: Plug in the IMX219 or IMX477 camera and check the results on the terminal.

Make sure to perform the testing steps accurately to ensure the AIBOX functions operate as required.


