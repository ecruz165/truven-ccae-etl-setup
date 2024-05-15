#!/bin/bash

# Check if the correct number of arguments was provided
if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <path-to-file-or-folder> <s3-bucket> <s3-bucket-path>"
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
    echo "Uploading ${file_path} to s3://${s3bucket}${s3bucketPath}/${filename}"
    # Check if file exists in S3 bucket
    if aws s3 ls "${s3bucket}${s3bucketPath}/${filename}" > /dev/null; then
        echo "File exists. Renaming remote file."
        aws s3 cp "s3://${s3bucket}${s3bucketPath}/${filename}" "s3://${s3bucket}${s3bucketPath}/${filename}.${datetime}.bak"
        aws s3 rm "s3://${s3bucket}${s3bucketPath}/${filename}"
    fi

    # Upload the file
    aws s3 cp "${file_path}" "s3://${s3bucket}${s3bucketPath}/${filename}"
    echo "Uploaded ${file_path} to s3://${s3bucket}${s3bucketPath}/${filename}"
}

# Function to upload files
upload_file() {
    local file="$1"
    echo "Uploading file: $file"
    # Add your upload command here
}

# Check if the provided path is a file or a directory
if [ -f "$path" ]; then
    # If it's a file, check the extension
    case "$path" in
        *.csv | *.csv.gz | *.parquet | *.sas7bdat)
            upload_file "$path"
            ;;
        *)
            echo "Provided file is not a supported file type (.csv, .csv.gz, .parquet, .sas7bdat)."
            exit 1
            ;;
    esac
elif [ -d "$path" ]; then
    echo "Uploading all supported files in the provided directory: $path"
    # If it's a directory, find all supported files and upload them
    find "$path" -type f \( -name '*.csv' -o -name '*.csv.gz' -o -name '*.parquet' -o -name '*.sas7bdat' \) | while read -r file; do
        upload_file "$file"
    done
else
    echo "The provided path does not exist."
    exit 1
fi

