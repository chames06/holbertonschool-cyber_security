#!/bin/bash
john --format=raw-sha256 --wordlist=/usr/share/wordlists/rockyou.txt "$1"; john --format=raw-sha256 --show "$1" | cut -d ':' -f2 > 6-password.txt
