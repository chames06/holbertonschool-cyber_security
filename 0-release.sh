#!/bin/bash

echo $(grep -oP '(?<=^ID=).+' /etc/os-release)
