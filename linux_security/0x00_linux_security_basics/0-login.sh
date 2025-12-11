#!/bin/bash
last -n 5 | grep -E '^root|^reboot'
