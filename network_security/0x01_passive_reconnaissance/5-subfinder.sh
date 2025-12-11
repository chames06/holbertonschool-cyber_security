#!/bin/bash
subfinder -d $1 -silent | tee >(dnsx -silent -resp-only -a -o $1.txt)
