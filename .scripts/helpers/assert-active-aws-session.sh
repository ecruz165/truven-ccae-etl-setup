#!/bin/bash

# Check for a valid AWS session by attempting to list S3 buckets
if ! aws s3 ls >/dev/null 2>&1; then
    echo "AWS session not active or invalid credentials. Please check your AWS configuration."
    exit 1
fi



