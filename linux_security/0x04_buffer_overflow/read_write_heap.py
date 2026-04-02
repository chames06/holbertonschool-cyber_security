#!/usr/bin/env python3
"""Script that finds and replaces a string in the heap of a running process."""

import sys
import os


def main():
    if len(sys.argv) != 4:
        print("Usage: read_write_heap.py pid search_string replace_string")
        sys.exit(1)

    pid = sys.argv[1]
    search_string = sys.argv[2]
    replace_string = sys.argv[3]

    # Validate pid
    try:
        pid = int(pid)
    except ValueError:
        print("Error: pid must be an integer")
        sys.exit(1)

    # Parse /proc/pid/maps to find the heap
    maps_path = f"/proc/{pid}/maps"
    mem_path = f"/proc/{pid}/mem"

    try:
        with open(maps_path, "r") as maps_file:
            heap_start = None
            heap_end = None
            for line in maps_file:
                if "[heap]" in line:
                    addr_range = line.split()[0]
                    heap_start, heap_end = [
                        int(x, 16) for x in addr_range.split("-")
                    ]
                    print(f"[*] Found heap: {hex(heap_start)} - {hex(heap_end)}")
                    break

            if heap_start is None:
                print("Error: Could not find heap in process maps")
                sys.exit(1)

    except FileNotFoundError:
        print(f"Error: Process {pid} not found")
        sys.exit(1)
    except PermissionError:
        print(f"Error: Permission denied to read maps of process {pid}")
        sys.exit(1)

    # Read the heap and search for the string
    try:
        with open(mem_path, "rb+") as mem_file:
            mem_file.seek(heap_start)
            heap_size = heap_end - heap_start
            heap_data = mem_file.read(heap_size)
            print(f"[*] Heap size: {heap_size} bytes")

            search_bytes = search_string.encode("ASCII")
            replace_bytes = replace_string.encode("ASCII")

            offset = heap_data.find(search_bytes)

            if offset == -1:
                print(f"Error: String '{search_string}' not found in heap")
                sys.exit(1)

            print(f"[*] Found '{search_string}' at offset {offset} "
                  f"(address {hex(heap_start + offset)})")

            # Pad replacement with null bytes if shorter
            if len(replace_bytes) < len(search_bytes):
                replace_bytes += b'\x00' * (len(search_bytes) - len(replace_bytes))

            # Write the replacement string
            mem_file.seek(heap_start + offset)
            mem_file.write(replace_bytes)
            print(f"[*] Replaced '{search_string}' with '{replace_string}'")

    except PermissionError:
        print(f"Error: Permission denied to access memory of process {pid}")
        sys.exit(1)
    except Exception as e:
        print(f"Error: {e}")
        sys.exit(1)


if __name__ == "__main__":
    main()
