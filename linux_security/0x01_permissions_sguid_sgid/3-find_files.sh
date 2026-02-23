#!/bin/bash
find "$1" -type f -perm /6000 -ls 2>/dev/null
