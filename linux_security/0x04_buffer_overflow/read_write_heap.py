#!/usr/bin/python3
"""
Script that finds and replaces a string in the heap of a running process.

Usage: read_write_heap.py pid search_string replace_string
where pid is the pid of the running process
and strings are ASCII
"""

import sys


def print_usage_and_exit():
    """Print usage message and exit with status code 1."""
    print("Usage: read_write_heap.py pid search_string replace_string")
    sys.exit(1)


def find_heap(pid):
    """
    Parse /proc/pid/maps to find the heap memory region.

    Args:
        pid: the process id of the target process

    Returns:
        A tuple (heap_start, heap_end) with the addresses as integers
    """
    maps_path = "/proc/{}/maps".format(pid)

    try:
        with open(maps_path, "r") as maps_file:
            for line in maps_file:
                if "[heap]" in line:
                    addr_range = line.split()[0]
                    heap_start, heap_end = [
                        int(x, 16) for x in addr_range.split("-")
                    ]
                    return heap_start, heap_end
    except FileNotFoundError:
        print("Error: Process {} not found".format(pid))
        sys.exit(1)
    except PermissionError:
        print("Error: Permission denied for process {}".format(pid))
        sys.exit(1)

    print("Error: Could not find heap in process maps")
    sys.exit(1)


def read_write_heap(pid, search_string, replace_string):
    """
    Find and replace a string in the heap of a running process.

    Args:
        pid: the process id of the target process
        search_string: the ASCII string to search for
        replace_string: the ASCII string to replace with
    """
    heap_start, heap_end = find_heap(pid)
    heap_size = heap_end - heap_start

    print("[*] Found heap: {} - {}".format(hex(heap_start), hex(heap_end)))
    print("[*] Heap size: {} bytes".format(heap_size))

    mem_path = "/proc/{}/mem".format(pid)

    try:
        with open(mem_path, "rb+") as mem_file:
            mem_file.seek(heap_start)
            heap_data = mem_file.read(heap_size)

            search_bytes = search_string.encode("ASCII")
            replace_bytes = replace_string.encode("ASCII")

            offset = heap_data.find(search_bytes)

            if offset == -1:
                print(
                    "Error: String '{}' not found in heap".format(
                        search_string
                    )
                )
                sys.exit(1)

            print(
                "[*] Found '{}' at address {}".format(
                    search_string, hex(heap_start + offset)
                )
            )

            if len(replace_bytes) < len(search_bytes):
                replace_bytes += b'\x00' * (
                    len(search_bytes) - len(replace_bytes)
                )

            mem_file.seek(heap_start + offset)
            mem_file.write(replace_bytes)

            print(
                "[*] Replaced '{}' with '{}'".format(
                    search_string, replace_string
                )
            )

    except PermissionError:
        print(
            "Error: Permission denied to access memory of process {}".format(
                pid
            )
        )
        sys.exit(1)
    except Exception as e:
        print("Error: {}".format(e))
        sys.exit(1)


if __name__ == "__main__":
    if len(sys.argv) != 4:
        print_usage_and_exit()

    try:
        pid = int(sys.argv[1])
    except ValueError:
        print("Error: pid must be an integer")
        sys.exit(1)

    search_string = sys.argv[2]
    replace_string = sys.argv[3]

    read_write_heap(pid, search_string, replace_string)
