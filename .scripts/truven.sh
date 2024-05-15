#!/bin/bash

# Function to list local files
list_local() {
    if [ $# -ne 1 ]; then
        echo "Usage: list-local <pattern>"
        exit 1
    fi
    ls -lah /t/*$1*.sas7bdat
}

# Function to list remote files
list_remote() {
    if [ $# -ne 2 ]; then
        echo "Usage: list-remote <s3_bucket_name> <pattern>"
        exit 1
    fi
    aws s3 ls s3://$1/truven-files/$2  --region us-east-1
}

# Function to clone files to a remote location
clone() {
    if [ $# -ne 2 ]; then
        echo "Usage: clone <pattern> <s3_bucket_name>"
        exit 1
    fi

    pattern=$1
    s3_bucket_name=$2

    # Check AWS credentials
    if [ -z "$AWS_ACCESS_KEY_ID" ] || [ -z "$AWS_SECRET_ACCESS_KEY" ]; then
        echo "AWS credentials not set."
        read -p "Enter AWS Access Key ID: " AWS_ACCESS_KEY_ID
        read -p "Enter AWS Secret Access Key: " AWS_SECRET_ACCESS_KEY
        export AWS_ACCESS_KEY_ID
        export AWS_SECRET_ACCESS_KEY
    else
        echo "Current AWS credentials: Access Key ID: $AWS_ACCESS_KEY_ID"
        read -p "Would you like to proceed with these credentials? (yes/no): " decision

        if [ "$decision" != "yes" ]; then
            read -p "Enter AWS Access Key ID: " AWS_ACCESS_KEY_ID
            read -p "Enter AWS Secret Access Key: " AWS_SECRET_ACCESS_KEY
            export AWS_ACCESS_KEY_ID
            export AWS_SECRET_ACCESS_KEY
        fi
    fi

    echo "Files to be uploaded:"
    ls -lah /t/*$pattern*.sas7bdat

    read -p "Do you want to proceed with the upload? (yes/no): " upload_decision

    if [ "$upload_decision" == "yes" ]; then
        ls /t/*$pattern*.sas7bdat | xargs -I {} aws s3 cp {} s3://$s3_bucket_name/truven-files
    fi
}

# Main script logic to process commands
if [ "$1" == "list-local" ]; then
    list_local "$2"
elif [ "$1" == "list-remote" ]; then
    list_remote "$2" "$3"
elif [ "$1" == "clone" ]; then
    clone "$2" "$3"
else
    echo "Invalid command. Use 'list-local', 'list-remote', or 'clone'."
    exit 1
fi

