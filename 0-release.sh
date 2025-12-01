#!/bin/bash
head -n 1 /etc/os-release | cut -d'=' -f2 | tr -d '\"'
