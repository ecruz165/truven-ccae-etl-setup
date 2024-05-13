#!/bin/bash

# Script arguments
REQUIREMENTS_FILE=$1  # Path to the requirements JSON file
PACKAGE_MANAGERS_FILE=".scripts/setup-env-helpers/package-managers.json"  # Path to the package managers JSON file
EXIT_IF_MISSING=$2  # Optional: exit with -1 if requirements are not met

# Function to check if a package is installed with the correct version
check_installed_version() {
    local package_manager=$1
    local check_command=$2
    local package_name=$3
    local required_version=$4
    local installed_info

    # Run the check installed command and search for the package
    installed_info=$(eval "$check_command" | grep "$package_name")

    # Extract installed version and compare with required version
    local installed_version=$(echo "$installed_info" | grep -oP '\b'$package_name'\b \K.*')
    if [[ -z "$installed_version" ]]; then
        printf "%-20s %-10s NOT INSTALLED\n" "$package_name" "$required_version"
        return 1
    elif [[ "$installed_version" == *"$required_version"* ]]; then
        printf "%-20s %-10s INSTALLED\n" "$package_name" "$required_version"
    else
        printf "%-20s %-10s VERSION MISMATCH (Installed: $installed_version)\n" "$package_name" "$required_version"
        return 1
    fi
}

# Main logic to parse JSON and check packages
all_good=1

os_type=$(.scripts/setup-env-helpers/detect-os-type.sh 2>&1)  # Redirect stderr to stdout to capture all output
echo "Detected OS type: $os_type"

requirements=$(jq -c '.[]' "$REQUIREMENTS_FILE")

# Print header
printf "%-20s %-10s %s\n" "Package" "Version" "Status"

# Iterate over requirements and check each one
while IFS= read -r requirement; do
    package_name=$(echo "$requirement" | jq -r '.name')
    required_version=$(echo "$requirement" | jq -r '.version')
    # Get appropriate package manager based on the package definition
    package_manager_name=$(echo "$requirement" | jq -r ".packageManager[] | .\"$os_type\"")

    # Get the package manager info from package-managers.json
    package_manager_info=$(jq -c '.packageManagers.'"$os_type"'[] | select(.name == "'"$package_manager_name"'")' "$PACKAGE_MANAGERS_FILE")
    check_command=$(echo "$package_manager_info" | jq -r '.check_installed_command')

    # Check if the package is installed correctly
    if ! check_installed_version "$package_manager_name" "$check_command" "$package_name" "$required_version"; then
        all_good=0
    fi
done <<< "$requirements"

# Exit handling
if [[ "$all_good" -eq 0 && "$EXIT_IF_MISSING" == "true" ]]; then
    exit -1
fi

exit 0
