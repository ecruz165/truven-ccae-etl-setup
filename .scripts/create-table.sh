#!/bin/bash

# Check if the correct number of arguments was provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <table-name> <sql-file-path>"
    exit 1
fi

source .scripts/helpers/assert-active-aws-session.sh

# Retrieve database configuration from environment variables
DB_NAME="${DB_NAME}"
DB_USERNAME="${DB_USERNAME}"
DB_PASSWORD="${DB_PASSWORD}"
DB_HOST="${DB_HOST}"
TABLE_NAME=$1
SQL_FILE=$2

# Redshift connection string, adapt the port if necessary (default is 5439)
PORT="5439"

# Command to check if the table exists in Redshift
CHECK_TABLE_EXISTS="SELECT EXISTS (
    SELECT * FROM pg_table_def 
    WHERE schemaname = 'public' AND tablename = '$TABLE_NAME'
);"

# Execute the SQL command to check for the table
export PGPASSWORD=$DB_PASSWORD
if psql -h "$DB_HOST" -p "$PORT" -U "$DB_USERNAME" -d "$DB_NAME" -t -c "$CHECK_TABLE_EXISTS" | grep -q 't'
then
    echo "Table $TABLE_NAME already exists."
else
    echo "Table $TABLE_NAME does not exist. Creating table..."
    psql -h "$DB_HOST" -p "$PORT" -U "$DB_USERNAME" -d "$DB_NAME" -a -f "$SQL_FILE"
fi
