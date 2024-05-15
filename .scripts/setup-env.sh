#!/bin/bash

# Script arguments
REQUIREMENTS_FILE=$1
PACKAGE_MANAGERS_FILE=".scripts/setup-env-helpers/package-managers.json"

# Detect OS type using an existing utility script
os_type=$(.scripts/setup-env-helpers/detect-os-type.sh 2>&1)
echo "Operating System detected: $os_type"

# Read requirements from the JSON file
requirements=$(jq -c '.[]' "$REQUIREMENTS_FILE")

# Function to install a package if it's missing
install_missing_package() {
    local package_name=$1
    local pm_name=$2
    local install_command=$3
    local check_command=$4

    # Check if the package is installed
    installed_info=$(eval "$check_command $package_name" | grep "$package_name")

    if [[ -z "$installed_info" ]]; then
        echo "Installing $package_name..."
        eval "$install_command $package_name"
    else
        echo "$package_name is already installed."
    fi
}

# Iterate over each requirement
while IFS= read -r requirement; do
    package_name=$(echo "$requirement" | jq -r '.name')
    package_manager_name=$(echo "$requirement" | jq -r ".packageManager[] | .\"$os_type\"")

    # Fetch the corresponding package manager info
    package_manager_info=$(jq -c '.packageManagers.'"$os_type"'[] | select(.name == "'"$package_manager_name"'")' "$PACKAGE_MANAGERS_FILE")
    install_command=$(echo "$package_manager_info" | jq -r '.install_command')
    check_command=$(echo "$package_manager_info" | jq -r '.check_installed_command')

    # Install the package if it's missing
    install_missing_package "$package_name" "$package_manager_name" "$install_command" "$check_command"
done <<< "$requirements"
