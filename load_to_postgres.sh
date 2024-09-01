#!/bin/bash

# Database Credentials
DB_NAME="posey"
USER="your_username"
PASSWORD="your_password"

# Directory Path
CSV_DIR="./csv_folder"

# Loop through each CSV file in the directory
for FILE in "$CSV_DIR"/*.csv; do
    echo "Copying $FILE into PostgreSQL database..."
    
    # Load CSV into PostgreSQL (Assuming table name is the same as file name without extension)
    TABLE_NAME=$(basename "$FILE" .csv)
    psql -U $USER -d $DB_NAME -c "\copy $TABLE_NAME FROM '$FILE' WITH (FORMAT csv, HEADER true);"
    
    if [ $? -eq 0 ]; then
        echo "File $FILE successfully copied to PostgreSQL."
    else
        echo "Failed to copy $FILE to PostgreSQL."
    fi
done
