#!/bin/bash

# Check if the correct number of arguments was provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <path-to-file-or-folder> <s3-bucket-path>"
    exit 1
fi

source .scripts/helpers/assert-active-aws-session.sh

# Assign input arguments to variables
path="$1"
s3bucket="$2"
s3bucketPath="$3"


# Function to check remote file and upload
upload_file() {
    local file_path="$1"
    local filename=$(basename "$file_path")
    local datetime=$(date "+%Y%m%d%H%M%S")

    # Check if file exists in S3 bucket
    if aws s3 ls "${s3bucket}${s3bucketPath}/${filename}" > /dev/null; then
        echo "File exists. Renaming remote file."
        aws s3 cp "s3://${s3bucket}${s3bucketPath}/${filename}" "s3://${s3bucket}${s3bucketPath}/${filename%.csv}.${datetime}.bak"
        aws s3 rm "s3://${s3bucket}${s3bucketPath}/${filename}"
    fi

    # Upload the file
    aws s3 cp "${file_path}" "s3://${s3bucket}${s3bucketPath}/${filename}"
    echo "Uploaded ${file_path} to s3://${s3bucket}${s3bucketPath}/${filename}"
}

# Check if the provided path is a file or a directory
if [ -f "$path" ]; then
    # If it's a file, check if it's a CSV
    if [[ "$path" == *.csv ]]; then
        upload_file "$path"
    else
        echo "Provided file is not a CSV file."
        exit 1
    fi
elif [ -d "$path" ]; then
    # If it's a directory, find all CSV files and upload them
    find "$path" -type f -name '*.csv' | while read -r file; do
        upload_file "$file"
    done
else
    echo "The provided path does not exist."
    exit 1
fi
