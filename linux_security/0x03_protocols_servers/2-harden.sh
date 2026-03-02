#!/bin/bash
find / -xdev -type d -perm -0002 -path -exec chmod o-w {} +
