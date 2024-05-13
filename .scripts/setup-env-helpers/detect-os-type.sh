#!/bin/bash

# Function to detect and output the operating system type
get_os_type() {
    case "$(uname -s)" in
        Linux*)     echo "linux" ;;
        Darwin*)    echo "macOS" ;;
        CYGWIN*|MINGW32*|MSYS*|MINGW64*) echo "windows" ;;
        *)          echo "unknown" ;;
    esac
}

# Call the function
get_os_type
