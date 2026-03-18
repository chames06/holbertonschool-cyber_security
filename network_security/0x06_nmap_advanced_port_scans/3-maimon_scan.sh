#!/bin/bash
sudo nmap -sM $1 -p http, https, ftp, ssh, telnet -vv 
