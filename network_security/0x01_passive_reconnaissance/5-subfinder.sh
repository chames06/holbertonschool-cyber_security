#!/bin/bash
subfinder -d $1 -silent | tee >(xargs -I {} sh -c 'echo {}; dig +short {} | head -1 | xargs -I IP echo {},{IP}' | grep -v "^[^,]*$" > $1.txt) | cat
