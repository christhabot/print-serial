import serial
import sys
from datetime import datetime

if len(sys.argv) != 3:
    print("Usage: printserial <COM port> <baud>")
    sys.exit(1)

port = sys.argv[1]
baud = int(sys.argv[2])

try:
    s = serial.Serial(port, baud, timeout=0)
    print(f"[+] Listening on {port} at {baud} baud. Press Ctrl+C to stop.")
    buffer = b""
    while True:
        chunk = s.read(1024)
        if chunk:
            buffer += chunk
            while b"\n" in buffer:
                line, buffer = buffer.split(b"\n", 1)
                line_str = line.decode(errors='ignore').rstrip()
                timestamp = datetime.now().strftime("%H:%M:%S.%f")[:-3]
                print(f"{timestamp} -> {line_str}")
except KeyboardInterrupt:
    print("\n[!] Exiting safely...")
except serial.SerialException as e:
    print(f"[!] Serial error: {e}")
finally:
    try:
        s.close()
    except:
        pass
