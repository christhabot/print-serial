# PrintSerial

**PrintSerial** is a lightweight command-line serial port listener for Windows, macOS, and Linux. It reads data from a serial device and prints each line to the terminal with precise timestamps, making debugging and monitoring serial communications effortless.

## Features

- Real-time serial monitoring on any COM/serial port
- Millisecond-precision timestamps for each line
- Handles decoding errors gracefully
- Safe exit on `Ctrl+C`
- Minimal dependencies, simple to use

## Requirements

- Python 3.x
- [`pyserial`](https://pypi.org/project/pyserial/) library

Install pyserial via pip:

```bash
pip install pyserial
```

## How to use

- Install the latest release [here](https://github.com/christhabot/print-serial/releases)
- Run the `install.bat` script
- Open a **new** terminal
- Use the tool by running `printserial <COM port> <baud rate>`. Example: `printserial COM3 9600` tells the tool to start printing all incoming data from COM3 with a baud rate of 9600.

### Example output

```
00:23:23.660 -> This is an example incoming message!
00:23:23.689 -> Sensor value: 123
```

## Experienced issues or want to suggest a change?

Open an [issue](https://github.com/christhabot/print-serial/issues) explaining your problem or suggestion in detail!

## Want to contribute?

Open a [pull request](https://github.com/christhabot/print-serial/pulls)! You will become a contributor in this project, and help it evolve!
