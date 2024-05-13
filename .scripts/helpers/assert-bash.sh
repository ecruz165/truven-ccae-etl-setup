#!/bin/bash

# Check if the BASH variable is set
if [[ -n "$BASH" ]]; then
    echo "check shell: PASS"
else
    echo "ERROR: You are not using a Bash shell."
    exit -1
fi
