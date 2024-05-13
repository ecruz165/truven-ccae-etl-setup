#!/usr/bin/env python3

import csv
import os
import sys

def escape_special_characters(field):
    # Escapes double quotes, single quotes, and backticks
    field = field.replace('"', '\\"')  # Escape double quotes
    field = field.replace("'", "\\'")  # Escape single quotes
    field = field.replace("`", "\\`")  # Escape backticks
    return field

def escape_quotes_in_csv(file_path):
    backup_file_path = file_path + '.backup'

    # Set a reasonable maximum field size limit
    max_int_c_long = 2**31 - 1  # Max size for a 32-bit integer
    csv.field_size_limit(max_int_c_long)

    try:
        # Check if a backup file exists
        if not os.path.exists(backup_file_path):
            # Create a backup of the original file
            with open(file_path, 'r', newline='', encoding='utf-8') as original_file:
                original_content = original_file.read()
            with open(backup_file_path, 'w', newline='', encoding='utf-8') as backup_file:
                backup_file.write(original_content)
            print("Backup created.")

        # Read the original file and escape quotes
        modified_rows = []
        with open(file_path, 'r', newline='', encoding='utf-8') as csvfile:
            reader = csv.reader(csvfile)
            for row in reader:
                modified_row = [escape_special_characters(field) for field in row]
                modified_rows.append(modified_row)
        
        # Write the escaped content back to the file
        with open(file_path, 'w', newline='', encoding='utf-8') as csvfile:
            writer = csv.writer(csvfile)
            writer.writerows(modified_rows)
            print(f"Modified content written back to {file_path}")

    except Exception as e:
        print(f"An error occurred: {e}")

# Example usage: python script_name.py path/to/your/file.csv
if len(sys.argv) > 1:
    file_path = sys.argv[1]
    escape_quotes_in_csv(file_path)
else:
    print("Please provide the file path as an argument.")
