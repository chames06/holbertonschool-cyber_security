#!/bin/bash
sestatus | grep "SELinux status:" | cut -d: -f2- | xargs
